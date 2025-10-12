import 'package:flutter/material.dart';
import 'package:flutter_motionly/widget/indicator/circular_reveal_indicator.dart';

import '../../common/utils.dart';

class IndicatorsPage extends StatelessWidget {
  const IndicatorsPage({super.key});

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
                    'CircularRevealIndicator',
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
                    'Indicador circular animado con segmentos personalizables. Perfecto para loaders, temporizadores y visualización de progreso con efectos de revelación suaves.',
                    style: TextStyle(
                      color: textMuted.toColor(),
                      fontSize: isNarrow ? 16 : 20,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: isNarrow ? 32 : 48),

                  Center(
                    child: CircularRevealIndicator(
                      size: isNarrow ? 200 : 280,
                      segmentCount: 60,
                      activeColor: primary.toColor(),
                      inactiveColor: bgLight.toColor(),
                      strokeWidth: 3,
                      animationDuration: const Duration(seconds: 2),
                      activeSegments: 1,
                      animate: true,
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
CircularRevealIndicator(
  size: 280,
  segmentCount: 60,
  activeColor: Colors.blue,
  inactiveColor: Colors.grey,
  strokeWidth: 3,
  animationDuration: Duration(seconds: 2),
  activeSegments: 5,
  animate: true,
)''', isNarrow),

                  const SizedBox(height: 80),

                  buildSectionTitle('Ejemplos', isNarrow),
                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Time Tracker',
                    'Tres indicadores concéntricos para horas, minutos y segundos',
                    isNarrow,
                    Center(
                      child: SizedBox(
                        width: isNarrow ? 200 : 280,
                        height: isNarrow ? 200 : 280,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularRevealIndicator(
                              size: isNarrow ? 200 : 280,
                              segmentCount: 60,
                              activeColor: primary.toColor(),
                              inactiveColor: bgLight.toColor(),
                              strokeWidth: 2,
                              animationDuration: const Duration(minutes: 60),
                              activeSegments: 1,
                              animate: true,
                            ),
                            CircularRevealIndicator(
                              size: isNarrow ? 140 : 200,
                              segmentCount: 60,
                              activeColor: primary.toColor(),
                              inactiveColor: bgLight.toColor(),
                              strokeWidth: 2,
                              animationDuration: const Duration(seconds: 60),
                              activeSegments: 1,
                              animate: true,
                            ),
                            CircularRevealIndicator(
                              size: isNarrow ? 80 : 120,
                              segmentCount: 60,
                              activeColor: primary.toColor(),
                              inactiveColor: bgLight.toColor(),
                              strokeWidth: 3,
                              animationDuration: const Duration(milliseconds: 1000),
                              activeSegments: 2,
                              animate: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    '''
Stack(
  alignment: Alignment.center,
  children: [
    CircularRevealIndicator(
      size: 280,
      segmentCount: 60,
      activeSegments: 1,
      animationDuration: Duration(minutes: 60),
    ),
    CircularRevealIndicator(
      size: 200,
      segmentCount: 60,
      activeSegments: 1,
      animationDuration: Duration(seconds: 60),
    ),
    CircularRevealIndicator(
      size: 120,
      segmentCount: 60,
      activeSegments: 2,
      animationDuration: Duration(seconds: 1),
    ),
  ],
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Progress Tracker',
                    'Indicador de progreso con múltiples segmentos activos y fade gradual',
                    isNarrow,
                    Center(
                      child: CircularRevealIndicator(
                        activeColor: info.toColor(),
                        inactiveColor: bgLight.toColor(),
                        size: isNarrow ? 200 : 280,
                        segmentCount: 60,
                        strokeWidth: 3,
                        animationDuration: const Duration(seconds: 2),
                        activeSegments: 6,
                        animate: true,
                      ),
                    ),
                    '''
CircularRevealIndicator(
  size: 280,
  segmentCount: 60,
  activeColor: Colors.cyan,
  activeSegments: 6,
  animationDuration: Duration(seconds: 2),
  animate: true,
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Fast Loader',
                    'Loader rápido con pocos segmentos para animaciones veloces',
                    isNarrow,
                    Center(
                      child: CircularRevealIndicator(
                        activeColor: success.toColor(),
                        inactiveColor: bgLight.toColor(),
                        size: isNarrow ? 200 : 280,
                        segmentCount: 12,
                        strokeWidth: 4,
                        animationDuration: const Duration(milliseconds: 800),
                        activeSegments: 3,
                        animate: true,
                      ),
                    ),
                    '''
CircularRevealIndicator(
  size: 280,
  segmentCount: 12,
  strokeWidth: 4,
  activeColor: Colors.green,
  activeSegments: 3,
  animationDuration: Duration(milliseconds: 800),
  animate: true,
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Minimal Pointer',
                    'Indicador minimalista con un solo segmento activo',
                    isNarrow,
                    Center(
                      child: CircularRevealIndicator(
                        activeColor: text.toColor(),
                        inactiveColor: bgLight.toColor(),
                        size: isNarrow ? 200 : 280,
                        segmentCount: 48,
                        strokeWidth: 2,
                        animationDuration: const Duration(seconds: 3),
                        activeSegments: 1,
                        animate: true,
                      ),
                    ),
                    '''
CircularRevealIndicator(
  size: 280,
  segmentCount: 48,
  strokeWidth: 2,
  activeSegments: 1,
  animationDuration: Duration(seconds: 3),
  animate: true,
)''',
                  ),

                  const SizedBox(height: 80),

                  buildSectionTitle('Propiedades', isNarrow),
                  const SizedBox(height: 24),
                  buildPropertiesTable(isNarrow, _properties),

                  const SizedBox(height: 80),

                  buildSectionTitle('Mejores Prácticas', isNarrow),
                  const SizedBox(height: 24),

                  if (isNarrow)
                    Column(
                      children: [
                        buildPracticeCard('✓ Hacer', _dos, isNarrow, true),
                        const SizedBox(height: 20),
                        buildPracticeCard('✗ Evitar', _donts, isNarrow, false),
                      ],
                    )
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: buildPracticeCard('✓ Hacer', _dos, isNarrow, true),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: buildPracticeCard('✗ Evitar', _donts, isNarrow, false),
                        ),
                      ],
                    ),

