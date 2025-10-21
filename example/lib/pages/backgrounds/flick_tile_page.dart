import 'package:flutter/material.dart';
import 'package:flutter_motionly/widget/backgrounds/flick_tile_animation.dart';

import '../../common/utils.dart';

class FlickTilePage extends StatelessWidget {
  const FlickTilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isNarrow = screenWidth < 900;
    final contentPadding = isNarrow ? 20.0 : 60.0;

    return Scaffold(
      backgroundColor: bgDark.toColor(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: contentPadding,
                vertical: isNarrow ? 40 : 80,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    bg.toColor(),
                    bgDark.toColor(),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FlickTileBox',
                    style: TextStyle(
                      color: text.toColor(),
                      fontSize: isNarrow ? 32 : 72,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                      letterSpacing: -1.5,
                    ),
                  ),
                  SizedBox(height: isNarrow ? 16 : 24),
                  Text(
                    'Un widget de fondo animado con tiles que parpadean aleatoriamente para efectos visuales dinámicos y atractivos.',
                    style: TextStyle(
                      color: textMuted.toColor(),
                      fontSize: isNarrow ? 16 : 20,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: isNarrow ? 32 : 48),

                  Center(
                    child: Container(
                      height: isNarrow ? 200 : 280,
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 280),
                      child: FlickTileBox(
                        rows: (isNarrow ? 200 : 280) ~/ 16,
                        columns: screenWidth ~/ 24,
                        spacing: 6,
                        color: primary.toColor(),
                        tileSize: 14,
                        minOpacity: 0.1,
                        maxOpacity: 0.7,
                        minSpeed: 0.05,
                        maxSpeed: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: contentPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),

                  buildSectionTitle('Características', isNarrow),
                  const SizedBox(height: 24),
                  buildFeatureGrid(isNarrow, _features),

                  const SizedBox(height: 80),

                  buildSectionTitle('Uso Básico', isNarrow),
                  const SizedBox(height: 24),
                  buildCodeBlock('''
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
)''', isNarrow),

                  const SizedBox(height: 80),

                  buildSectionTitle('Ejemplos', isNarrow),
                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Parpadeo Suave',
                    'Efecto relajante con transiciones lentas y opacidad baja',
                    isNarrow,
                    Container(
                      height: isNarrow ? 200 : 280,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: bgDark.toColor(),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: border.toColor().withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: FlickTileBox(
                          rows: 8,
                          columns: 12,
                          spacing: 4,
                          color: Colors.cyan,
                          minOpacity: 0.05,
                          maxOpacity: 0.3,
                          minSpeed: 0.15,
                          maxSpeed: 0.4,
                          borderRadius: 3,
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),
                    '''
FlickTileBox(
  rows: 8,
  columns: 12,
  spacing: 4,
  color: Colors.cyan,
  minOpacity: 0.05,
  maxOpacity: 0.3,
  minSpeed: 0.15,
  maxSpeed: 0.4,
  borderRadius: 3,
)''',
                  ),

                  const SizedBox(height: 40),

                  buildExampleCard(
                    'Energía Vibrante',
                    'Muchos tiles con parpadeo rápido para efectos dinámicos',
                    isNarrow,
                    Container(
                      height: isNarrow ? 200 : 280,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: bgDark.toColor(),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: border.toColor().withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: FlickTileBox(
                          rows: 15,
                          columns: 20,
                          spacing: 3,
                          color: Colors.orange,
                          minOpacity: 0.2,
                          maxOpacity: 1.0,
                          minSpeed: 0.5,
                          maxSpeed: 1.2,
                          borderRadius: 2,
                          backgroundColor: Colors.black87,
                        ),
                      ),
                    ),
                    '''
FlickTileBox(
  rows: 15,
  columns: 20,
  spacing: 3,
  color: Colors.orange,
  minOpacity: 0.2,
  maxOpacity: 1.0,
  minSpeed: 0.5,
  maxSpeed: 1.2,
  borderRadius: 2,
)''',
                  ),

                  const SizedBox(height: 40),

                  buildExampleCard(
                    'Matriz Digital',
                    'Efecto de pantalla digital con tiles cuadrados pequeños',
                    isNarrow,
                    Container(
                      height: isNarrow ? 200 : 280,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: border.toColor().withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: FlickTileBox(
                          rows: 20,
                          columns: 30,
                          spacing: 2,
                          color: Colors.green,
                          minOpacity: 0.1,
                          maxOpacity: 0.8,
                          minSpeed: 0.25,
                          maxSpeed: 0.75,
                          borderRadius: 1,
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),
                    '''
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
)''',
                  ),

                  const SizedBox(height: 40),

                  buildExampleCard(
                    'Mosaico Minimalista',
                    'Pocos tiles grandes con bordes redondeados',
                    isNarrow,
                    Container(
                      height: isNarrow ? 200 : 280,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: bgDark.toColor(),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: border.toColor().withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: FlickTileBox(
                          rows: 4,
                          columns: 6,
                          spacing: 12,
                          color: Colors.purple,
                          minOpacity: 0.15,
                          maxOpacity: 0.6,
                          minSpeed: 0.2,
                          maxSpeed: 0.5,
                          borderRadius: 8,
                          backgroundColor: bg.toColor(),
                        ),
                      ),
                    ),
                    '''
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
)''',
                  ),

                  const SizedBox(height: 80),

                  buildSectionTitle('Parámetros', isNarrow),
                  const SizedBox(height: 24),
                  buildPropertiesTable(isNarrow, _parameters),

                  const SizedBox(height: 80),

                  buildSectionTitle('Mejores Prácticas', isNarrow),
                  const SizedBox(height: 24),
                  isNarrow
                      ? Column(
                          children: [
                            buildPracticeCard(
                              '✓ Hacer',
                              [
                                'Usa entre 50-150 tiles (rows × columns) en móviles',
                                'Mantén spacing entre 2-8px para mejor definición',
                                'Opacidad mínima de 0.05-0.15 para efectos sutiles',
                                'Velocidad entre 0.2-0.6 para transiciones naturales',
                                'borderRadius pequeño (2-6) para tiles compactos',
                                'Ajusta tileSize según el contenedor',
                              ],
                              success.toColor(),
                              isNarrow,
                            ),
                            const SizedBox(height: 20),
                            buildPracticeCard(
                              '✗ Evitar',
                              [
                                'Más de 500 tiles en total (afecta rendimiento)',
                                'Velocidad muy alta (> 1.0) que cause distracción',
                                'Opacidad máxima de 1.0 en todos los tiles',
                                'spacing de 0 (los tiles se verán pegados)',
                                'Combinar demasiadas rows y columns a la vez',
                                'borderRadius muy grande que deforme los tiles',
                              ],
                              danger.toColor(),
                              isNarrow,
                            ),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: buildPracticeCard(
                                '✓ Hacer',
                                [
                                  'Usa entre 50-150 tiles (rows × columns) en móviles',
                                  'Mantén spacing entre 2-8px para mejor definición',
                                  'Opacidad mínima de 0.05-0.15 para efectos sutiles',
                                  'Velocidad entre 0.2-0.6 para transiciones naturales',
                                  'borderRadius pequeño (2-6) para tiles compactos',
                                  'Ajusta tileSize según el contenedor',
                                ],
                                success.toColor(),
                                isNarrow,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: buildPracticeCard(
                                '✗ Evitar',
                                [
                                  'Más de 500 tiles en total (afecta rendimiento)',
                                  'Velocidad muy alta (> 1.0) que cause distracción',
                                  'Opacidad máxima de 1.0 en todos los tiles',
                                  'spacing de 0 (los tiles se verán pegados)',
                                  'Combinar demasiadas rows y columns a la vez',
                                  'borderRadius muy grande que deforme los tiles',
                                ],
                                danger.toColor(),
                                isNarrow,
                              ),
                            ),
                          ],
                        ),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final _features = [
  {
    'icon': Icons.grid_on,
    'title': 'Grid Personalizable',
    'description': 'Define rows, columns y spacing para crear tu patrón ideal',
  },
  {
    'icon': Icons.speed,
    'title': 'Velocidad Variable',
    'description': 'Cada tile tiene su propia velocidad de parpadeo aleatoria',
  },
  {
    'icon': Icons.opacity,
    'title': 'Control de Opacidad',
    'description': 'Ajusta rangos min/max para efectos sutiles o intensos',
  },
  {
    'icon': Icons.rounded_corner,
    'title': 'Bordes Redondeados',
    'description': 'Personaliza el borderRadius de cada tile',
  },
  {
    'icon': Icons.shuffle,
    'title': 'Aleatoriedad Natural',
    'description': 'Cada tile tiene fase y amplitud única para variación orgánica',
  },
  {
    'icon': Icons.rocket_launch,
    'title': 'Alto Rendimiento',
    'description': 'Optimizado con RepaintBoundary y shouldRepaint eficiente',
  },
];

final _parameters = [
  {
    'name': 'rows',
    'type': 'int',
    'description': 'Número de filas en el grid',
    'default': '12',
  },
  {
    'name': 'columns',
    'type': 'int',
    'description': 'Número de columnas en el grid',
    'default': '8',
  },
  {
    'name': 'tileSize',
    'type': 'double?',
    'description': 'Tamaño de cada tile (null = auto-calculado)',
    'default': 'null',
  },
  {
    'name': 'spacing',
    'type': 'double',
    'description': 'Espaciado entre tiles en píxeles',
    'default': '6',
  },
  {
    'name': 'color',
    'type': 'Color',
    'description': 'Color base de los tiles',
    'default': 'Color(0xFF6EA8FE)',
  },
  {
    'name': 'minOpacity',
    'type': 'double',
    'description': 'Opacidad mínima de los tiles (0.0 - 1.0)',
    'default': '0.08',
  },
  {
    'name': 'maxOpacity',
    'type': 'double',
    'description': 'Opacidad máxima de los tiles (0.0 - 1.0)',
    'default': '0.95',
  },
  {
    'name': 'minSpeed',
    'type': 'double',
    'description': 'Velocidad mínima de parpadeo',
    'default': '0.35',
  },
  {
    'name': 'maxSpeed',
    'type': 'double',
    'description': 'Velocidad máxima de parpadeo',
    'default': '0.9',
  },
  {
    'name': 'borderRadius',
    'type': 'double',
    'description': 'Radio de borde de cada tile',
    'default': '4',
  },
  {
    'name': 'seed',
    'type': 'int?',
    'description': 'Semilla para aleatoriedad reproducible',
    'default': 'null',
  },
  {
    'name': 'backgroundColor',
    'type': 'Color?',
    'description': 'Color de fondo del canvas',
    'default': 'null',
  },
];
