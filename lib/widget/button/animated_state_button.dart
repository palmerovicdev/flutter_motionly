import 'package:flutter/material.dart';

// -----------------------------
// Typedefs
// -----------------------------
typedef StateId = String;
typedef AsyncStateTask = Future<StateId> Function();
typedef StateWidgetBuilder = Widget Function(BuildContext context, ButtonState state);

// =====================================================
// ButtonState (DX: foregroundColor, builder, copyWith)
// =====================================================
class ButtonState {
  /// Identificador único del estado (p.ej. 'loading', 'success', 'error', ...).
  final StateId id;

  /// Color de fondo del botón en este estado.
  final Color color;

  /// Color sugerido para icono/texto del estado.
  final Color? foregroundColor;

  /// Contenido a mostrar (si no usas [builder]).
  final Widget? child;

  /// Builder para construir el contenido de forma dinámica.
  final StateWidgetBuilder? builder;

  /// Si `true`, el botón se muestra en modo compacto (circular).
  final bool isCompact;

  const ButtonState({
    required this.id,
    required this.color,
    this.foregroundColor,
    this.child,
    this.builder,
    this.isCompact = true,
  }) : assert(child != null || builder != null, 'Provee child o builder (al menos uno).');

  ButtonState copyWith({
    StateId? id,
    Color? color,
    Color? foregroundColor,
    Widget? child,
    StateWidgetBuilder? builder,
    bool? isCompact,
  }) {
    return ButtonState(
      id: id ?? this.id,
      color: color ?? this.color,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      child: child ?? this.child,
      builder: builder ?? this.builder,
      isCompact: isCompact ?? this.isCompact,
    );
  }

  // -------- Presets prácticos --------
  static ButtonState loading({
    Color color = Colors.lightBlue,
    Color fg = Colors.white,
    double size = 22,
    double stroke = 3,
    bool isCompact = true,
    Widget? child,
  }) => ButtonState(
    id: 'loading',
    color: color,
    foregroundColor: fg,
    isCompact: isCompact,
    child:
        child ??
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(strokeWidth: stroke, color: fg),
        ),
  );

  static ButtonState success({
    Color color = Colors.green,
    Color fg = Colors.white,
    double iconSize = 24,
    bool isCompact = true,
    Widget? child,
  }) => ButtonState(
    id: 'success',
    color: color,
    foregroundColor: fg,
    isCompact: isCompact,
    child: child ?? Icon(Icons.check_rounded, color: fg, size: iconSize),
  );

  static ButtonState error({
    Color color = Colors.red,
    Color fg = Colors.white,
    double iconSize = 24,
    bool isCompact = true,
    Widget? child,
  }) => ButtonState(
    id: 'error',
    color: color,
    foregroundColor: fg,
    isCompact: isCompact,
    child: child ?? Icon(Icons.close_rounded, color: fg, size: iconSize),
  );

  static ButtonState warning({
    Color color = Colors.orange,
    Color fg = Colors.white,
    double iconSize = 24,
    bool isCompact = true,
    Widget? child,
  }) => ButtonState(
    id: 'warning',
    color: color,
    foregroundColor: fg,
    isCompact: isCompact,
    child: child ?? Icon(Icons.warning_amber_rounded, color: fg, size: iconSize),
  );

  static ButtonState info({
    Color color = Colors.blueGrey,
    Color fg = Colors.white,
    double iconSize = 24,
    bool isCompact = true,
    Widget? child,
  }) => ButtonState(
    id: 'info',
    color: color,
    foregroundColor: fg,
    isCompact: isCompact,
    child: child ?? Icon(Icons.info_rounded, color: fg, size: iconSize),
  );

  @override
  bool operator ==(Object other) => identical(this, other) || (other is ButtonState && id == other.id);

  @override
  int get hashCode => id.hashCode;
}

// ==========================================================
// AnimatedStateButtonController (limpio y sin sorpresas)
// ==========================================================
class AnimatedStateButtonController extends ValueNotifier<StateId> {
  final Map<StateId, ButtonState> states;

