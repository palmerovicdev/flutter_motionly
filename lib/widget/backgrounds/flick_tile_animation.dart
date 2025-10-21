import 'dart:math' as math;
import 'package:flutter/material.dart';

class FlickTileBox extends StatefulWidget {
  const FlickTileBox({
    super.key,
    this.rows = 12,
    this.columns = 8,
    this.tileSize,
    this.spacing = 6,
    this.color = const Color(0xFF6EA8FE),
    this.minOpacity = 0.08,
    this.maxOpacity = 0.95,
    this.minSpeed = 0.35,
    this.maxSpeed = 0.9,
    this.borderRadius = 4,
    this.seed,
    this.backgroundColor,
  });

  final int rows;
  final int columns;
  final double? tileSize;
  final double spacing;
  final Color color;
  final double minOpacity;
  final double maxOpacity;
  final double minSpeed;
  final double maxSpeed;
  final double borderRadius;
  final int? seed;
  final Color? backgroundColor;

  @override
  State<FlickTileBox> createState() => _FlickTileBoxState();
}

class _FlickTileBoxState extends State<FlickTileBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_TileData> _tiles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this)
      ..repeat(min: 0, max: 1, period: const Duration(milliseconds: 1000));
    _initTiles();
  }

  void _initTiles() {
    final rnd = math.Random(widget.seed);
    final minO = widget.minOpacity.clamp(0.0, 1.0);
    final maxO = widget.maxOpacity.clamp(0.0, 1.0);
    final opacityRange = maxO - minO;

    _tiles = List.generate(
      widget.rows * widget.columns,
      (_) => _TileData(
        speed: widget.minSpeed + rnd.nextDouble() * (widget.maxSpeed - widget.minSpeed),
        phase: rnd.nextDouble() * math.pi * 2,
        baseOpacity: minO + opacityRange * (0.45 + rnd.nextDouble() * 0.1),
        amplitude: opacityRange * (0.425 + rnd.nextDouble() * 0.15),
      ),
    );
  }

  @override
  void didUpdateWidget(FlickTileBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rows != widget.rows ||
        oldWidget.columns != widget.columns ||
        oldWidget.minOpacity != widget.minOpacity ||
        oldWidget.maxOpacity != widget.maxOpacity ||
        oldWidget.minSpeed != widget.minSpeed ||
        oldWidget.maxSpeed != widget.maxSpeed ||
        oldWidget.seed != widget.seed) {
      _initTiles();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => RepaintBoundary(
        child: CustomPaint(
          painter: _FlickTilePainter(
            time: DateTime.now().millisecondsSinceEpoch / 1000.0,
            tiles: _tiles,
            rows: widget.rows,
            columns: widget.columns,
            tileSize: widget.tileSize,
            spacing: widget.spacing,
            color: widget.color,
            borderRadius: widget.borderRadius,
            backgroundColor: widget.backgroundColor,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _TileData {
  const _TileData({
    required this.speed,
    required this.phase,
    required this.baseOpacity,
    required this.amplitude,
  });

  final double speed;
  final double phase;
  final double baseOpacity;
  final double amplitude;
}

class _FlickTilePainter extends CustomPainter {
  const _FlickTilePainter({
    required this.time,
    required this.tiles,
    required this.rows,
    required this.columns,
    required this.tileSize,
    required this.spacing,
    required this.color,
    required this.borderRadius,
    required this.backgroundColor,
  });

  final double time;
  final List<_TileData> tiles;
  final int rows;
  final int columns;
  final double? tileSize;
  final double spacing;
  final Color color;
  final double borderRadius;
  final Color? backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (backgroundColor != null) {
      canvas.drawRect(Offset.zero & size, Paint()..color = backgroundColor!);
    }

    final totalSpacingX = spacing * (columns - 1);
    final totalSpacingY = spacing * (rows - 1);
    final cellSize = tileSize ?? math.min(
      (size.width - totalSpacingX) / columns,
      (size.height - totalSpacingY) / rows,
    ).clamp(2.0, 200.0);

    final gridWidth = columns * cellSize + totalSpacingX;
    final gridHeight = rows * cellSize + totalSpacingY;
    final startX = (size.width - gridWidth) / 2;
    final startY = (size.height - gridHeight) / 2;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, cellSize, cellSize),
      Radius.circular(borderRadius),
    );
    final paint = Paint();

    int idx = 0;
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < columns; x++, idx++) {
        final tile = tiles[idx];
        final opacity = (tile.baseOpacity + tile.amplitude * math.sin(math.pi * 2 * tile.speed * time + tile.phase))
            .clamp(0.0, 1.0);

        if (opacity > 0.01) {
          paint.color = color.withOpacity(opacity);
          canvas.save();
          canvas.translate(startX + x * (cellSize + spacing), startY + y * (cellSize + spacing));
          canvas.drawRRect(rrect, paint);
          canvas.restore();
        }
      }
    }
  }

  @override
  bool shouldRepaint(_FlickTilePainter old) => time != old.time;
}
