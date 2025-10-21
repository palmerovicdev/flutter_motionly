import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RippleShape {
  final Path? path;
  final BorderRadius? radius;
  final bool isCircle;

  const RippleShape._(this.path, this.radius, this.isCircle);

  factory RippleShape.fromPath(Path path) => RippleShape._(path, null, false);

  factory RippleShape.rounded({required BorderRadius radius}) => RippleShape._(null, radius, false);

  factory RippleShape.circle() => const RippleShape._(null, null, true);
}

class _RippleOverlayScope extends InheritedWidget {
  final void Function(Rect rect, RippleShape shape) addRipple;
  final RenderBox Function() getRenderBox;

  const _RippleOverlayScope({
    required this.addRipple,
    required this.getRenderBox,
    required super.child,
  });

  static _RippleOverlayScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_RippleOverlayScope>()!;
  }

  @override
  bool updateShouldNotify(_RippleOverlayScope oldWidget) => false;
}

class RippleOverlay extends StatefulWidget {
  final Widget child;
  final Duration waveDuration;
  final int wavesCount;
  final double extraPadding;
  final double strokeWidth;
  final Color color;

  const RippleOverlay({
    super.key,
    required this.child,
    this.waveDuration = const Duration(milliseconds: 600),
    this.wavesCount = 2,
    this.extraPadding = 10.0,
    this.strokeWidth = 2.0,
    this.color = const Color(0x66000000),
  });

  @override
  State<RippleOverlay> createState() => _RippleOverlayState();
}

class _RippleOverlayState extends State<RippleOverlay> with TickerProviderStateMixin {
  final GlobalKey _key = GlobalKey();
  final List<_Ripple> _ripples = [];

  void _addRipple(Rect rect, RippleShape shape) {
    for (int i = 0; i < widget.wavesCount; i++) {
      final controller = AnimationController(vsync: this, duration: widget.waveDuration);

      Future.delayed(
        Duration(milliseconds: i * (widget.waveDuration.inMilliseconds ~/ 2)),
        () => mounted ? controller.forward() : null,
      );

      final ripple = _Ripple(
        rect: rect,
        shape: shape,
        controller: controller,
        animation: CurvedAnimation(parent: controller, curve: Curves.easeOut),
        color: widget.color,
        strokeWidth: widget.strokeWidth,
        extraPadding: widget.extraPadding,
      );

      controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.dispose();
          if (mounted) setState(() => _ripples.remove(ripple));
        }
      });

      setState(() => _ripples.add(ripple));
    }
  }

  @override
  void dispose() {
    for (final r in _ripples) {
      r.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _RippleOverlayScope(
      addRipple: _addRipple,
      getRenderBox: () => _key.currentContext!.findRenderObject() as RenderBox,
      child: Stack(
        key: _key,
        clipBehavior: Clip.none,
        children: [
          widget.child,
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: Listenable.merge(_ripples.map((r) => r.controller)),
                builder: (_, __) => CustomPaint(
                  painter: _RipplesPainter(_ripples),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RippleTarget extends StatefulWidget {
  final Widget child;
  final RippleShape? shape;

  const RippleTarget({
    super.key,
    required this.child,
    this.shape,
  });

  @override
  State<RippleTarget> createState() => _RippleTargetState();
}

class _RippleTargetState extends State<RippleTarget> {
  final GlobalKey _key = GlobalKey();

  Path? _extractClipPath(RenderObject renderObject, Size size) {
    if (renderObject is RenderClipRRect) {
      return Path()..addRRect(renderObject.borderRadius.resolve(TextDirection.ltr).toRRect(Offset.zero & size));
    }

    if (renderObject is RenderClipOval) {
      return Path()..addOval(Offset.zero & size);
    }

    if (renderObject is RenderClipPath) {
      final clipper = renderObject.clipper;
      if (clipper != null) {
        return clipper.getClip(size);
      }
    }

    if (renderObject is RenderPhysicalModel || renderObject is RenderPhysicalShape) {
      if (renderObject is RenderPhysicalShape) {
        final clipper = renderObject.clipper;
        if (clipper != null) {
          return clipper.getClip(size);
        }
      }
    }

    RenderObject? child = renderObject;
    if (child is RenderObjectWithChildMixin) {
      final childRender = child.child;
      if (childRender != null) {
        return _extractClipPath(childRender, childRender.paintBounds.size);
      }
    }

    return null;
  }

  RippleShape _detectShape() {
    if (widget.shape != null) return widget.shape!;

    final renderObject = _key.currentContext?.findRenderObject();
    if (renderObject == null || renderObject is! RenderBox) {
      return RippleShape.rounded(radius: BorderRadius.circular(8));
    }

    final size = renderObject.size;

    final clipPath = _extractClipPath(renderObject, size);
    if (clipPath != null) {
      return RippleShape.fromPath(clipPath);
    }

    if ((size.width - size.height).abs() < 1.0) {
      return RippleShape.circle();
    }

    return RippleShape.rounded(radius: BorderRadius.circular(8));
  }

  void _trigger() {
    final scope = _RippleOverlayScope.of(context);
    final box = _key.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    final offset = box.localToGlobal(Offset.zero, ancestor: scope.getRenderBox());
    scope.addRipple(offset & box.size, _detectShape());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      behavior: HitTestBehavior.translucent,
      onTap: _trigger,
      child: widget.child,
    );
  }
}

class _Ripple {
  final Rect rect;
  final RippleShape shape;
  final AnimationController controller;
  final Animation<double> animation;
  final Color color;
  final double strokeWidth;
  final double extraPadding;

  _Ripple({
    required this.rect,
    required this.shape,
    required this.controller,
    required this.animation,
    required this.color,
    required this.strokeWidth,
    required this.extraPadding,
  });
}

class _RipplesPainter extends CustomPainter {
  final List<_Ripple> ripples;

  _RipplesPainter(this.ripples);

  Path _scalePath(Path path, Rect originalRect, Rect targetRect) {
    final scaleX = targetRect.width / originalRect.width;
    final scaleY = targetRect.height / originalRect.height;
    final matrix = Matrix4.identity()
      ..translate(targetRect.left, targetRect.top)
      ..scale(scaleX, scaleY)
      ..translate(-originalRect.left, -originalRect.top);

    return path.transform(matrix.storage);
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final r in ripples) {
      final t = r.animation.value;
      if (t <= 0) continue;

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = r.strokeWidth
        ..color = r.color.withValues(alpha: r.color.a * (1 - t));

      canvas.save();

      if (r.shape.path != null) {
        final target = r.rect.inflate(r.extraPadding);
        final currentRect = Rect.lerp(r.rect, target, t)!;

        canvas.clipPath(_scalePath(r.shape.path!, r.rect, target));
        canvas.drawPath(_scalePath(r.shape.path!, r.rect, currentRect), paint);
      } else if (r.shape.isCircle) {
        final radius = min(r.rect.width, r.rect.height) / 2;
        final maxRadius = radius + r.extraPadding;

        canvas.clipPath(Path()..addOval(Rect.fromCircle(center: r.rect.center, radius: maxRadius)));
        canvas.drawCircle(r.rect.center, radius + (r.extraPadding * t), paint);
      } else {
        final target = r.rect.inflate(r.extraPadding);
        final borderRadius = r.shape.radius ?? BorderRadius.zero;

        canvas.clipRRect(borderRadius.toRRect(target));
        canvas.drawRRect(borderRadius.toRRect(Rect.lerp(r.rect, target, t)!), paint);
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_RipplesPainter old) => old.ripples != ripples;
}
