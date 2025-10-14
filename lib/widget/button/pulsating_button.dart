import 'package:flutter/material.dart';

/// Un botón animado con efecto de pulsación continua tipo latido.
///
/// [PulsatingButton] crea un botón que pulsa continuamente con una animación
/// de escala y opacidad, similar a un latido del corazón. El efecto crea una
/// capa exterior que se expande y contrae alrededor del botón principal,
/// atrayendo la atención del usuario.
///
/// ## Características principales:
///
/// - **Animación continua**: Pulsación infinita sin necesidad de interacción
/// - **Efecto de halo**: Capa exterior con opacidad que se desvanece al expandirse
/// - **Escala dinámica**: Expansión y contracción suave del tamaño
/// - **Radio animado**: Las esquinas se expanden sincronizadas con la pulsación
/// - **Altamente personalizable**: Control total sobre duración, tamaño, color y forma
///
/// ## Ejemplo básico:
///
/// ```dart
/// PulsatingButton(
///   onClick: () => print('¡Botón presionado!'),
///   child: Text(
///     'Comenzar',
///     style: TextStyle(color: Colors.white, fontSize: 16),
///   ),
/// )
/// ```
///
/// ## Ejemplo personalizado:
///
/// ```dart
/// PulsatingButton(
///   onClick: _handleAction,
///   color: Colors.red,
///   width: 200.0,
///   height: 70.0,
///   pulsationDuration: Duration(milliseconds: 1000),
///   pulsationSize: 20.0,
///   curve: Curves.easeInOutCubic,
///   borderRadius: BorderRadius.circular(35.0),
///   child: Row(
///     mainAxisAlignment: MainAxisAlignment.center,
///     children: [
///       Icon(Icons.play_arrow, color: Colors.white),
///       SizedBox(width: 8),
///       Text('Reproducir', style: TextStyle(color: Colors.white)),
///     ],
///   ),
/// )
/// ```
///
/// ## Ejemplo con borde:
///
/// ```dart
/// PulsatingButton(
///   onClick: _onPressed,
///   color: Colors.transparent,
///   border: Border.all(color: Colors.purple, width: 2),
///   width: 150.0,
///   height: 50.0,
///   pulsationSize: 15.0,
///   child: Text(
///     'Suscribirse',
///     style: TextStyle(color: Colors.purple),
///   ),
/// )
/// ```
///
/// ## Casos de uso ideales:
///
/// - Llamadas a la acción (CTA) principales
/// - Botones de "Comenzar" en pantallas de bienvenida
/// - Acciones urgentes o importantes que requieren atención
/// - Botones de notificaciones o alertas
/// - Elementos destacados en interfaces de juegos
///
/// ## Consideraciones de rendimiento:
///
/// - La animación se ejecuta constantemente, considere el impacto en batería
/// - Use con moderación (1-2 por pantalla máximo)
/// - No recomendado para listas largas o elementos repetidos
/// - El [RepaintBoundary] puede ayudar si tiene múltiples instancias
///
/// ## Parámetros clave:
///
/// - [pulsationSize]: Controla cuánto se expande el halo (default: 12.0)
/// - [pulsationDuration]: Velocidad de la pulsación (default: 800ms)
/// - [curve]: Curva de animación para el efecto (default: Curves.easeInOut)
///
/// Véase también:
///
/// - [AnimatedStateButton] para botones con múltiples estados
/// - [FocusButton] para botones con borde gradiente animado
/// - [RippleRevealButton] para efectos de revelación al presionar
class PulsatingButton extends StatefulWidget {
  /// Crea un botón con efecto de pulsación continua.
  ///
  /// El botón pulsará automáticamente al ser renderizado. La pulsación
  /// se ejecuta en un bucle infinito hasta que el widget sea destruido.
  const PulsatingButton({
    super.key,
    this.onClick,
    this.color = Colors.blue,
    this.pulsationDuration = const Duration(milliseconds: 800),
    this.width = 120.0,
    this.height = 60.0,
    this.border,
    this.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    this.child,
    this.curve = Curves.easeInOut,
    this.pulsationSize = 12.0,
  });

  /// Callback que se ejecuta cuando el botón es presionado.
  ///
  /// Si es `null`, el botón seguirá pulsando pero no responderá a toques.
  /// Útil para botones decorativos o estados deshabilitados.
  ///
  /// Ejemplo:
  /// ```dart
  /// onClick: () {
  ///   print('Botón presionado');
  ///   Navigator.push(context, ...);
  /// }
  /// ```
  final VoidCallback? onClick;

  /// Color principal del botón y del efecto de halo pulsante.
  ///
  /// El halo exterior usará este color con opacidad variable que se
  /// desvanece a medida que se expande. El botón central usará el
  /// color a opacidad completa.
  ///
  /// Default: `Colors.blue`
  final Color color;

  /// Duración de un ciclo completo de pulsación (expansión + contracción).
  ///
  /// Un valor menor crea una pulsación más rápida y enérgica.
  /// Un valor mayor crea una pulsación más lenta y relajada.
  ///
  /// Recomendaciones:
  /// - Rápida: 500-700ms (urgente, alerta)
  /// - Normal: 800-1000ms (CTA estándar)
  /// - Lenta: 1200-1500ms (ambiental, decorativo)
  ///
  /// Default: `Duration(milliseconds: 800)`
  final Duration pulsationDuration;

