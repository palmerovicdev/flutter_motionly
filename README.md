<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Flutter Motionly

[![pub package](https://img.shields.io/pub/v/flutter_motionly.svg)](https://pub.dev/packages/flutter_motionly)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Una colección de widgets animados personalizados para Flutter que añaden interactividad y efectos visuales modernos a tus aplicaciones.

## 🎯 Descripción

**Flutter Motionly** es un paquete que proporciona componentes de UI altamente personalizables con animaciones fluidas y efectos visuales impactantes. Perfecto para crear interfaces modernas, interactivas y con un feedback visual superior.

## ✨ Características

### 🔘 Botones Animados

- **RippleRevealButton** - Efecto de ondulación circular que se expande desde el punto de toque
- **RectRevealButton** - Revelación rectangular con múltiples direcciones (desde clic, izquierda, derecha)
- **FocusButton** - Gradiente animado rotatorio en el borde
- **AnimatedStateButton** - Botón con estados animados personalizables
- **PulsatingButton** - Botón con efecto de pulsación continua tipo latido

### 🎨 Fondos Animados

- **ParticleBox** - Sistema de partículas animadas para fondos dinámicos e interactivos
  - Partículas con movimiento continuo y aleatorio
  - Colores múltiples configurables
  - Interactividad con mouse/hover
  - Optimizado para cientos de partículas
- **FlickTileBox** - Grid de tiles parpadeantes con velocidad y opacidad variables
  - Matriz configurable de filas y columnas
  - Cada tile con velocidad única de parpadeo
  - Control preciso de opacidad y velocidad
  - Bordes redondeados personalizables

### 📝 Textos Animados

- **AnimatedText** - Texto con 9 tipos de animación en cascada (fade, blur, rotate, decode, etc.)
  - Modos de división: caracteres, palabras o líneas
  - Control manual o automático
- **FuzzyText** - Efectos glitch y fluctuación para textos dinámicos

### ⏳ Loaders

- **WaveSticksLoader** - Loader con efecto de onda gaussiana suave
  - Ancho de onda configurable
  - Perfecto para estados de carga y visualizadores de audio
  - Múltiples opciones de alineación
- **SquareMatrixLoader** - Loader con matriz de cuadrados que se expanden y contraen
  - 8 direcciones de animación (vertical, horizontal y diagonales)
  - Tamaño de matriz configurable (3x3, 4x4, 5x5, etc.)
  - Curvas de animación personalizables
  - Perfecto para estados de carga modernos
- **CircleMatrixLoader** - Loader con matriz de círculos que se desvanecen elegantemente
  - 8 direcciones de animación con efecto de opacidad
  - Desvanecimiento fluido y orgánico
  - Círculos perfectos con animación coordinada
  - Ideal para interfaces suaves y minimalistas

### ⭕ Indicadores

- **CircularRevealIndicator** - Indicador circular por segmentos con revelación animada
  - Modo automático o manual
  - Efecto halo configurable

## 📦 Instalación

Añade esta línea a tu archivo `pubspec.yaml`:

```yaml
dependencies:
  flutter_motionly: ^1.1.1
```

Luego ejecuta:

```bash
flutter pub get
```

## 🚀 Uso

### RippleRevealButton

Botón con efecto de ondulación que alterna entre dos estados (API unificada):

```dart
import 'package:flutter_motionly/widget/button/ripple_reveal_button.dart';

RippleRevealButton(
  selectedChild: const Text('ON', style: TextStyle(color: Colors.white)),
  unselectedChild: const Text('OFF', style: TextStyle(color: Colors.black)),
  selectedBackgroundColor: Colors.black,
  unselectedBackgroundColor: Colors.white,
  selectedRippleColor: Colors.white,
  unselectedRippleColor: Colors.black,
  height: 45,
  borderRadius: 8,
  animationDuration: Duration(milliseconds: 300),
  isSelected: false, // opcional: controla desde fuera
  onPressed: () {
    print('Estado alternado!');
  },
)
```

### FocusButton

Botón con gradiente animado en el borde:

```dart
import 'package:flutter_motionly/widget/button/focus_button.dart';

FocusButton(
  child: const Text('Premium', style: TextStyle(color: Colors.white)),
  onPressed: () => upgradeToPremium(),
  gradientColors: [
    Colors.cyan,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.cyan,
  ],
  borderWidth: 3.0,
  borderRadius: 12.0,
  backgroundColor: Colors.black87,
  height: 56,
  duration: Duration(seconds: 3),
)
```

### AnimatedText

Texto con animaciones en cascada:

```dart
import 'package:flutter_motionly/widget/text/animated_text.dart';

AnimatedText(
  text: 'Hola Mundo',
  splitType: SplitType.char,
  animationType: AnimationType.fade,
  style: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  duration: Duration(milliseconds: 800),
  curve: Curves.easeOutCubic,
  autoPlay: true,
)
```

Tipos de animación disponibles:
- `fade` - Desvanecimiento con deslizamiento
- `blur` - Desenfoque progresivo
- `rotate` - Rotación horizontal 3D
- `rotateVertical` - Rotación vertical 3D
- `decode` - Efecto de decodificación con caracteres aleatorios
- `erode`, `dilate`, `erodeBlur`, `dilateBlur` - Efectos de filtro

### FuzzyText

Texto con efectos glitch o fluctuación:

```dart
import 'package:flutter_motionly/widget/text/fuzzy_text.dart';

// Efecto glitch
FuzzyText.glitch(
  'ERROR 404',
  style: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  amplitude: 8.0,
)

// Efecto de fluctuación
FuzzyText.height(
  'Cargando...',
  style: TextStyle(fontSize: 24, color: Colors.blue),
  amplitude: 6.0,
)
```

### ParticleBox

Sistema de partículas animadas para fondos dinámicos:

```dart
import 'package:flutter_motionly/widget/backgrounds/particles_animation.dart';

// Fondo básico de partículas
ParticleBox(
  maxHeight: 400,
  maxWidth: MediaQuery.of(context).size.width,
  velocityFactor: 0.3,
  particleCount: 150,
  heightFactor: 5,
  colors: [
    Colors.blue.withValues(alpha: 0.6),
    Colors.purple.withValues(alpha: 0.6),
    Colors.pink.withValues(alpha: 0.6),
  ],
  backgroundColor: Colors.black,
)

// Efecto de estrellas
ParticleBox(
  maxHeight: 600,
  maxWidth: 800,
  velocityFactor: 0.15,
  particleCount: 100,
  heightFactor: 3,
  colors: [
    Colors.white.withValues(alpha: 0.8),
    Colors.blue[100]!.withValues(alpha: 0.6),
  ],
  backgroundColor: Colors.black,
)

// Partículas rápidas y energéticas
ParticleBox(
  maxHeight: 300,
  maxWidth: 600,
  velocityFactor: 0.5,
  particleCount: 300,
  heightFactor: 8,
  colors: [
    Colors.red.withValues(alpha: 0.7),
    Colors.orange.withValues(alpha: 0.7),
    Colors.yellow.withValues(alpha: 0.7),
  ],
)
```

Parámetros configurables:
- `particleCount` - Cantidad de partículas (50-300 recomendado)
- `velocityFactor` - Velocidad de movimiento (0.1-0.5 recomendado)
- `heightFactor` - Variación de tamaño de partículas (3-8 recomendado)
- `colors` - Lista de colores para las partículas
- `backgroundColor` - Color de fondo opcional

### FlickTileBox

Grid de tiles parpadeantes para fondos tipo mosaico:

```dart
import 'package:flutter_motionly/widget/backgrounds/flick_tile_animation.dart';

// Fondo básico de tiles
FlickTileBox(
  rows: 12,
  columns: 8,
  spacing: 6,
  color: Colors.blue,
  minOpacity: 0.1,
  maxOpacity: 0.9,
  minSpeed: 0.3,
  maxSpeed: 0.8,
  borderRadius: 4,
  backgroundColor: Colors.black,
)

// Efecto de matriz digital
FlickTileBox(
  rows: 20,
  columns: 30,
  spacing: 2,
  color: Colors.green,
  minOpacity: 0.1,
  maxOpacity: 0.8,
  minSpeed: 0.25,
  maxSpeed: 0.75,
  borderRadius: 1,
)

// Mosaico minimalista
FlickTileBox(
  rows: 4,
  columns: 6,
  spacing: 12,
  color: Colors.purple,
  minOpacity: 0.15,
  maxOpacity: 0.6,
  minSpeed: 0.2,
  maxSpeed: 0.5,
  borderRadius: 8,
)
```

Parámetros configurables:
- `rows` y `columns` - Tamaño del grid (50-150 tiles total recomendado en móviles)
- `spacing` - Espaciado entre tiles (2-8px recomendado)
- `minOpacity` y `maxOpacity` - Rango de opacidad (0.0-1.0)
- `minSpeed` y `maxSpeed` - Rango de velocidad de parpadeo (0.2-1.0)
- `borderRadius` - Radio de bordes de cada tile
- `tileSize` - Tamaño manual de tiles (null = auto-calculado)
- `seed` - Semilla para aleatoriedad reproducible

### WaveSticksLoader

Loader con efecto de onda gaussiana:

```dart
import 'package:flutter_motionly/widget/loaders/wave_stick_loader.dart';

// Loader básico
WaveSticksLoader(
  size: Size(350, 100),
  duration: Duration(milliseconds: 1500),
  numberOfSticks: 10,
  stickWidth: 5,
  stickHeight: 30,
  middleWaveStickHeight: 45,
  stickSpacing: 8,
  stickColor: Colors.blue,
  waveWidth: 1.5,
)

// Efecto de visualizador de audio
WaveSticksLoader(
  size: Size(400, 120),
  numberOfSticks: 20,
  stickWidth: 4,
  stickHeight: 20,
  middleWaveStickHeight: 60,
  stickColor: Colors.orange,
  waveWidth: 2.0,
)

// Con controller personalizado
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> 
    with TickerProviderStateMixin {
  late WaveStickAnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WaveStickAnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..start();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WaveSticksLoader(controller: _controller);
  }
}
```

Parámetros configurables:
- `waveWidth` - Ancho de la onda (0.5-3.0 recomendado)
- `alignment` - Alineación vertical (start, center, end)
- `radius` - Radio de las esquinas de cada stick

### SquareMatrixLoader

Loader con matriz de cuadrados que se expanden y contraen:

```dart
import 'package:flutter_motionly/widget/loaders/square_matrix_loader.dart';
import 'package:flutter_motionly/common/utils.dart';

// Loader básico
SquareMatrixLoader(
  numberOfSquares: 4,
  squareHeight: 40,
  duration: Duration(milliseconds: 1500),
  color: Colors.blue,
  direction: TraverseDirection.LEFT_UP_RIGHT_BOTTOM,
)

// Con efecto diagonal
SquareMatrixLoader(
  numberOfSquares: 5,
  squareHeight: 35,
  duration: Duration(milliseconds: 1800),
  color: Colors.orange,
  direction: TraverseDirection.RIGHT_BOTTOM_LEFT_UP,
  curve: Curves.easeInOut,
)

// Con matriz grande
SquareMatrixLoader(
  numberOfSquares: 6,
  squareHeight: 25,
  duration: Duration(milliseconds: 2000),
  color: Colors.purple,
  direction: TraverseDirection.UP_BOTTOM,
  curve: Curves.linear,
)
```

Direcciones de animación disponibles:
- `TraverseDirection.BOTTOM_UP` - De abajo hacia arriba
- `TraverseDirection.UP_BOTTOM` - De arriba hacia abajo
- `TraverseDirection.LEFT_RIGHT` - De izquierda a derecha
- `TraverseDirection.RIGHT_LEFT` - De derecha a izquierda
- `TraverseDirection.LEFT_UP_RIGHT_BOTTOM` - Diagonal: superior izquierda a inferior derecha
- `TraverseDirection.RIGHT_BOTTOM_LEFT_UP` - Diagonal: inferior derecha a superior izquierda
- `TraverseDirection.LEFT_BOTTOM_RIGHT_UP` - Diagonal: inferior izquierda a superior derecha
- `TraverseDirection.RIGHT_UP_LEFT_BOTTOM` - Diagonal: superior derecha a inferior izquierda

Parámetros configurables:
- `numberOfSquares` - Tamaño de la matriz (3-6 recomendado)
- `squareHeight` - Tamaño de cada cuadrado en píxeles
- `curve` - Curva de animación (linear, easeInOut, bounceInOut, etc.)

### CircleMatrixLoader

Loader con matriz de círculos que se desvanecen:

```dart
import 'package:flutter_motionly/widget/loaders/circle_matrix_loader.dart';

// Loader básico
CircleMatrixLoader(
  numberOfCircles: 4,
  circleRadius: 20,
  duration: Duration(milliseconds: 1500),
  color: Colors.blue,
  direction: TraverseDirection.LEFT_UP_RIGHT_BOTTOM,
)

// Con efecto de desvanecimiento
CircleMatrixLoader(
  numberOfCircles: 5,
  circleRadius: 18,
  duration: Duration(milliseconds: 1800),
  color: Colors.orange,
  direction: TraverseDirection.RIGHT_BOTTOM_LEFT_UP,
  curve: Curves.easeInOut,
)

// Con matriz grande
CircleMatrixLoader(
  numberOfCircles: 6,
  circleRadius: 15,
  duration: Duration(milliseconds: 2000),
  color: Colors.purple,
  direction: TraverseDirection.UP_BOTTOM,
  curve: Curves.linear,
)
```

Direcciones de animación disponibles:
- `TraverseDirection.BOTTOM_UP` - De abajo hacia arriba
- `TraverseDirection.UP_BOTTOM` - De arriba hacia abajo
- `TraverseDirection.LEFT_RIGHT` - De izquierda a derecha
- `TraverseDirection.RIGHT_LEFT` - De derecha a izquierda
- `TraverseDirection.LEFT_UP_RIGHT_BOTTOM` - Diagonal: superior izquierda a inferior derecha
- `TraverseDirection.RIGHT_BOTTOM_LEFT_UP` - Diagonal: inferior derecha a superior izquierda
- `TraverseDirection.LEFT_BOTTOM_RIGHT_UP` - Diagonal: inferior izquierda a superior derecha
- `TraverseDirection.RIGHT_UP_LEFT_BOTTOM` - Diagonal: superior derecha a inferior izquierda

Parámetros configurables:
- `numberOfCircles` - Tamaño de la matriz (3-6 recomendado)
- `circleRadius` - Radio de cada círculo en píxeles
- `curve` - Curva de animación (linear, easeInOut, bounceInOut, etc.)

### CircularRevealIndicator

Indicador circular animado:

```dart
import 'package:flutter_motionly/widget/indicator/circular_reveal_indicator.dart';

// Modo automático
CircularRevealIndicator(
  size: 120,
  segmentCount: 12,
  activeColor: Colors.blue,
  inactiveColor: Colors.grey.shade300,
  strokeWidth: 4,
  animationDuration: Duration(seconds: 2),
)

// Modo manual (controlado externamente)
CircularRevealIndicator(
  size: 80,
  segmentCount: 60,
  currentIndex: myCurrentIndex,
  animate: false,
  activeSegments: 4,
)
```

### RectRevealButton

Botón con revelación rectangular (API unificada):

```dart
import 'package:flutter_motionly/widget/button/rect_reveal_button.dart';

RectRevealButton(
  selectedChild: Icon(Icons.favorite, color: Colors.white),
  unselectedChild: Icon(Icons.favorite_border, color: Colors.red),
  selectedBackgroundColor: Colors.red,
  unselectedBackgroundColor: Colors.white,
  selectedRippleColor: Colors.red,
  unselectedRippleColor: Colors.white,
  revealDirection: RevealDirection.fromLeft,
  height: 50,
  borderRadius: 12,
  animationDuration: Duration(milliseconds: 300),
  isSelected: false,
  onPressed: () => toggleFavorite(),
)
```

Direcciones disponibles:
- `fromClick` - Desde el punto de toque
- `fromLeft` - De izquierda a derecha
- `fromRight` - De derecha a izquierda

### PulsatingButton

Botón con efecto de pulsación continua tipo latido:

```dart
import 'package:flutter_motionly/widget/button/pulsating_button.dart';

// Botón básico
PulsatingButton(
  onClick: () => print('¡Comenzar!'),
  child: Text(
    'Comenzar',
    style: TextStyle(color: Colors.white, fontSize: 16),
  ),
)

// Botón personalizado para CTA principal
PulsatingButton(
  onClick: _startGame,
  color: Colors.red,
  width: 200.0,
  height: 70.0,
  pulsationDuration: Duration(milliseconds: 1000),
  pulsationSize: 20.0,
  curve: Curves.easeInOutCubic,
  borderRadius: BorderRadius.circular(35.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.play_arrow, color: Colors.white),
      SizedBox(width: 8),
      Text('Jugar Ahora', style: TextStyle(color: Colors.white, fontSize: 18)),
    ],
  ),
)

// Botón con estilo outline
PulsatingButton(
  onClick: _subscribe,
  color: Colors.transparent,
  border: Border.all(color: Colors.purple, width: 2),
  width: 150.0,
  height: 50.0,
  pulsationSize: 15.0,
  child: Text(
    'Suscribirse',
    style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
  ),
)
```

Parámetros configurables:
- `pulsationSize` - Tamaño de la expansión del halo (8-30px recomendado)
- `pulsationDuration` - Velocidad de pulsación (500-1500ms)
- `curve` - Curva de animación (easeInOut, easeInOutCubic, elasticInOut, etc.)
- `color` - Color del botón y del halo pulsante
- `border` - Borde opcional para estilo outline

## 📱 Plataformas Soportadas

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Linux
- ✅ Windows

## 🎨 Ejemplo Completo

Consulta la carpeta [`example/`](https://github.com/palmerovicdev/flutter_motionly_web/tree/main/example) para ver una aplicación interactiva completa con todos los componentes en acción.

Para ejecutar el ejemplo:

```bash
cd example
flutter pub get
flutter run
```

O visita la [demo web en vivo](http://fluttermotionly-doc-whlgkc-bc9a19-217-15-171-136.traefik.me/).

## 🔧 Requisitos

- Flutter SDK: `>=1.17.0`
- Dart SDK: `^3.9.2`

## 📚 Documentación

Todos los widgets incluyen documentación detallada con:
- Descripción de parámetros
- Ejemplos de código
- Consejos de UX y rendimiento
- Casos de uso recomendados

Usa el autocompletado de tu IDE para ver la documentación inline.

## 🤝 Contribuir

Las contribuciones son bienvenidas! Si encuentras un bug o tienes una sugerencia:

1. Abre un [issue](https://github.com/palmerovicdev/flutter_motionly_web/issues)
2. Envía un [pull request](https://github.com/palmerovicdev/flutter_motionly_web/pulls)

## ✨ Nuevo release:

- Versión objetivo: `1.1.1` (documentación completa de nuevos componentes)

Pasos recomendados para release:

1. Actualiza la versión en `pubspec.yaml` a `1.1.1` y revisa `CHANGELOG.md`.
2. Revisa `example/` y asegúrate de que los snippets funcionan con la nueva API.
3. Ejecuta tests y `flutter analyze` en todo el repo.
4. Haz commit y tag (por ejemplo `v1.1.1`) y publica.

Comandos sugeridos:

```git
git add . && \
git commit -m "chore(release): v1.1.1 - documentación completa de fondos animados" && \
git tag -a v1.1.1 -m "Release v1.1.1" && \
git push origin main && \
git push origin v1.1.1
```

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.

## 👨‍💻 Autor

**Palmerodev**
- LinkedIn: [in/palmerodev](https://linkedin.com/in/palmerodev)
- GitHub: [palmerovicdev](https://github.com/palmerovicdev)
- Email: palmerodev@gmail.com

## 🌟 Apoya el Proyecto

Si este paquete te resulta útil, considera:
- ⭐ Dar una estrella en [GitHub](https://github.com/palmerovicdev/flutter_motionly_web)
- 👍 Dar like en [pub.dev](https://pub.dev/packages/flutter_motionly)
- 📢 Compartirlo con otros desarrolladores
- 🐛 Reportar bugs o sugerir mejoras

---

Hecho con ❤️ por [Palmerodev](https://github.com/palmerovicdev)
