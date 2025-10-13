# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/lang/es/).

### [0.0.5] - 2025-01-14

#### Añadido

##### Loaders
- **CircleMatrixLoader**: Loader animado con matriz de círculos que se desvanecen elegantemente
  - Matriz configurable de círculos perfectos (3x3, 4x4, 5x5, 6x6, etc.)
  - 8 direcciones de animación:
    - Verticales: `BOTTOM_UP`, `UP_BOTTOM`
    - Horizontales: `LEFT_RIGHT`, `RIGHT_LEFT`
    - Diagonales: `LEFT_UP_RIGHT_BOTTOM`, `RIGHT_BOTTOM_LEFT_UP`, `LEFT_BOTTOM_RIGHT_UP`, `RIGHT_UP_LEFT_BOTTOM`
  - Efecto de desvanecimiento fluido con animación de opacidad
  - Transformaciones de escala coordinadas con opacidad
  - Círculos perfectos con BorderRadius circular
  - Efecto orgánico y suave ideal para interfaces minimalistas
  - Curvas de animación personalizables
  - Color y tamaño configurables
  - Optimizado para rendimiento (recomendado 3-6 círculos por lado)
  - Perfecto para estados de carga elegantes y transiciones suaves

#### Mejorado
- Documentación inline completa del CircleMatrixLoader con ejemplos
- README actualizado con ejemplos detallados del nuevo loader
- Aplicación de ejemplo actualizada con página de demostración interactiva
- Grid visual de las 8 direcciones disponibles en la app de ejemplo
- Sección de mejores prácticas específicas para el efecto de desvanecimiento

### [0.0.4] - 2025-10-13

#### Añadido

##### Loaders
- **SquareMatrixLoader**: Loader animado con matriz de cuadrados que se expanden y contraen
  - Matriz configurable de cuadrados (3x3, 4x4, 5x5, 6x6, etc.)
  - 8 direcciones de animación:
    - Verticales: `BOTTOM_UP`, `UP_BOTTOM`
    - Horizontales: `LEFT_RIGHT`, `RIGHT_LEFT`
    - Diagonales: `LEFT_UP_RIGHT_BOTTOM`, `RIGHT_BOTTOM_LEFT_UP`, `LEFT_BOTTOM_RIGHT_UP`, `RIGHT_UP_LEFT_BOTTOM`
  - Transformaciones de escala suaves con ondas sinusoidales
  - Curvas de animación personalizables (linear, easeInOut, bounceInOut, etc.)
  - Tamaño de cuadrados y duración configurables
  - Color personalizable
  - Optimizado para rendimiento (recomendado 3-6 cuadrados por lado)
  - Perfecto para estados de carga modernos y pantallas splash

#### Mejorado
- Documentación inline completa del SquareMatrixLoader con ejemplos
- README actualizado con ejemplos detallados del nuevo loader
- Aplicación de ejemplo actualizada con página de demostración interactiva
- Grid visual de las 8 direcciones disponibles en la app de ejemplo
- Sección de mejores prácticas y recomendaciones de uso

### [0.0.3] - 2025-10-12

#### Añadido

##### Loaders
- **WaveSticksLoader**: Loader animado con efecto de onda gaussiana
  - Efecto de onda suave basado en distribución gaussiana
  - Ancho de onda configurable mediante parámetro `waveWidth` (0.5-3.0)
  - Número de sticks personalizable
  - Control de tamaños: ancho, altura mínima y altura máxima de onda
  - Espaciado entre sticks ajustable
  - Radio de esquinas configurable
  - Alineación vertical (start, center, end) para efectos creativos
  - `WaveStickAnimationController` para control manual de la animación
  - Métodos `start()` y `stopAnimation()` en el controller
  - Transiciones suaves garantizadas: la onda comienza y termina fuera del área visible
  - Perfecto para estados de carga y visualizadores de audio

#### Mejorado
- Documentación inline completa con ejemplos de código
- README actualizado con ejemplos del nuevo loader
- Aplicación de ejemplo actualizada con página de demostración interactiva

### [0.0.1] - 2025-10-12

#### Añadido

##### Botones Animados
- **RippleRevealButton**: Botón con efecto de ondulación circular que se expande desde el punto de toque
  - Soporte para dos estados (widgetA/widgetB)
  - Colores personalizables para fondo y ripple
  - Control de radio de esquinas
  - Padding y alineación configurables
  
- **RectRevealButton**: Botón con efecto de revelación rectangular
  - Tres direcciones de revelación: `fromClick`, `fromLeft`, `fromRight`
  - Transición suave entre estados
  - Altamente personalizable
  
- **FocusButton**: Botón con gradiente animado rotatorio en el borde
  - Gradiente multicolor configurable
  - Animación continua y suave
  - Grosor de borde ajustable
  - Duración de animación personalizable
  
- **AnimatedStateButton**: Botón con estados animados personalizables
  - Múltiples estados configurables
  - Transiciones suaves

##### Textos Animados
- **AnimatedText**: Texto con animaciones en cascada
  - 9 tipos de animación: `fade`, `blur`, `rotate`, `rotateVertical`, `decode`, `erode`, `dilate`, `erodeBlur`, `dilateBlur`
  - 3 modos de división: caracteres (`char`), palabras (`word`), líneas (`line`)
  - Control automático o manual mediante GlobalKey
  - Curvas de animación personalizables
  - Duración configurable por elemento
  
- **FuzzyText**: Texto con efectos dinámicos
  - Modo `glitch`: Efecto de fallo digital con capas de color desplazadas
  - Modo `height`: Fluctuación de escala animada
  - Amplitud configurable
  - Actualización continua a 60fps

##### Indicadores
- **CircularRevealIndicator**: Indicador circular animado por segmentos
  - Modo automático con rotación continua
  - Modo manual con control externo del índice
  - Número de segmentos configurable
  - Efecto halo ajustable con `activeSegments`
  - Colores activo/inactivo personalizables
  - Grosor de trazo variable

##### Características Generales
- Soporte completo para todas las plataformas Flutter (Android, iOS, Web, macOS, Linux, Windows)
- Documentación inline detallada con ejemplos de código
- Optimización de rendimiento con `RepaintBoundary` donde corresponde
- API intuitiva y fácil de usar
- Componentes altamente personalizables

##### Dependencias
- `flutter_svg: ^2.2.1` para renderizado de SVG

#### Notas Técnicas
- SDK mínimo requerido: Dart `^3.9.2`
- Flutter mínimo requerido: `>=1.17.0`
- Sin dependencias nativas (100% Dart puro)

#### Recursos
- 📦 Paquete pub.dev: https://pub.dev/packages/flutter_motionly
- 🌐 Demo web: https://flutter-motionly-web.onrender.com/
- 💻 Repositorio: https://github.com/palmerovicdev/flutter_motionly_web
- 📖 Documentación completa disponible en el README.md

---

[0.0.2]: https://github.com/palmerovicdev/flutter_motionly_web/releases/tag/v0.0.2
[0.0.1]: https://github.com/palmerovicdev/flutter_motionly_web/releases/tag/v0.0.1
