# Flutter Motionly - Aplicación de Ejemplo

Una aplicación de demostración interactiva para el paquete **Flutter Motionly**, que muestra componentes animados personalizados para Flutter.

## 📖 Descripción

Esta aplicación es una galería interactiva que presenta todos los componentes animados disponibles en el paquete Flutter Motionly. Incluye ejemplos en vivo, documentación y código de implementación para cada componente.

## ✨ Características

### 🔘 Botones Animados
- **Ripple Reveal Button** - Botón con efecto de ondulación reveladora
- **Rect Reveal Button** - Botón con efecto de revelación rectangular
- **Focus Button** - Botón con gradiente animado al pasar el cursor
- **State Button** - Botón con estados animados

### 📝 Textos Animados
- **Animated Text** - Texto con animaciones personalizadas
- **Fuzzy Text** - Texto con efecto difuminado animado

### ⏳ Loaders
- **Wave Sticks Loader** - Loader con efecto de onda gaussiana suave
- **Square Matrix Loader** - Loader con matriz de cuadrados animados en múltiples direcciones


### ⭕ Indicadores
- **Circular Reveal Indicator** - Indicador con revelación circular animada

### 🎨 Interfaz
- Diseño responsivo (adaptable a escritorio y móvil)
- Tema oscuro moderno
- Navegación fluida entre componentes
- Ejemplos de código interactivos
- Enlaces a redes sociales

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

3. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

   O para web:
   ```bash
   flutter run -d chrome
   ```

## 📱 Plataformas Soportadas

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Linux
- ✅ Windows

## 🏗️ Estructura del Proyecto

```
example/
├── lib/
│   ├── main.dart                    # Punto de entrada
│   ├── common/
│   │   └── utils.dart              # Utilidades y colores
│   └── pages/
│       ├── home_page.dart          # Página principal con navegación
│       ├── buttons/                # Páginas de documentación de botones
│       │   ├── animated_state_button_doc_page.dart
│       │   ├── focus_button_doc_page.dart
│       │   ├── rect_reveal_button_doc_page.dart
│       │   └── ripple_reveal_button_doc_page.dart
│       ├── texts/                  # Páginas de documentación de textos
│       │   ├── animated_text_doc_page.dart
│       │   └── fuzzy_text_doc_page.dart
│       ├── loaders/                # Páginas de documentación de loaders
│       │   └── wave_sticks_loader_doc_page.dart
│       └── indicators/             # Páginas de documentación de indicadores
│           └── indicators_page.dart
└── assets/                         # Recursos (SVG, imágenes)
```

## 📦 Dependencias

- **flutter_motionly** - Paquete principal con los componentes animados
- **flutter_svg** - Para renderizar iconos SVG
- **url_launcher** - Para abrir enlaces externos

Ver `pubspec.yaml` para la lista completa de dependencias.

## 🎯 Uso

La aplicación funciona como una galería interactiva:

1. **Navegación lateral** (escritorio) o **menú desplegable** (móvil) para seleccionar componentes
2. Cada página de componente incluye:
   - Demostración interactiva en vivo
   - Código de ejemplo
   - Documentación de parámetros
   - Casos de uso

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
- [Cookbook de Flutter](https://docs.flutter.dev/cookbook)
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