  /// Estado de carga configurable (si no lo pasas, se autogenera).
  final ButtonState loadingState;

  /// Callback al cambiar de estado.
  final void Function(StateId newStateId)? onStateChanged;

  /// Delay por defecto para volver a `init` en `run*` si `resetToInit=true`.
  final Duration autoResetDelay;

  AnimatedStateButtonController({
    Map<StateId, ButtonState>? states,
    ButtonState? loadingState,
    this.onStateChanged,
    this.autoResetDelay = const Duration(milliseconds: 600),
  }) : states = {...?states},
       loadingState = loadingState ?? ButtonState.loading(),
       super('init') {
    this.states['loading'] = this.states['loading'] ?? this.loadingState;
  }

  StateId get currentStateId => value;

  ButtonState? get currentState => states[value];

  bool get isInit => value == 'init';

  bool get isLoading => value == 'loading';

  bool contains(StateId id) => id == 'init' || states.containsKey(id);

  void register(ButtonState state) => states[state.id] = state;

  void _set(StateId id) {
    if (value == id) return;
    value = id;
    onStateChanged?.call(id);
  }

  void init() => _set('init');

  void loading() => _set('loading');

  void changeState(StateId id) {
    if (!contains(id)) {
      throw ArgumentError('Estado "$id" no está definido');
    }
    _set(id);
  }

  bool safeChangeState(StateId id) {
    if (!contains(id)) return false;
    _set(id);
    return true;
  }

  /// Ejecuta una tarea que devuelve el `StateId` final.
  Future<void> run(
    AsyncStateTask task, {
    Duration? stateDelay,
    bool resetToInit = true,
  }) async {
    loading();
    StateId result = 'init';
    try {
      result = await task();
      changeState(result);
    } catch (_) {
      if (contains('error')) {
        result = 'error';
        changeState('error');
      } else {
        init();
        rethrow;
      }
    }
    await Future.delayed(stateDelay ?? autoResetDelay);
    if (resetToInit) init();
  }

  /// Task booleana → success/error.
  Future<void> runBool(
    Future<bool> Function() task, {
    StateId successId = 'success',
    StateId errorId = 'error',
    Duration? stateDelay,
    bool resetToInit = true,
  }) async {
    await run(() async => (await task()) ? successId : errorId, stateDelay: stateDelay, resetToInit: resetToInit);
  }

  /// Task que solo puede lanzar o terminar bien → success/error.
  Future<void> runGuarded(
    Future<void> Function() task, {
    StateId successId = 'success',
    StateId errorId = 'error',
    Duration? stateDelay,
    bool resetToInit = true,
  }) async {
    await run(
      () async {
        await task();
        return successId;
      },
      stateDelay: stateDelay,
      resetToInit: resetToInit,
    );
  }
}

// ==============================================
// AnimatedStateButton (compila y hace lo suyo)
// ==============================================
class AnimatedStateButton extends StatefulWidget {
  /// Ancho del botón en estado inicial (si null, usa el ancho disponible).
  final double? width;

  /// Controlador (en factory `simple` se crea interno).
  final AnimatedStateButtonController controller;

  /// Acción al presionar (en estado init).
  final Future<void> Function()? onClick;

  /// Alias por compatibilidad.
  @Deprecated('Usa onClick en su lugar')
  final Future<void> Function()? onPressed;

  /// Contenido del estado inicial.
  final Widget? initChild;

  /// Color de fondo en `init`.
  final Color initColor;

  /// Radio en `init`.
  final double borderRadius;

  /// Padding exterior (alrededor del contenedor animado).
  final EdgeInsetsGeometry padding;

  /// Altura constante del botón.
  final double height;

  /// Tamaño del botón cuando está compacto (círculo).
  final double compactSize;

  /// Duración/curva del contenedor animado.
  final Duration animationDuration;
  final Curve animationCurve;

  /// Duración/curvas del AnimatedSwitcher.
  final Duration switchDuration;
  final Curve switchInCurve;
  final Curve switchOutCurve;

