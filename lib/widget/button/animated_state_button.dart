import 'package:flutter/material.dart';

/// Definición de un estado personalizado del botón.
///
/// Permite crear estados con nombres únicos, colores y widgets personalizados.
/// Cada estado representa una configuración visual del botón (color, contenido, tamaño).
///
/// Ejemplo de uso:
/// ```dart
/// final customState = ButtonState(
///   id: 'processing',
///   color: Colors.orange,
///   child: Icon(Icons.hourglass_empty, color: Colors.white),
///   isCompact: true,
/// );
/// ```
class ButtonState {
  /// Identificador único del estado.
  /// Se usa para cambiar entre estados mediante el controlador.
  final String id;

  /// Color de fondo del botón en este estado.
  final Color color;

  /// Widget a mostrar en este estado (opcional).
  /// Si es null, se mostrará un CircularProgressIndicator por defecto.
  final Widget? child;

  /// Si es true, el botón se muestra en modo compacto (circular).
  /// Si es false, mantiene el ancho completo.
  final bool isCompact;

  const ButtonState({
    required this.id,
    required this.color,
    this.child,
    this.isCompact = true,
  });

  /// Estado de carga predefinido.
  ///
  /// Muestra un CircularProgressIndicator animado en color azul claro.
  ///
  /// Ejemplo:
  /// ```dart
  /// final loadingState = ButtonState.loading();
  /// // o personalizado:
  /// final customLoading = ButtonState.loading(
  ///   color: Colors.blue,
  ///   child: SizedBox(
  ///     width: 20,
  ///     height: 20,
  ///     child: CircularProgressIndicator(strokeWidth: 2),
  ///   ),
  /// );
  /// ```
  static ButtonState loading({
    Color color = Colors.lightBlue,
    Widget? child,
  }) => ButtonState(
    id: 'loading',
    color: color,
    child:
        child ??
        const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: Colors.white,
          ),
        ),
    isCompact: true,
  );

  /// Estado de éxito predefinido.
  ///
  /// Muestra un icono de check en color verde.
  ///
  /// Ejemplo:
  /// ```dart
  /// final successState = ButtonState.success();
  /// // o personalizado:
  /// final customSuccess = ButtonState.success(
  ///   color: Colors.teal,
  ///   child: Icon(Icons.check_circle, color: Colors.white),
  /// );
  /// ```
  static ButtonState success({
    Color color = Colors.green,
    Widget? child,
  }) => ButtonState(
    id: 'success',
    color: color,
    child: child ?? const Icon(Icons.check, color: Colors.white, size: 28),
    isCompact: true,
  );

  /// Estado de error predefinido.
  ///
  /// Muestra un icono de error en color rojo.
  ///
  /// Ejemplo:
  /// ```dart
  /// final errorState = ButtonState.error();
  /// // o personalizado:
  /// final customError = ButtonState.error(
  ///   color: Colors.deepOrange,
  ///   child: Icon(Icons.close, color: Colors.white),
  /// );
  /// ```
  static ButtonState error({
    Color color = Colors.red,
    Widget? child,
  }) => ButtonState(
    id: 'error',
    color: color,
    child: child ?? const Icon(Icons.error, color: Colors.white, size: 28),
    isCompact: true,
  );

  @override
  bool operator ==(Object other) => identical(this, other) || other is ButtonState && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Controlador para manejar el estado del botón animado.
///
/// Permite controlar estados personalizados del botón y ejecutar tareas asíncronas
/// con manejo automático de estados de carga, éxito y error.
///
/// Ejemplo básico:
/// ```dart
/// final controller = AnimatedStateButtonController(
///   states: {
///     'success': ButtonState.success(),
///     'error': ButtonState.error(),
///   },
/// );
///
/// // Cambiar manualmente a un estado
/// controller.changeState('success');
/// ```
///
/// Ejemplo avanzado con estados personalizados:
/// ```dart
/// final controller = AnimatedStateButtonController(
///   states: {
///     'success': ButtonState.success(),
///     'error': ButtonState.error(),
///     'warning': ButtonState(
///       id: 'warning',
///       color: Colors.orange,
///       child: Icon(Icons.warning, color: Colors.white),
///     ),
///   },
///   stateCallbacks: {
///     'success': () => print('¡Operación exitosa!'),
///     'error': () => print('Hubo un error'),
///   },
/// );
///
/// // Ejecutar una tarea asíncrona
/// await controller.run(() async {
///   await Future.delayed(Duration(seconds: 2));
///   // Simular lógica de negocio
///   if (Random().nextBool()) {
///     return 'success';
///   } else {
///     return 'error';
///   }
/// });
/// ```
class AnimatedStateButtonController extends ValueNotifier<String> {
  /// Estados disponibles del botón.
  /// Cada clave es el id del estado y el valor es el ButtonState correspondiente.
  final Map<String, ButtonState> states;

