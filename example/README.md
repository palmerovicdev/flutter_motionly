# Flutter Motionly - Aplicación de Ejemplo

Una aplicación de demostración interactiva para el paquete **Flutter Motionly**, que muestra componentes animados personalizados para Flutter.

## 📖 Descripción

Esta aplicación es una galería interactiva que presenta todos los componentes animados disponibles en el paquete Flutter Motionly. Incluye ejemplos en vivo, documentación y código de implementación para cada componente.

## ✨ Novedades (v0.0.8)

- Unificación y estandarización de la API pública para botones de revelado:
  - `RippleRevealButton` y `RectRevealButton` ahora usan propiedades consistentes como `selectedChild`, `unselectedChild`, `selectedBackgroundColor`, `unselectedBackgroundColor`, `selectedRippleColor`, `unselectedRippleColor`, `isSelected`, `animationDuration`, `borderRadius`, `revealDirection` (cuando aplica), etc.
- Mejoras de rendimiento y estabilidad en:
  - `PulsatingButton` (estabilidad en animaciones y documentación ampliada)
  - `FocusButton` (optimización del gradiente y reducción de repaints)
  - `AnimatedStateButton` (caching y reducción de rebuilds)
- Documentación y ejemplos en la app actualizados para ser copy/paste y servir como referencia inmediata.

Consulta el `CHANGELOG.md` en la raíz del repositorio para más detalles.

## 🔘 Características

### Botones Animados

- **RippleRevealButton** - Botón con efecto de ondulación/reveal circular desde el punto de toque
- **RectRevealButton** - Botón con efecto de revelación rectangular (direcciones: `fromClick`, `fromLeft`, `fromRight`)
- **FocusButton** - Botón con gradiente animado en el borde
- **AnimatedStateButton** - Botón con estados animados y soporte para loaders
- **PulsatingButton** - Botón con efecto de pulsación continua tipo latido

### 🎨 Fondos Animados

- **ParticleBox** - Sistema de partículas animadas para fondos dinámicos e interactivos
- **FlickTileBox** - Grid de tiles parpadeantes con velocidad y opacidad variables

### 📝 Textos Animados

- **AnimatedText** - Texto con animaciones personalizadas
- **FuzzyText** - Texto con efecto difuminado animado

### ⏳ Loaders

- **WaveSticksLoader** - Loader con efecto de onda gaussiana suave
- **SquareMatrixLoader** - Loader con matriz de cuadrados animados en múltiples direcciones
- **CircleMatrixLoader** - Loader con matriz de círculos que se desvanecen elegantemente

### ⭕ Indicadores

- **CircularRevealIndicator** - Indicador con revelación circular animada

### 🎨 Interfaz

- Diseño responsivo (adaptable a escritorio y móvil)
- Tema oscuro moderno
- Navegación fluida entre componentes
- Ejemplos de código interactivos y actualizados

## 🚀 Instalación

1. Clona el repositorio:

   ```bash
   git clone https://github.com/palmerovicdev/flutter_motionly_web.git
   cd flutter_motionly_web/example
   ```

2. Instala las dependencias:

   ```bash
   flutter pub get
   ```

3. Ejecuta la aplicación (móvil/escritorio/web):

   ```bash
   flutter run
   # o para web
   flutter run -d chrome
   ```

4. Para analizar el proyecto (opcional):

   ```bash
   flutter analyze
   ```

## 📱 Plataformas Soportadas

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Linux
- ✅ Windows

## 🏗️ Estructura del Proyecto (resumen)

```
example/
├── lib/
│   ├── main.dart                    # Punto de entrada
│   ├── common/
│   │   └── utils.dart              # Utilidades y colores
│   └── pages/
│       ├── home_page.dart          # Página principal con navegación
│       ├── welcome_page.dart       # Página de bienvenida
│       ├── buttons/                # Páginas de documentación de botones
│       │   ├── animated_state_button_doc_page.dart
│       │   ├── focus_button_doc_page.dart
│       │   ├── pulsating_button_page.dart
│       │   ├── rect_reveal_button_doc_page.dart
│       │   └── ripple_reveal_button_doc_page.dart
│       ├── backgrounds/            # Páginas de documentación de fondos animados
│       │   ├── particles_page.dart
│       │   └── flick_tile_page.dart
│       ├── texts/                  # Páginas de documentación de textos
│       │   ├── animated_text_doc_page.dart
│       │   └── fuzzy_text_doc_page.dart
│       ├── loaders/                # Páginas de documentación de loaders
│       │   ├── wave_stick_page.dart
│       │   ├── square_matrix_page.dart
│       │   └── circle_matrix_page.dart
│       └── indicators/             # Páginas de documentación de indicadores
│           └── indicators_page.dart
└── assets/                         # Recursos (SVG, imágenes)
```

## 📦 Dependencias principales

- **flutter_motionly** - Paquete principal con los componentes animados
- **flutter_svg** - Para renderizar iconos SVG
- **url_launcher** - Para abrir enlaces externos

Revisa `pubspec.yaml` para la lista completa de dependencias y versiones.

## 🎯 Uso

La aplicación funciona como una galería interactiva:

1. **Navegación lateral** (escritorio) o **menú desplegable** (móvil) para seleccionar componentes
2. Cada página de componente incluye:
    - Demostración interactiva en vivo
    - Código de ejemplo (actualizado)
    - Documentación de parámetros
    - Casos de uso y mejores prácticas

## 👨‍💻 Autor

**Palmerodev**

- LinkedIn: [in/palmerodev](https://linkedin.com/in/palmerodev)
- GitHub: [palmerovicdev](https://github.com/palmerovicdev)
- Email: palmerodev@gmail.com

## 📄 Licencia

Este proyecto está licenciado bajo los términos especificados en el archivo LICENSE del repositorio principal.

## 🔗 Enlaces Útiles

- [Documentación oficial de Flutter](https://docs.flutter.dev/)
- [Repositorio del paquete Flutter Motionly](https://github.com/palmerovicdev/flutter_motionly_web)
- [CHANGELOG.md (raíz del repo)](../CHANGELOG.md)
- [Web de Ejemplo](https://flutter-motionly-web.onrender.com/)

## 🤝 Contribuir

Las contribuciones son bienvenidas. Por favor:

1. Haz fork del repositorio
2. Crea una rama para tu característica (`git checkout -b feature/nueva-caracteristica`)
3. Haz commit de tus cambios (`git commit -am 'Agrega nueva característica'`)
4. Haz push a la rama (`git push origin feature/nueva-caracteristica`)
5. Abre un Pull Request

---

© 2025 Palmerodev. Todos los derechos reservados.
