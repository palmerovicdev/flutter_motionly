import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Widget de fondo animado con grid de tiles parpadeantes.
///
/// Crea un sistema de mosaico animado donde cada tile tiene su propia
/// velocidad de parpadeo, fase y rango de opacidad, generando un efecto
/// orgánico y dinámico perfecto para fondos modernos.
///
/// **Ideal para:** fondos de pantallas de login, overlays decorativos,
/// fondos de carga, efectos tipo matriz digital, y cualquier diseño que
/// necesite un fondo animado sutil pero impactante.
///
/// ## Cómo funciona
///
/// - Cada **tile** tiene velocidad única (`minSpeed` a `maxSpeed`).
/// - La **opacidad** oscila entre `minOpacity` y `maxOpacity` usando una onda sinusoidal.
/// - Cada tile tiene una **fase aleatoria** para que no parpadeen sincronizados.
/// - El **grid** se centra automáticamente en el área disponible.
///
/// ## Anatomía del efecto
///
/// ```
/// Grid 4x6 con spacing:
/// ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐
/// └─┘ └─┘ └─┘ └─┘ └─┘ └─┘  ← Cada tile parpadea independientemente
///  ↑   ↑   ↑   ↑   ↑   ↑
/// fase velocidad opacidad únicos
///
/// ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐
/// └─┘ └─┘ └─┘ └─┘ └─┘ └─┘
///
/// ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐
/// └─┘ └─┘ └─┘ └─┘ └─┘ └─┘
///
/// ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐
/// └─┘ └─┘ └─┘ └─┘ └─┘ └─┘
/// ```
///
/// ## Rendimiento
///
/// - **Optimizado** con `RepaintBoundary` para aislar repaints.
/// - **shouldRepaint** eficiente: solo compara el timestamp actual.
/// - **Recomendado:** 50-150 tiles totales (rows × columns) en móviles.
/// - **Máximo:** 500 tiles para mantener 60fps en la mayoría de dispositivos.
///
/// ## Buenas prácticas
///
/// - Usa `spacing` entre 2-8px para mejor definición visual.
/// - Mantén `minOpacity` bajo (0.05-0.15) para efectos sutiles.
/// - Rango de velocidad recomendado: 0.2-0.8 para transiciones naturales.
/// - Para efecto "matriz digital": muchos tiles pequeños, spacing reducido.
/// - Para efecto "minimalista": pocos tiles grandes, spacing amplio.
///
/// ## Ejemplos
///
/// ### Ejemplo básico (fondo sutil)
/// ```dart
/// FlickTileBox(
///   rows: 12,
///   columns: 8,
///   spacing: 6,
///   color: Colors.blue,
///   minOpacity: 0.1,
///   maxOpacity: 0.9,
///   minSpeed: 0.3,
///   maxSpeed: 0.8,
///   borderRadius: 4,
/// )
/// ```
///
/// ### Ejemplo matriz digital (efecto Matrix)
/// ```dart
/// FlickTileBox(
///   rows: 20,
///   columns: 30,
///   spacing: 2,
///   color: Colors.green,
///   minOpacity: 0.1,
///   maxOpacity: 0.8,
///   minSpeed: 0.25,
///   maxSpeed: 0.75,
///   borderRadius: 1,
///   backgroundColor: Colors.black,
/// )
/// ```
///
/// ### Ejemplo minimalista (tiles grandes)
/// ```dart
/// FlickTileBox(
///   rows: 4,
///   columns: 6,
///   spacing: 12,
///   color: Colors.purple,
///   minOpacity: 0.15,
///   maxOpacity: 0.6,
///   minSpeed: 0.2,
///   maxSpeed: 0.5,
///   borderRadius: 8,
///   tileSize: 60,
/// )
/// ```
///
/// ### Ejemplo con fondo personalizado
/// ```dart
/// Container(
///   height: 400,
///   width: double.infinity,
///   child: ClipRRect(
///     borderRadius: BorderRadius.circular(16),
///     child: FlickTileBox(
///       rows: 10,
///       columns: 15,
///       color: Colors.orange,
///       backgroundColor: Colors.black87,
///     ),
///   ),
/// )
/// ```
///
/// ### Ejemplo reproducible (con seed)
/// ```dart
/// FlickTileBox(
///   rows: 8,
///   columns: 12,
///   seed: 42, // Mismo patrón cada vez
///   color: Colors.cyan,
/// )
/// ```
///
/// ## Parámetros avanzados
///
/// - **seed**: Útil para testing o cuando necesitas el mismo patrón siempre.
/// - **tileSize**: Usa `null` (automático) para responsive design.
/// - **backgroundColor**: Establece un fondo sólido antes de dibujar tiles.
///
/// Ver también: [ParticleBox] para efectos de partículas animadas.
class FlickTileBox extends StatefulWidget {
  const FlickTileBox({
    super.key,
    this.rows = 12,
    this.columns = 8,
    this.tileSize,
    this.spacing = 6,
    this.color = const Color(0xFF6EA8FE),
    this.minOpacity = 0.08,
    this.maxOpacity = 0.95,
    this.minSpeed = 0.35,
    this.maxSpeed = 0.9,
    this.borderRadius = 4,
    this.seed,
    this.backgroundColor,
  });

