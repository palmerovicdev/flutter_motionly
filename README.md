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

### ⭕ Indicadores

- **CircularRevealIndicator** - Indicador circular por segmentos con revelación animada
  - Modo automático o manual
  - Efecto halo configurable

## 📦 Instalación

Añade esta línea a tu archivo `pubspec.yaml`:

```yaml
dependencies:
  flutter_motionly: ^0.0.1
```

Luego ejecuta:

```bash
flutter pub get
```

## 🚀 Uso

### RippleRevealButton

Botón con efecto de ondulación que alterna entre dos estados:

```dart
import 'package:flutter_motionly/widget/button/ripple_reveal_button.dart';

RippleRevealButton(
  widgetA: const Text('ON', style: TextStyle(color: Colors.black)),
  widgetB: const Text('OFF', style: TextStyle(color: Colors.white)),
  backgroundColorA: Colors.black,
  backgroundColorB: Colors.white,
  rippleColorA: Colors.white,
  rippleColorB: Colors.black,
  height: 45,
  radius: 8,
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

Botón con revelación rectangular:

```dart
import 'package:flutter_motionly/widget/button/rect_reveal_button.dart';

RectRevealButton(
  widgetA: Icon(Icons.favorite, color: Colors.white),
  widgetB: Icon(Icons.favorite_border, color: Colors.red),
  backgroundColorA: Colors.red,
  backgroundColorB: Colors.white,
  rippleColorA: Colors.red,
  rippleColorB: Colors.white,
  revealDirection: RevealDirection.fromLeft,
  height: 50,
  radius: 12,
  onPressed: () => toggleFavorite(),
)
```

Direcciones disponibles:
- `fromClick` - Desde el punto de toque
- `fromLeft` - De izquierda a derecha
- `fromRight` - De derecha a izquierda

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

O visita la [demo web en vivo](https://flutter-motionly-web.onrender.com/).

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

1- Actualiza la versión en `pubspec.yaml` y `CHANGELOG.md`.
2- Actualiza el README.md si es necesario.
3- Actualiza example/README.md si es necesario.
4- Actualiza example/lib/ si es necesario.

```git
git add . && \
git commit -m "<message>" && \
git tag -a v<num> -m "<tag-message>" && \
git push origin main && \
git push origin v<num>
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