  /// Ancho del botón central (sin contar la expansión del halo).
  ///
  /// El tamaño total máximo del widget será [width] + [pulsationSize]
  /// cuando el halo esté completamente expandido.
  ///
  /// Default: `120.0`
  final double width;

  /// Alto del botón central (sin contar la expansión del halo).
  ///
  /// El tamaño total máximo del widget será [height] + [pulsationSize]
  /// cuando el halo esté completamente expandido.
  ///
  /// Default: `60.0`
  final double height;

  /// Borde opcional para el botón central.
  ///
  /// Útil para crear botones con estilo outline o contorno.
  /// El borde no se anima, permanece en el botón central.
  ///
  /// Ejemplo:
  /// ```dart
  /// border: Border.all(
  ///   color: Colors.white,
  ///   width: 2.0,
  /// )
  /// ```
  final BoxBorder? border;

  /// Radio de las esquinas del botón.
  ///
  /// El radio se anima junto con la pulsación. El halo exterior
  /// tendrá un radio mayor que se expande proporcionalmente.
  ///
  /// Default: `BorderRadius.all(Radius.circular(12.0))`
  ///
  /// Ejemplos:
  /// ```dart
  /// // Botón totalmente redondeado
  /// borderRadius: BorderRadius.circular(999)
  ///
  /// // Esquinas asimétricas
  /// borderRadius: BorderRadius.only(
  ///   topLeft: Radius.circular(20),
  ///   bottomRight: Radius.circular(20),
  /// )
  /// ```
  final BorderRadius? borderRadius;

  /// Widget hijo que se muestra dentro del botón.
  ///
  /// Típicamente un [Text], [Icon], o [Row]/[Column] con múltiples elementos.
  /// El contenido se centra automáticamente dentro del botón.
  ///
  /// Ejemplo:
  /// ```dart
  /// child: Row(
  ///   mainAxisSize: MainAxisSize.min,
  ///   children: [
  ///     Icon(Icons.favorite, color: Colors.white),
  ///     SizedBox(width: 8),
  ///     Text('Me gusta', style: TextStyle(color: Colors.white)),
  ///   ],
  /// )
  /// ```
  final Widget? child;

  /// Curva de animación aplicada a la pulsación.
  ///
  /// Controla la aceleración/desaceleración del efecto de expansión
  /// y contracción.
  ///
  /// Curvas recomendadas:
  /// - `Curves.easeInOut`: Suave y natural (default)
  /// - `Curves.easeInOutCubic`: Más pronunciada
  /// - `Curves.elasticInOut`: Efecto elástico divertido
  /// - `Curves.fastOutSlowIn`: Expansión rápida, contracción lenta
  ///
  /// Default: `Curves.easeInOut`
  final Curve curve;

  /// Cantidad de píxeles que se expande el halo en cada dirección.
  ///
  /// Este valor determina cuán grande es el efecto de pulsación.
  /// El halo se expandirá [pulsationSize] píxeles en todas las direcciones.
  ///
  /// Recomendaciones:
  /// - Sutil: 8-12px (discreto)
  /// - Normal: 12-20px (visible)
  /// - Dramático: 20-30px (muy llamativo)
  ///
  /// Nota: Un valor muy grande puede afectar el layout de widgets adyacentes.
  ///
  /// Default: `12.0`
  final double pulsationSize;

  @override
  State<PulsatingButton> createState() => _PulsatingButtonState();
}

class _PulsatingButtonState extends State<PulsatingButton> with SingleTickerProviderStateMixin {
  /// Controlador de la animación de pulsación.
  ///
  /// Configurado para repetir infinitamente con reversa (ida y vuelta).
  late AnimationController _controller;

  /// Animación con curva aplicada para el efecto de pulsación.
  ///
  /// Genera valores de 0.0 a 1.0 siguiendo la curva especificada.
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Inicializa el controlador con la duración configurada
    _controller = AnimationController(
      vsync: this,
      duration: widget.pulsationDuration,
    )..repeat(reverse: true); // Repetición infinita con reversa

    // Aplica la curva de animación al controlador
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
  }

  @override
  void dispose() {
    // Libera recursos del controlador para evitar memory leaks
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        // Cambia el cursor a pointer en web/desktop cuando pasa sobre el botón
        cursor: SystemMouseCursors.click,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            // Calcula el tamaño del halo expandido basado en el valor de animación
            final scaleWidth = widget.width + (_animation.value * widget.pulsationSize);
            final scaleHeight = widget.height + (_animation.value * widget.pulsationSize);

            // Calcula el radio de esquinas expandido para el halo
            final radius = (widget.borderRadius?.topLeft.x ?? 12.0) + (_animation.value * 4);

            return GestureDetector(
              onTap: widget.onClick,
              child: Container(
                // Contenedor exterior: halo pulsante
                width: scaleWidth,
                height: scaleHeight,
                decoration: BoxDecoration(
                  // Opacidad inversa: más transparente cuando está más expandido
                  color: widget.color.withOpacity(1 / (_animation.value + 1)),
                  borderRadius: widget.borderRadius?.copyWith(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius),
                    topLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius),
                  ),
                ),
                alignment: Alignment.center,
                child: Container(
                  // Contenedor interior: botón principal (tamaño fijo)
                  width: widget.width,
                  height: widget.height,
                  decoration: BoxDecoration(
                    border: widget.border,
                    borderRadius: widget.borderRadius,
                    color: widget.color,
                  ),
                  child: Center(child: widget.child),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