  /// Número de filas en el grid.
  ///
  /// Junto con [columns], determina la cantidad total de tiles.
  /// Para móviles, se recomienda que `rows × columns` esté entre 50-150.
  ///
  /// Valores típicos: 8-20.
  final int rows;

  /// Número de columnas en el grid.
  ///
  /// Junto con [rows], determina la cantidad total de tiles.
  /// Ajusta según el aspect ratio de tu contenedor.
  ///
  /// Valores típicos: 6-30.
  final int columns;

  /// Tamaño de cada tile en píxeles.
  ///
  /// Si es `null`, el tamaño se calcula automáticamente para llenar
  /// el espacio disponible (recomendado para responsive design).
  ///
  /// Si se especifica, los tiles tendrán este tamaño exacto y el grid
  /// se centrará en el área disponible.
  ///
  /// Rango recomendado: 10-100px.
  final double? tileSize;

  /// Espaciado entre tiles en píxeles.
  ///
  /// Un spacing mayor crea más separación visual entre tiles.
  ///
  /// - **0-2px**: Tiles muy juntos, efecto compacto
  /// - **3-8px**: Separación equilibrada (recomendado)
  /// - **9-15px**: Tiles muy separados, efecto minimalista
  final double spacing;

  /// Color base de los tiles.
  ///
  /// La opacidad final de cada tile varía entre [minOpacity] y [maxOpacity],
  /// pero el color base permanece constante.
  final Color color;

  /// Opacidad mínima de los tiles (0.0 - 1.0).
  ///
  /// Determina qué tan transparente puede ser un tile en su punto más tenue.
  ///
  /// - **0.0-0.1**: Muy sutil, casi invisible
  /// - **0.1-0.3**: Sutil pero visible (recomendado)
  /// - **0.3-0.5**: Presencia notable
  final double minOpacity;

  /// Opacidad máxima de los tiles (0.0 - 1.0).
  ///
  /// Determina qué tan opaco puede ser un tile en su punto más brillante.
  ///
  /// - **0.3-0.6**: Sutil y elegante
  /// - **0.6-0.9**: Vibrante y visible (recomendado)
  /// - **0.9-1.0**: Máxima intensidad
  final double maxOpacity;

  /// Velocidad mínima de parpadeo.
  ///
  /// Cada tile recibe una velocidad aleatoria entre [minSpeed] y [maxSpeed].
  /// Una velocidad de 1.0 significa un ciclo completo por segundo.
  ///
  /// Valores típicos: 0.1-0.5.
  final double minSpeed;

  /// Velocidad máxima de parpadeo.
  ///
  /// Cada tile recibe una velocidad aleatoria entre [minSpeed] y [maxSpeed].
  ///
  /// - **0.2-0.5**: Lento y relajante
  /// - **0.5-1.0**: Moderado (recomendado)
  /// - **1.0-2.0**: Rápido y energético
  final double maxSpeed;

  /// Radio de los bordes redondeados de cada tile.
  ///
  /// - **0-2**: Esquinas casi cuadradas
  /// - **3-6**: Ligeramente redondeadas (recomendado)
  /// - **7-12**: Muy redondeadas
  /// - **tileSize/2**: Círculos perfectos (si tileSize es conocido)
  final double borderRadius;

  /// Semilla para el generador de números aleatorios.
  ///
  /// Si se proporciona, el patrón de parpadeo será reproducible.
  /// Útil para testing o cuando necesitas consistencia visual.
  ///
  /// Si es `null`, cada instancia tendrá un patrón único.
  final int? seed;

  /// Color de fondo del canvas.
  ///
  /// Si es `null`, el fondo es transparente y se verá lo que esté debajo.
  /// Si se proporciona, se dibuja un rectángulo sólido antes de los tiles.
  final Color? backgroundColor;

  @override
  State<FlickTileBox> createState() => _FlickTileBoxState();
}

