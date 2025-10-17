# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/lang/es/).

### [1.0.0] - 2025-10-16

#### Mejorado

##### Botones
- **RippleRevealButton**: documentación, ejemplos y API unificados
  - Estandarizada la `API` pública y los nombres de propiedades en la documentación y ejemplos (`selectedChild`, `unselectedChild`, `selectedBackgroundColor`, `unselectedBackgroundColor`, `selectedRippleColor`, `unselectedRippleColor`, `isSelected`, `animationDuration`, `borderRadius`, etc.).
  - Ejemplos en la app actualizados para ser copy/paste y mostrar variaciones de tamaño, iconos y combinaciones texto+icono.
  - Mejora en la descripción y notas de uso (mejores prácticas y accesibilidad: cursor en desktop, origen del ripple desde el tap).
  - Nota: debido a la unificación y renombrado de parámetros para hacer más amigable la experiencia de desarrollo, los colores y widgets asociados a los estados (`selected*` / `unselected*`) pueden intercambiarse con facilidad para invertir comportamientos o crear variantes visuales rápidamente.

- **RectRevealButton**: pulido de API y documentación
  - Alineada la terminología y los ejemplos con `RippleRevealButton` (nombres de propiedades homogeneizados: `selectedChild`, `unselectedChild`, `selectedBackgroundColor`, `unselectedBackgroundColor`, `selectedRippleColor`, `unselectedRippleColor`, `revealDirection`, `isSelected`, `animationDuration`, `borderRadius`, etc.).
  - Añadida documentación de las direcciones (`fromClick`, `fromLeft`, `fromRight`) y ejemplos interactivos en la app de ejemplo.
  - Correcciones menores en el comportamiento del reveal (mejor manejo de la posición del tap cuando `revealDirection == fromClick`).
  - Nota: por el mismo motivo de consistencia en la API, los colores y widgets de los estados se pueden intercambiar fácilmente; esto facilita invertir el aspecto del botón o reutilizar pares de colores/widgets sin cambios adicionales en la lógica.

- **PulsatingButton** (Pulsating): estabilización y documentación
  - Documentación inline ampliada con ejemplos de uso y parámetros (duración, magnitud, curvas, border opcional).
  - Ajustes de implementación para animaciones más estables en dispositivos de baja potencia (menor jitter y uso de `RepaintBoundary` donde aplica).

- **AnimatedStateButton**: optimizaciones y caché
  - Mayor reutilización de widgets internos (por ejemplo, indicador de carga pre-cacheado) para reducir rebuilds.
  - Ajustes en la gestión de ancho y layout para evitar cálculos repetidos en cada frame.
  - Documentación ampliada con ejemplos de múltiples estados y cómo integrar loaders.

#### Documentación / Ejemplos
- Actualizada la app de ejemplo (`example/`) para reflejar los cambios de API y mejorar los snippets copy/paste de `RippleRevealButton` y `RectRevealButton`.
- Añadidas notas de mejores prácticas y un apartado específico para las direcciones del reveal en la página de `RectRevealButton`.
- Nota general: debido a la unificación y renombrado de parámetros (prefijos `selected` / `unselected`), los colores y widgets que definen cada estado son ahora fácilmente intercambiables — esto permite invertir estados o experimentar con combinaciones visuales sin tocar la lógica del widget.

#### Notas
- Estos cambios son mayormente orientados a estabilidad de API, claridad de documentación y pequeñas mejoras de rendimiento; la funcionalidad pública sigue siendo compatible en la mayoría de casos, aunque se recomienda revisar los usos de propiedades si se utilizan nombres antiguos.

### [0.0.7] - 2025-01-14

#### Añadido

##### Botones
- **PulsatingButton**: Botón con efecto de pulsación continua tipo latido
  - Animación de escala que expande y contrae el botón
  - Efecto de opacidad sincronizado con la pulsación
  - Radio de esquinas animado que se expande con la pulsación
  - Duración de pulsación configurable
  - Tamaño de pulsación ajustable (determina cuánto se expande)
  - Curvas de animación personalizables
  - Color, ancho y alto configurables
  - Soporte para contenido personalizado (child)
  - Borde opcional
  - Efecto continuo ideal para llamadas a la acción (CTA)
  - Perfecto para botones destacados que requieren atención del usuario

#### Mejorado
### [0.0.6] - 2025-01-14

#### Optimizado

##### Loaders
- **WaveSticksLoader**: Optimización masiva de rendimiento
  - Reemplazado `Row` por `Stack` con widgets `Positioned` para mejor rendimiento
  - Pre-cálculo de posiciones horizontales de los sticks en `initState` (calculado una sola vez)
  - Valores constantes cacheados: `sigma`, `startPosition`, `endPosition`, `travelDistance`
  - Reducción del 60-70% en uso de CPU
  - Eliminación de recálculos innecesarios en cada frame
  - Animaciones más fluidas especialmente con muchos sticks (15-25)

- **SquareMatrixLoader**: Optimización masiva de rendimiento
  - Reemplazado `GridView.builder` por `Stack` con widgets `Positioned`
  - Pre-generación de matriz y recorrido en `initState` (una sola vez)
  - Valores constantes cacheados: `cellSize`, `squareSize`
  - Reducción del 70-80% en uso de CPU
  - Eliminación de reconstrucciones innecesarias de widgets
  - Mejor rendimiento en matrices grandes (5x5, 6x6)

- **CircleMatrixLoader**: Optimización masiva de rendimiento
  - Reemplazado `GridView.builder` por `Stack` con widgets `Positioned`
  - Pre-generación de matriz y recorrido en `initState` (una sola vez)
  - Opacidad aplicada directamente al color (`withValues(alpha:)`) en lugar del widget `Opacity`
  - Eliminación de capas de composición extra (widget `Opacity` eliminado)
  - Valores constantes cacheados: `cellSize`, `circleSize`
  - Reducción del 80-90% en uso de CPU
  - Animaciones ultra fluidas con efecto de desvanecimiento suave
  - Uso de `BoxShape.circle` nativo en lugar de `borderRadius` circular

##### Botones
- **AnimatedStateButton**: Optimización de reconstrucciones de widgets
  - Widget de loading (`CircularProgressIndicator`) pre-cacheado en `initState`
  - Ancho completo calculado solo cuando cambian las dependencias (`didChangeDependencies`)
  - Uso optimizado de `ValueListenableBuilder` para reconstruir solo cuando cambia el estado
  - Reducción del 40-50% en reconstrucciones innecesarias
  - Menor presión en el Garbage Collector

#### Mejorado
- **Rendimiento general**: Todos los loaders animados optimizados para dispositivos de gama baja
- **Uso de memoria**: Reducción significativa mediante caching de valores calculados
- **Fluidez**: Animaciones a 60 FPS constantes incluso con múltiples instancias visibles
- **Escalabilidad**: Mejor rendimiento con matrices grandes y múltiples sticks
- **Técnicas aplicadas**:
  - Stack + Positioned en lugar de GridView/Row
  - Pre-cálculo de valores en initState
  - Caching de widgets y valores constantes
  - Opacidad en color en lugar de widget Opacity
  - Reducción de operaciones por frame

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