                  const SizedBox(height: 80),
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
    'icon': Icons.animation,
    'title': 'Animación Suave',
    'description': 'Rotación continua con transiciones fluidas y controladas',
  },
  {
    'icon': Icons.settings,
    'title': 'Personalizable',
    'description': 'Controla segmentos, colores, tamaño y velocidad de animación',
  },
  {
    'icon': Icons.layers,
    'title': 'Múltiples Segmentos',
    'description': 'Efecto de fade en múltiples segmentos activos simultáneos',
  },
  {
    'icon': Icons.speed,
    'title': 'Rendimiento',
    'description': 'Optimizado para animaciones fluidas sin afectar el rendimiento',
  },
];

final _properties = [
  {
    'name': 'size',
    'type': 'double',
    'default': '200',
    'description': 'Tamaño del indicador circular en píxeles',
  },
  {
    'name': 'segmentCount',
    'type': 'int',
    'default': '60',
    'description': 'Número total de segmentos en el círculo',
  },
  {
    'name': 'activeSegments',
    'type': 'int',
    'default': '5',
    'description': 'Cantidad de segmentos visibles con efecto fade',
  },
  {
    'name': 'strokeWidth',
    'type': 'double',
    'default': '3',
    'description': 'Grosor de los segmentos del indicador',
  },
  {
    'name': 'activeColor',
    'type': 'Color',
    'default': 'Colors.blue',
    'description': 'Color de los segmentos activos',
  },
  {
    'name': 'inactiveColor',
    'type': 'Color',
    'default': 'Colors.grey',
    'description': 'Color de los segmentos inactivos',
  },
  {
    'name': 'animationDuration',
    'type': 'Duration',
    'default': 'Duration(seconds: 2)',
    'description': 'Duración de una rotación completa',
  },
  {
    'name': 'animate',
    'type': 'bool',
    'default': 'true',
    'description': 'Activa o desactiva la animación',
  },
  {
    'name': 'shouldPaint',
    'type': 'bool',
    'default': 'true',
    'description': 'Controla la visibilidad del indicador',
  },
];

final _dos = [
  'Usa duraciones apropiadas según el contexto (1-3 segundos para loaders)',
  'Ajusta activeSegments según la velocidad de animación',
  'Usa colores con buen contraste para mejor visibilidad',
  'Combina múltiples indicadores para efectos complejos',
];

final _donts = [
  'Evita usar demasiados segmentos (>100) en dispositivos lentos',
  'No uses animaciones muy rápidas (<500ms) que puedan causar mareos',
  'Evita strokeWidth muy grueso que dificulte ver los segmentos',
  'No uses activeSegments mayor que segmentCount',
];
