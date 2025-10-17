import 'dart:ui';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../common/utils.dart';

/// Tipos de división del texto para la animación.
///
/// Controla cómo se trocea el string de entrada antes de animarlo.
enum SplitType {
  /// Divide el texto por caracteres individuales.
  char,

  /// Divide el texto por palabras (usando espacio simple).
  word,

  /// Divide el texto por líneas (usando salto de línea `\n`).
  line,
}

/// Tipos de animación disponibles para el texto.
///
/// Cada elemento troceado (carácter/palabra/línea) se anima con la técnica indicada.
enum AnimationType {
  /// Desvanecimiento + pequeño deslizamiento vertical (suave y legible).
  fade,

  /// Desenfoque progresivo a nítido (requiere `ImageFiltered` / más coste de GPU).
  blur,

  /// Rotación horizontal (eje Y) con ligera perspectiva 3D.
  rotate,

  /// Rotación vertical (eje X) con ligera perspectiva 3D.
  rotateVertical,

  /// Erosión progresiva (requiere `ImageFiltered` / más coste de GPU).
  erode,

  /// Dilatación progresiva (requiere `ImageFiltered` / más coste de GPU).
  dilate,

  /// Erosión + desenfoque progresivo (requiere `ImageFiltered` / más coste de GPU).
  erodeBlur,

  /// Dilatación + desenfoque progresivo (requiere `ImageFiltered` / más coste de GPU).
  dilateBlur,

  /// Animación de distorsión con caracteres aleatorios.
  decode,
}

/// Texto animado que divide el string en partes y las anima en **cascada**.
///
/// Soporta múltiples **tipos de animación** ([AnimationType]) y **modos de división**
/// ([SplitType]). La cascada se logra aumentando 100ms por elemento respecto a
/// [duration], generando un efecto secuencial (1, 2, 3, ...).
///
/// ### Cómo funciona
/// - El texto se separa según [splitType]: `char`, `word` o `line`.
/// - Cada trozo se anima con `TweenAnimationBuilder`, usando [curve] y [duration]
///   + un **offset incremental** de 100ms por índice para la cascada.
/// - Si [autoPlay] es `true`, la animación arranca al montar el widget.
///   Para **control manual**, usa un `GlobalKey<AnimatedTextState>` y llama a [AnimatedTextState.play].
///
/// ### Consejos de UX
/// - `AnimationType.fade` es el más **limpio** y **performante**.
/// - `AnimationType.blur` luce brutal, pero implica **más coste** (post-procesado).
/// - Con fuentes grandes o mucho contenido, considera reducir `blurFactor` y/o
///   el número de elementos (usa `word` o `line` en vez de `char`).
///
/// ---
///
/// ### Ejemplo básico
/// ```dart
/// AnimatedText(
///   text: 'Hello World',
///   splitType: SplitType.char,
///   animationType: AnimationType.fade,
///   curve: Curves.easeOut,
///   duration: const Duration(milliseconds: 500),
///   fontSize: 32,
///   autoPlay: true,
/// )
/// ```
///
/// ### Ejemplo con control manual
/// ```dart
/// final textKey = GlobalKey<AnimatedTextState>();
///
/// AnimatedText(
///   key: textKey,
///   text: 'Animated Text',
///   autoPlay: false,
///   animationType: AnimationType.rotate,
///   splitType: SplitType.word,
/// );
///
/// // Lanzar animación más tarde:
/// textKey.currentState?.play();
/// ```
///
/// ### Ejemplo por líneas (subtítulos/versos)
/// ```dart
/// AnimatedText(
///   text: 'Primera línea\nSegunda línea\nTercera línea',
///   splitType: SplitType.line,
///   animationType: AnimationType.rotateVertical,
///   duration: const Duration(milliseconds: 350),
///   fontSize: 20,
/// )
/// ```
///
/// ### Notas
/// - El widget usa `Wrap` para disposición fluida; si usas `SplitType.line` se
///   inserta un `\n` tras cada trozo para conservar saltos.
/// - Para reejecutar la cascada, llama a [AnimatedTextState.play].
/// - `blur` usa `ImageFiltered` (puede afectar rendimiento en dispositivos modestos).
class AnimatedText extends StatefulWidget {
  /// Crea un [AnimatedText].
  ///
  /// [text] es el texto a animar.
  ///
  /// [splitType] define cómo se divide el texto (caracteres, palabras o líneas).
  ///
  /// [animationType] define el tipo de animación a aplicar.
  ///
  /// [curve] es la curva de animación que se aplicará a cada elemento.
  ///
  /// [duration] es la duración base de cada elemento. Cada elemento subsecuente
  /// añade 100ms adicionales para crear un efecto de cascada.
  ///
  /// [autoPlay] determina si la animación inicia automáticamente al montar el widget.
  ///
  /// [fontSize] es el tamaño de la fuente del texto.
  ///
  /// [blurFactor] controla la intensidad del desenfoque cuando se usa [AnimationType.blur].
  ///
  /// Para controlar la animación manualmente, usa un [GlobalKey] y llama a [AnimatedTextState.play()].
  ///
  /// #### Ejemplo
  /// ```dart
  /// AnimatedText(
  ///   text: 'Hello World',
  ///   splitType: SplitType.char,
  ///   animationType: AnimationType.fade,
  ///   curve: Curves.easeOut,
  ///   duration: Duration(milliseconds: 500),
  ///   fontSize: 32,
  ///   autoPlay: true,
  /// )
  /// ```
  ///
  /// #### Control manual
  /// ```dart
  /// final GlobalKey<AnimatedTextState> textKey = GlobalKey();
  ///
  /// AnimatedText(
  ///   key: textKey,
  ///   text: 'Animated Text',
  ///   autoPlay: false,
  /// )
  ///
  /// // Para lanzar la animación:
  /// textKey.currentState?.play();
  /// ```
  const AnimatedText({
    super.key,
    this.text = 'Animated Text',
    this.splitType = SplitType.char,
    this.curve = Curves.bounceIn,
    this.fontSize = 64,
    this.animationType = AnimationType.fade,
    this.duration = const Duration(milliseconds: 500),
    this.autoPlay = true,
    this.blurFactor = 100,
  });