  /// Estilo del FilledButton en `init`.
  final ButtonStyle? buttonStyle;

  /// Habilitado/deshabilitado.
  final bool enabled;

  /// Sombras del contenedor animado (no del FilledButton).
  final double? elevation;
  final Color? shadowColor;

  /// Micro-interacciones: escala en hover y press.
  final double hoverScale;
  final double pressScale;

  /// Prop interno: si el controller fue creado por la factory `simple`.
  final bool _ownController;

  const AnimatedStateButton({
    super.key,
    this.width,
    required this.controller,
    this.onClick,
    @Deprecated('Usa onClick en su lugar') this.onPressed,
    this.initChild,
    this.initColor = Colors.black,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
    this.height = 48,
    this.compactSize = 48,
    this.animationDuration = const Duration(milliseconds: 400),
    this.animationCurve = Curves.easeInOut,
    this.switchDuration = const Duration(milliseconds: 300),
    this.switchInCurve = Curves.easeOut,
    this.switchOutCurve = Curves.easeIn,
    this.buttonStyle,
    this.enabled = true,
    this.elevation,
    this.shadowColor,
    this.hoverScale = .02,
    this.pressScale = .04,
  }) : _ownController = false;

  /// Factory simple sin armar controller a mano.
  factory AnimatedStateButton.simple({
    Key? key,
    required Future<void> Function() onAction,
    Widget? label,
    Color initColor = Colors.black,
    double borderRadius = 8,
    double height = 48,
    double compactSize = 48,
    Duration animationDuration = const Duration(milliseconds: 400),
    Curve animationCurve = Curves.easeInOut,
    Duration switchDuration = const Duration(milliseconds: 300),
    Curve switchInCurve = Curves.easeOut,
    Curve switchOutCurve = Curves.easeIn,
    ButtonStyle? buttonStyle,
    bool enabled = true,
    double hoverScale = .02,
    double pressScale = .04,
    double? width,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
    void Function(StateId newStateId)? onStateChanged,
    Duration autoResetDelay = const Duration(milliseconds: 600),
    double? elevation,
    Color? shadowColor,
  }) {
    final controller = AnimatedStateButtonController(
      states: {
        'success': ButtonState.success(),
        'error': ButtonState.error(),
      },
      onStateChanged: onStateChanged,
      autoResetDelay: autoResetDelay,
    );

    return AnimatedStateButton._internal(
      key: key,
      width: width,
      controller: controller,
      onClick: () => controller.runGuarded(onAction),
      onPressed: () => controller.runGuarded(onAction),
      initChild: label ?? const Text('Enviar', style: TextStyle(color: Colors.white)),
      initColor: initColor,
      borderRadius: borderRadius,
      height: height,
      compactSize: compactSize,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      switchDuration: switchDuration,
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      buttonStyle: buttonStyle,
      enabled: enabled,
      hoverScale: hoverScale,
      pressScale: pressScale,
      padding: padding,
      elevation: elevation,
      shadowColor: shadowColor,
      ownController: true,
    );
  }

  const AnimatedStateButton._internal({
    super.key,
    this.width,
    required this.controller,
    this.onClick,
    this.onPressed,
    this.initChild,
    required this.initColor,
    required this.borderRadius,
    required this.padding,
    required this.height,
    required this.compactSize,
    required this.animationDuration,
    required this.animationCurve,
    required this.switchDuration,
    required this.switchInCurve,
    required this.switchOutCurve,
    this.buttonStyle,
    required this.enabled,
    this.elevation,
    this.shadowColor,
    required this.hoverScale,
    required this.pressScale,
    bool ownController = false,
  }) : _ownController = ownController;

  @override
  State<AnimatedStateButton> createState() => _AnimatedStateButtonState();
}

class _AnimatedStateButtonState extends State<AnimatedStateButton> {
  bool _isHover = false;
  bool _isPressed = false;