  /// Estado de carga (siempre presente).
  /// Se puede personalizar pasando un loadingState en el constructor.
  final ButtonState loadingState;

  /// Estado actual del botón como String (id del estado).
  String get currentStateId => value;

  /// Obtiene el estado actual como objeto ButtonState.
  /// Retorna null si está en estado inicial.
  ButtonState? get currentState => states[value];

  /// Verifica si el botón está en estado inicial.
  bool get isInit => value == 'init';

  /// Verifica si el botón está cargando.
  bool get isLoading => value == 'loading';

  /// Callbacks opcionales que se ejecutan cuando se alcanza cada estado.
  /// La clave es el id del estado y el valor es la función a ejecutar.
  final Map<String, VoidCallback> stateCallbacks;

  /// Crea un controlador de estados para [AnimatedStateButton].
  ///
  /// [states] es un mapa de estados personalizados (opcional).
  /// [loadingState] permite personalizar el estado de carga (opcional).
  /// [stateCallbacks] son callbacks que se ejecutan al alcanzar cada estado (opcional).
  AnimatedStateButtonController({
    Map<String, ButtonState>? states,
    ButtonState? loadingState,
    this.stateCallbacks = const {},
  }) : states = states ?? {},
       loadingState = loadingState ?? ButtonState.loading(),
       super('init') {
    this.states['loading'] = this.states['loading'] ?? this.loadingState;
  }

  void _set(String stateId) {
    if (value == stateId) return;
    value = stateId;
  }

  /// Cambia el estado a inicial.
  void init() => _set('init');

  /// Cambia el estado a carga.
  void loading() => _set('loading');

  /// Cambia a un estado personalizado.
  ///
  /// Lanza un [ArgumentError] si el estado no está definido.
  ///
  /// Ejemplo:
  /// ```dart
  /// controller.changeState('success');
  /// controller.changeState('error');
  /// controller.changeState('warning'); // Si 'warning' está definido
  /// ```
  void changeState(String stateId) {
    if (!states.containsKey(stateId) && stateId != 'init') {
      throw ArgumentError('Estado "$stateId" no está definido');
    }
    _set(stateId);
  }

  /// Ejecuta una tarea asíncrona y maneja los estados automáticamente.
  ///
  /// [task] es la función asíncrona que debe retornar el id del estado final deseado.
  /// [stateDelay] es el tiempo que se muestra el estado final antes de volver a init.
  /// [resetToInit] si es false, no vuelve automáticamente al estado inicial.
  ///
  /// Si [task] lanza una excepción y existe un estado 'error', cambia a ese estado.
  /// De lo contrario, vuelve al estado inicial y relanza la excepción.
  ///
  /// Ejemplo:
  /// ```dart
  /// await controller.run(() async {
  ///   try {
  ///     final result = await apiCall();
  ///     return result.success ? 'success' : 'error';
  ///   } catch (e) {
  ///     return 'error';
  ///   }
  /// });
  /// ```
  ///
  /// Ejemplo sin reseteo automático:
  /// ```dart
  /// await controller.run(
  ///   () async {
  ///     await performOperation();
  ///     return 'success';
  ///   },
  ///   resetToInit: false, // Permanece en el estado final
  /// );
  /// ```
  Future<void> run(
    Future<String> Function() task, {
    Duration stateDelay = const Duration(milliseconds: 600),
    bool resetToInit = true,
  }) async {
    loading();
    String resultStateId = 'init';
    try {
      resultStateId = await task();
      changeState(resultStateId);
    } catch (_) {
      if (states.containsKey('error')) {
        resultStateId = 'error';
        changeState('error');
      } else {
        init();
        rethrow;
      }
    }

    await Future.delayed(stateDelay);

    stateCallbacks[resultStateId]?.call();

    if (resetToInit) {
      init();
    }
  }
}