  /// El texto a animar.
  final String text;

  /// Tipo de división del texto (caracteres, palabras o líneas).
  final SplitType splitType;

  /// Curva de animación aplicada a cada elemento.
  final Curve curve;

  /// Tamaño de la fuente del texto.
  final double fontSize;

  /// Tipo de animación a aplicar.
  final AnimationType animationType;

  /// Duración base de la animación para cada elemento.
  final Duration duration;

  /// Si la animación debe iniciarse automáticamente.
  final bool autoPlay;

  /// Factor de intensidad del desenfoque (solo para [AnimationType.blur]).
  final double blurFactor;

  @override
  State<AnimatedText> createState() => AnimatedTextState();
}

/// Estado del widget [AnimatedText].
///
/// Expone métodos para controlar la animación externamente mediante un [GlobalKey].
class AnimatedTextState extends State<AnimatedText> {
  int _animationKey = 0;

  /// Inicia la animación desde el principio (reinicia y ejecuta la cascada).
  void play() {
    setState(() {
      _animationKey++;
    });
  }

  /// Reinicia la animación al estado inicial.
  ///
  /// Sinónimo de [play]; reinicia todos los elementos del texto.
  void reset() {
    setState(() {
      _animationKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var split = widget.splitType == SplitType.char
        ? widget.text.characters.toList()
        : widget.text.split(
            widget.splitType == SplitType.word ? ' ' : '\n',
          );

    return Wrap(
      key: ValueKey(_animationKey),
      children: split.asMap().entries.map((entry) {
        final index = entry.key;
        final e = entry.value;

        return TweenAnimationBuilder<double>(
          tween: Tween(begin: widget.autoPlay ? 0 : 1, end: 1),
          duration: Duration(
            milliseconds: widget.duration.inMilliseconds + index * 100,
          ),
          curve: widget.curve,
          builder: (context, value, child) {
            return widget.animationType == AnimationType.decode
                ? Text(
                    value < 0.5
                        ? randomAscii(e.length)
                        : e +
                              (widget.splitType == SplitType.char
                                  ? ''
                                  : widget.splitType == SplitType.word
                                  ? ' '
                                  : '\n'),
                    style: TextStyle(
                      fontSize: value < 0.5 ? widget.fontSize - 4 * value : widget.fontSize,
                      color: Colors.white,
                      fontWeight: value < 0.5 ? FontWeight.w400 : FontWeight.w500,
                    ),
                  )
                : _buildAnimatedChild(value, e, child);
          },
          child: Text(
            e +
                (widget.splitType == SplitType.char
                    ? ''
                    : widget.splitType == SplitType.word
                    ? ' '
                    : '\n'),
            style: TextStyle(
              fontSize: widget.fontSize,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Construye el efecto visual por elemento según [animationType].
  ///
  /// - **fade**: opacidad + leve traslación Y (entra suave).
  /// - **blur**: desenfoque progresivo -> nítido + opacidad.
  /// - **rotate**/**rotateVertical**: flip 3D con perspectiva ligera.
  /// - **erode/dilate/erodeBlur/dilateBlur**: En web usa blur como fallback.
  Widget _buildAnimatedChild(double value, String text, Widget? child) {
    switch (widget.animationType) {
      case AnimationType.blur:
        return ClipRect(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: (1 - value) * widget.blurFactor,
              sigmaY: (1 - value) * widget.blurFactor,
            ),
            child: Opacity(
              opacity: value,
              child: child,
            ),
          ),
        );
      case AnimationType.decode:
        return ClipRect(
          child: child,
        );
      case AnimationType.erode:
        // En web, erode no está soportado, usamos blur como fallback
        if (kIsWeb) {
          return ClipRect(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: (1 - value) * widget.blurFactor * 0.5,
                sigmaY: (1 - value) * widget.blurFactor * 0.5,
              ),
              child: Opacity(
                opacity: value,
                child: Transform.scale(
                  scale: 0.8 + (value * 0.2),
                  child: child,
                ),
              ),
            ),
          );
        }
        return ClipRect(
          child: ImageFiltered(
            imageFilter: ImageFilter.erode(
              radiusX: (1 - value) * widget.blurFactor,
              radiusY: (1 - value) * widget.blurFactor,
            ),
            child: Opacity(
              opacity: value,
              child: child,
            ),
          ),
        );
      case AnimationType.dilate:
        // En web, dilate no está soportado, usamos blur como fallback
        if (kIsWeb) {
          return ClipRect(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: (1 - value) * widget.blurFactor * 0.5,
                sigmaY: (1 - value) * widget.blurFactor * 0.5,
              ),
              child: Opacity(
                opacity: value,
                child: Transform.scale(
                  scale: 1.2 - (value * 0.2),
                  child: child,
                ),
              ),
            ),
          );
        }
        return ClipRect(
          child: ImageFiltered(
            imageFilter: ImageFilter.dilate(
              radiusX: (1 - value) * widget.blurFactor,
              radiusY: (1 - value) * widget.blurFactor,
            ),
            child: Opacity(
              opacity: value,
              child: child,
            ),
          ),
        );
      case AnimationType.erodeBlur:
        // En web, erode no está soportado, usamos solo blur con escala
        if (kIsWeb) {
          return ClipRect(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: (1 - value) * widget.blurFactor,
                sigmaY: (1 - value) * widget.blurFactor,
              ),
              child: Opacity(
                opacity: value,
                child: Transform.scale(
                  scale: 0.8 + (value * 0.2),
                  child: child,
                ),
              ),
            ),
          );
        }
        return ClipRect(
          child: ImageFiltered(
            imageFilter: ImageFilter.compose(
              outer: ImageFilter.erode(
                radiusX: (1 - value) * widget.blurFactor,
                radiusY: (1 - value) * widget.blurFactor,
              ),
              inner: ImageFilter.blur(
                sigmaX: (1 - value) * widget.blurFactor,
                sigmaY: (1 - value) * widget.blurFactor,
              ),
            ),
            child: Opacity(
              opacity: value,
              child: child,
            ),
          ),
        );
      case AnimationType.dilateBlur:
        // En web, dilate no está soportado, usamos solo blur con escala
        if (kIsWeb) {
          return ClipRect(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: (1 - value) * widget.blurFactor,
                sigmaY: (1 - value) * widget.blurFactor,
              ),
              child: Opacity(
                opacity: value,
                child: Transform.scale(
                  scale: 1.2 - (value * 0.2),
                  child: child,
                ),
              ),
            ),
          );
        }
        return ClipRect(
          child: ImageFiltered(
            imageFilter: ImageFilter.compose(
              outer: ImageFilter.dilate(
                radiusX: (1 - value) * widget.blurFactor,
                radiusY: (1 - value) * widget.blurFactor,
              ),
              inner: ImageFilter.blur(
                sigmaX: (1 - value) * widget.blurFactor,
                sigmaY: (1 - value) * widget.blurFactor,
              ),
            ),
            child: Opacity(
              opacity: value,
              child: child,
            ),
          ),
        );
      case AnimationType.rotate:
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY((1 - value) * 3.14 / 2),
          alignment: Alignment.center,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      case AnimationType.rotateVertical:
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX((1 - value) * 3.14 / 2),
          alignment: Alignment.center,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      case AnimationType.fade:
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: child,
          ),
        );
    }
  }
}