/// Estado interno de [FlickTileBox].
///
/// Maneja el ciclo de vida del [AnimationController] y la inicialización
/// de los datos de cada tile ([_TileData]).
class _FlickTileBoxState extends State<FlickTileBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_TileData> _tiles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this)
      ..repeat(min: 0, max: 1, period: const Duration(milliseconds: 1000));
    _initTiles();
  }

  /// Inicializa los datos de cada tile con valores aleatorios.
  ///
  /// Cada tile obtiene:
  /// - Velocidad única entre [widget.minSpeed] y [widget.maxSpeed]
  /// - Fase inicial aleatoria (0 a 2π)
  /// - Opacidad base y amplitud derivadas de [widget.minOpacity] y [widget.maxOpacity]
  void _initTiles() {
    final rnd = math.Random(widget.seed);
    final minO = widget.minOpacity.clamp(0.0, 1.0);
    final maxO = widget.maxOpacity.clamp(0.0, 1.0);
    final opacityRange = maxO - minO;

    _tiles = List.generate(
      widget.rows * widget.columns,
      (_) => _TileData(
        speed: widget.minSpeed + rnd.nextDouble() * (widget.maxSpeed - widget.minSpeed),
        phase: rnd.nextDouble() * math.pi * 2,
        baseOpacity: minO + opacityRange * (0.45 + rnd.nextDouble() * 0.1),
        amplitude: opacityRange * (0.425 + rnd.nextDouble() * 0.15),
      ),
    );
  }

  @override
  void didUpdateWidget(FlickTileBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reinicializar tiles si cambian parámetros que afectan la generación
    if (oldWidget.rows != widget.rows ||
        oldWidget.columns != widget.columns ||
        oldWidget.minOpacity != widget.minOpacity ||
        oldWidget.maxOpacity != widget.maxOpacity ||
        oldWidget.minSpeed != widget.minSpeed ||
        oldWidget.maxSpeed != widget.maxSpeed ||
        oldWidget.seed != widget.seed) {
      _initTiles();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => RepaintBoundary(
        child: CustomPaint(
          painter: _FlickTilePainter(
            time: DateTime.now().millisecondsSinceEpoch / 1000.0,
            tiles: _tiles,
            rows: widget.rows,
            columns: widget.columns,
            tileSize: widget.tileSize,
            spacing: widget.spacing,
            color: widget.color,
            borderRadius: widget.borderRadius,
            backgroundColor: widget.backgroundColor,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

/// Datos de configuración para un tile individual.
///
/// Estos valores son constantes durante la vida del tile y determinan
/// su comportamiento de parpadeo único.
class _TileData {
  const _TileData({
    required this.speed,
    required this.phase,
    required this.baseOpacity,
    required this.amplitude,
  });

  /// Velocidad de oscilación (ciclos por segundo).
  final double speed;

  /// Fase inicial de la onda sinusoidal (0 a 2π).
  ///
  /// Desplaza temporalmente la onda para que cada tile parpadee
  /// en momentos diferentes.
  final double phase;

  /// Opacidad central alrededor de la cual oscila el tile.
  final double baseOpacity;

  /// Amplitud de la oscilación de opacidad.
  ///
  /// La opacidad final será: baseOpacity + amplitude × sin(...)
  final double amplitude;
}

/// Painter personalizado que dibuja el grid de tiles animados.
///
/// Optimizado para re-pintar eficientemente en cada frame solo
/// cuando el tiempo cambia.
class _FlickTilePainter extends CustomPainter {
  const _FlickTilePainter({
    required this.time,
    required this.tiles,
    required this.rows,
    required this.columns,
    required this.tileSize,
    required this.spacing,
    required this.color,
    required this.borderRadius,
    required this.backgroundColor,
  });

  /// Tiempo actual en segundos (timestamp).
  final double time;

  /// Lista de configuración de cada tile.
  final List<_TileData> tiles;

  /// Número de filas y columnas del grid.
  final int rows;
  final int columns;

  /// Tamaño de cada tile (null = auto-calculado).
  final double? tileSize;

  /// Espaciado entre tiles.
  final double spacing;

  /// Color base de los tiles.
  final Color color;

  /// Radio de bordes redondeados.
  final double borderRadius;

  /// Color de fondo opcional.
  final Color? backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    // Dibujar fondo si está especificado
    if (backgroundColor != null) {
      canvas.drawRect(Offset.zero & size, Paint()..color = backgroundColor!);
    }

    // Calcular tamaño de cada celda
    final totalSpacingX = spacing * (columns - 1);
    final totalSpacingY = spacing * (rows - 1);
    final cellSize = tileSize ?? math.min(
      (size.width - totalSpacingX) / columns,
      (size.height - totalSpacingY) / rows,
    ).clamp(2.0, 200.0);

    // Calcular offset para centrar el grid
    final gridWidth = columns * cellSize + totalSpacingX;
    final gridHeight = rows * cellSize + totalSpacingY;
    final startX = (size.width - gridWidth) / 2;
    final startY = (size.height - gridHeight) / 2;

    // Pre-crear el RRect para reutilizar
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, cellSize, cellSize),
      Radius.circular(borderRadius),
    );
    final paint = Paint();

    // Dibujar cada tile con su opacidad calculada
    int idx = 0;
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < columns; x++, idx++) {
        final tile = tiles[idx];

        // Calcular opacidad usando onda sinusoidal
        // opacity = base + amplitud × sin(2π × velocidad × tiempo + fase)
        final opacity = (tile.baseOpacity + tile.amplitude * math.sin(math.pi * 2 * tile.speed * time + tile.phase))
            .clamp(0.0, 1.0);

        // Optimización: omitir tiles casi invisibles
        if (opacity > 0.01) {
          paint.color = color.withOpacity(opacity);
          canvas.save();
          canvas.translate(startX + x * (cellSize + spacing), startY + y * (cellSize + spacing));
          canvas.drawRRect(rrect, paint);
          canvas.restore();
        }
      }
    }
  }

  @override
  bool shouldRepaint(_FlickTilePainter old) => time != old.time;
}