  Widget get _defaultLoading => const SizedBox(
    width: 22,
    height: 22,
    child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white),
  );

  Future<void> _handlePressed() async {
    if (!widget.enabled || widget.controller.value != 'init') return;
    final handler = widget.onClick ?? widget.onPressed;
    if (handler != null) {
      await handler();
      return;
    }
    widget.controller.loading();
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    if (widget.controller.contains('success')) {
      widget.controller.changeState('success');
      await Future.delayed(const Duration(milliseconds: 500));
    }
    if (!mounted) return;
    widget.controller.init();
  }

  @override
  void dispose() {
    if (widget._ownController) {
      widget.controller.dispose();
    }
    super.dispose();
  }

  double _currentScale() {
    double s = 1.0;
    if (_isHover) s -= widget.hoverScale;
    if (_isPressed) s -= widget.pressScale;
    if (s < 0.85) s = 0.85;
    return s;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: ValueListenableBuilder<StateId>(
        valueListenable: widget.controller,
        builder: (context, stateId, _) {
          final bool isInit = stateId == 'init';
          final state = widget.controller.states[stateId];
          final Color bgColor = isInit ? widget.initColor : (state?.color ?? widget.initColor);

          return LayoutBuilder(
            builder: (context, constraints) {
              final double fullWidth = widget.width ?? constraints.maxWidth;

              return MouseRegion(
                onEnter: (_) => setState(() => _isHover = true),
                onExit: (_) => setState(() {
                  _isHover = false;
                  _isPressed = false;
                }),
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (_) => setState(() => _isPressed = true),
                  onTapUp: (_) => setState(() => _isPressed = false),
                  onTapCancel: () => setState(() => _isPressed = false),
                  onTap: _handlePressed,
                  child: AnimatedScale(
                    scale: _currentScale(),
                    duration: const Duration(milliseconds: 120),
                    curve: Curves.easeOut,
                    child: AnimatedContainer(
                      duration: widget.animationDuration,
                      curve: widget.animationCurve,
                      width: isInit ? fullWidth : widget.compactSize,
                      height: widget.height,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(
                          isInit ? widget.borderRadius : widget.compactSize / 2,
                        ),
                        boxShadow: (widget.elevation != null && widget.shadowColor != null)
                            ? [
                                BoxShadow(
                                  color: widget.shadowColor!,
                                  blurRadius: widget.elevation!,
                                  offset: Offset(0, (widget.elevation! / 2).clamp(0, 100)),
                                ),
                              ]
                            : null,
                      ),
                      child: AnimatedSwitcher(
                        duration: widget.switchDuration,
                        switchInCurve: widget.switchInCurve,
                        switchOutCurve: widget.switchOutCurve,
                        layoutBuilder: (current, previous) => Stack(
                          alignment: Alignment.center,
                          children: [
                            ...previous,
                            if (current != null) current,
                          ],
                        ),
                        child: isInit ? _buildInitButton(stateId) : _buildStateWidget(state, stateId),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildInitButton(StateId stateId) {
    return SizedBox(
      key: ValueKey('wide-$stateId'),
      width: double.infinity,
      height: widget.height,
      child: FilledButton(
        onPressed: widget.enabled ? _handlePressed : null,
        style:
            widget.buttonStyle ??
            FilledButton.styleFrom(
              backgroundColor: widget.initColor,
              disabledBackgroundColor: widget.initColor.withOpacity(0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: widget.initChild ?? const Text('Enviar', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildStateWidget(ButtonState? state, StateId stateId) {
    final Widget child = state?.child ?? (state?.builder != null ? state!.builder!(context, state) : _defaultLoading);
    final Color? fg = state?.foregroundColor;

    return SizedBox(
      key: ValueKey('state-$stateId'),
      width: widget.compactSize,
      height: widget.compactSize,
      child: DefaultTextStyle.merge(
        style: TextStyle(color: fg),
        child: IconTheme.merge(
          data: IconThemeData(color: fg),
          child: Center(child: child),
        ),
      ),
    );
  }
}