/// Botón animado con estados personalizables y widgets customizables.
///
/// Este botón transiciona suavemente entre un botón de ancho completo y estados
/// compactos circulares, perfecto para indicar progreso de operaciones asíncronas.
///
/// Ejemplo básico:
/// ```dart
/// class MyWidget extends StatefulWidget {
///   @override
///   State<MyWidget> createState() => _MyWidgetState();
/// }
///
/// class _MyWidgetState extends State<MyWidget> {
///   late AnimatedStateButtonController _controller;
///
///   @override
///   void initState() {
///     super.initState();
///     _controller = AnimatedStateButtonController(
///       states: {
///         'success': ButtonState.success(),
///         'error': ButtonState.error(),
///       },
///     );
///   }
///
///   @override
///   void dispose() {
///     _controller.dispose();
///     super.dispose();
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return AnimatedStateButton(
///       controller: _controller,
///       initChild: Text('Enviar'),
///       onPressed: () async {
///         await _controller.run(() async {
///           await Future.delayed(Duration(seconds: 2));
///           return 'success';
///         });
///       },
///     );
///   }
/// }
/// ```
///
/// Ejemplo avanzado con personalización completa:
/// ```dart
/// AnimatedStateButton(
///   controller: controller,
///   initChild: Row(
///     mainAxisSize: MainAxisSize.min,
///     children: [
///       Icon(Icons.send),
///       SizedBox(width: 8),
///       Text('Enviar formulario'),
///     ],
///   ),
///   initColor: Colors.deepPurple,
///   borderRadius: 12,
///   height: 56,
///   elevation: 4,
///   shadowColor: Colors.deepPurple.withOpacity(0.4),
///   onPressed: () async {
///     await controller.run(() async {
///       // Lógica de envío
///       final success = await sendForm();
///       return success ? 'success' : 'error';
///     });
///   },
/// )
/// ```
class AnimatedStateButton extends StatefulWidget {
  /// Crea un [AnimatedStateButton].
  ///
  /// [controller] es requerido para manejar los estados del botón.
  ///
  /// [width] define el ancho del botón en estado inicial. Si es null,
  /// usa el ancho disponible menos el padding horizontal (por defecto).
  ///
  /// [onPressed] es la acción a ejecutar al presionar el botón.
  /// Si es null, ejecuta una animación de demostración.
  ///
  /// [initChild] es el widget mostrado en estado inicial.
  /// Por defecto muestra el texto 'Enviar'.
  ///
  /// [initColor] es el color de fondo en estado inicial.
  ///
  /// [borderRadius] define el radio de las esquinas del botón en estado inicial.
  ///
  /// [height] es la altura del botón (constante en todos los estados).
  ///
  /// [compactSize] es el tamaño del botón cuando está en estado compacto.
  ///
  /// [animationDuration] controla la duración de la animación de cambio de tamaño.
  ///
  /// [switchDuration] controla la duración de la transición entre widgets.
  ///
  /// [enabled] controla si el botón está habilitado o deshabilitado.
  ///
  /// [elevation] y [shadowColor] configuran la sombra del botón.
  const AnimatedStateButton({
    super.key,
    this.width,
    required this.controller,
    this.onPressed,
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
  }) : assert(height > 0, 'La altura debe ser mayor a 0'),
       assert(compactSize > 0, 'El tamaño compacto debe ser mayor a 0');

  /// Ancho del botón en estado inicial.
  /// Si es null, usa el ancho disponible menos el padding horizontal.
  final double? width;

  /// Controlador de estado del botón.
  final AnimatedStateButtonController controller;

  /// Acción asíncrona al presionar el botón.
  /// Si es null, ejecuta una animación de demostración.
  final Future<void> Function()? onPressed;

  /// Widget mostrado en estado inicial.
  /// Por defecto muestra el texto 'Enviar'.
  final Widget? initChild;

  /// Color de fondo en estado inicial.
  final Color initColor;

  /// Radio de las esquinas del botón en estado inicial.
  final double borderRadius;

  /// Padding exterior del botón.
  final EdgeInsetsGeometry padding;

  /// Altura del botón (constante en todos los estados).
  final double height;

  /// Tamaño del botón cuando está en estado compacto (circular).
  final double compactSize;

  /// Duración de la animación de cambio de tamaño del contenedor.
  final Duration animationDuration;

  /// Curva de animación del cambio de tamaño.
  final Curve animationCurve;

  /// Duración de la transición entre widgets (AnimatedSwitcher).
  final Duration switchDuration;

  /// Curva para la entrada de widgets.
  final Curve switchInCurve;

  /// Curva para la salida de widgets.
  final Curve switchOutCurve;

  /// Estilo personalizado del botón en estado inicial.
  /// Si es null, usa un estilo predeterminado basado en [initColor] y [borderRadius].
  final ButtonStyle? buttonStyle;

  /// Si es false, el botón estará deshabilitado y no se podrá presionar.
  final bool enabled;

  /// Elevación del botón en estado inicial.
  final double? elevation;

  /// Color de sombra del botón.
  final Color? shadowColor;

  @override
  State<AnimatedStateButton> createState() => _AnimatedStateButtonState();
}

/// Estado del widget [AnimatedStateButton].
///
/// Maneja los listeners del controlador y renderiza el botón según su estado actual.
class _AnimatedStateButtonState extends State<AnimatedStateButton> {
  late final Widget _loadingWidget;
  late final double _fullWidth;

  @override
  void initState() {
    super.initState();

    _loadingWidget = const SizedBox(
      width: 22,
      height: 22,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        color: Colors.white,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fullWidth = widget.width ?? MediaQuery.sizeOf(context).width - 48;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: ValueListenableBuilder<String>(
        valueListenable: widget.controller,
        builder: (context, currentStateId, child) {
          final isInit = currentStateId == 'init';
          final currentState = widget.controller.states[currentStateId];
          final bgColor = isInit ? widget.initColor : (currentState?.color ?? widget.initColor);

          return AnimatedContainer(
            duration: widget.animationDuration,
            curve: widget.animationCurve,
            width: isInit ? _fullWidth : widget.compactSize,
            height: widget.height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(
                isInit ? widget.borderRadius : widget.compactSize / 2,
              ),
              boxShadow: widget.elevation != null && widget.shadowColor != null
                  ? [
                      BoxShadow(
                        color: widget.shadowColor!,
                        blurRadius: widget.elevation!,
                        offset: Offset(0, widget.elevation! / 2),
                      ),
                    ]
                  : null,
            ),
            child: AnimatedSwitcher(
              duration: widget.switchDuration,
              switchInCurve: widget.switchInCurve,
              switchOutCurve: widget.switchOutCurve,
              layoutBuilder: (currentChild, previousChildren) => Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
              ),
              child: isInit ? _buildInitButton(currentStateId) : _buildStateWidget(currentState, currentStateId),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInitButton(String stateId) {
    return SizedBox(
      key: ValueKey('wide-button-$stateId'),
      width: double.infinity,
      height: widget.height,
      child: FilledButton(
        onPressed: widget.enabled ? _handlePressed : null,
        style:
            widget.buttonStyle ??
            FilledButton.styleFrom(
              backgroundColor: widget.initColor,
              disabledBackgroundColor: widget.initColor.withValues(alpha: 0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              elevation: widget.elevation,
              shadowColor: widget.shadowColor,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: widget.initChild ?? const Text('Enviar'),
        ),
      ),
    );
  }

  Widget _buildStateWidget(ButtonState? state, String stateId) {
    final child = state?.child ?? _loadingWidget;

    return SizedBox(
      key: ValueKey('state-$stateId'),
      width: widget.compactSize,
      height: widget.compactSize,
      child: Center(child: child),
    );
  }

  Future<void> _handlePressed() async {
    if (!widget.enabled || widget.controller.value != 'init') return;

    if (widget.onPressed != null) {
      await widget.onPressed!();
      return;
    }

    widget.controller.loading();
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;

    final firstState = widget.controller.states.keys.where((k) => k != 'loading').firstOrNull;
    if (firstState != null) {
      widget.controller.changeState(firstState);
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;
    }

    widget.controller.init();
  }
}
