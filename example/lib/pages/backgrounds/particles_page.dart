import 'package:flutter/material.dart';
import 'package:flutter_motionly/widget/backgrounds/particles_animation.dart';

import '../../common/utils.dart';

class ParticlesPage extends StatelessWidget {
  const ParticlesPage({super.key});

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
                  SizedBox(height: isNarrow ? 32 : 48),
                  Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          height: isNarrow ? 300 : 400,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: ParticleBox(
                              maxHeight: isNarrow ? 300 : 400,
                              maxWidth: screenWidth,
                              velocityFactor: 0.3,
                              particleCount: 150,
                              heightFactor: 6,
                              colors: [
                                primary.toColor(),
                                secondary.toColor(),
                                info.toColor(),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                'ParticleBox',
                                style: TextStyle(
                                  color: text.toColor(),
                                  fontSize: isNarrow ? 36 : 72,
                                  fontWeight: FontWeight.w900,
                                  height: 1.1,
                                  letterSpacing: -1.5,
                                ),
                              ),
                            ),
                            SizedBox(height: isNarrow ? 16 : 42),
                            Padding(
                              padding: const EdgeInsets.all(45.0),
                              child: Center(
                                child: Text(
                                  'Sistema de partículas animadas para fondos dinámicos. Perfecto para crear fondos interactivos, efectos visuales inmersivos y experiencias UI modernas.',
                                  style: TextStyle(
                                    color: textMuted.toColor(),
                                    fontSize: isNarrow ? 16 : 20,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(height: isNarrow ? 32 : 48),
                          ],
                        ),
                      ),
                    ],
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
)''', isNarrow),

                  const SizedBox(height: 80),

                  buildSectionTitle('Ejemplos', isNarrow),
                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Partículas Suaves',
                    'Efecto relajante con pocas partículas y movimiento lento',
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
                        child: ParticleBox(
                          maxHeight: isNarrow ? 200 : 280,
                          maxWidth: screenWidth,
                          velocityFactor: 0.1,
                          particleCount: 50,
                          heightFactor: 4,
                          colors: [
                            Colors.blue[200]!.withValues(alpha: 0.4),
                            Colors.cyan[200]!.withValues(alpha: 0.4),
                            Colors.teal[200]!.withValues(alpha: 0.4),
                          ],
                        ),
                      ),
                    ),
                    '''
ParticleBox(
  maxHeight: 280,
  maxWidth: width,
  velocityFactor: 0.1,
  particleCount: 50,
  heightFactor: 4,
  colors: [
    Colors.blue[200]!.withValues(alpha: 0.4),
    Colors.cyan[200]!.withValues(alpha: 0.4),
    Colors.teal[200]!.withValues(alpha: 0.4),
  ],
)''',
                  ),

                  const SizedBox(height: 40),

                  buildExampleCard(
                    'Energía Intensa',
                    'Muchas partículas con movimiento rápido para fondos dinámicos',
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
                        child: ParticleBox(
                          maxHeight: isNarrow ? 200 : 280,
                          maxWidth: screenWidth,
                          velocityFactor: 0.5,
                          particleCount: 300,
                          heightFactor: 8,
                          colors: [
                            Colors.red.withValues(alpha: 0.7),
                            Colors.orange.withValues(alpha: 0.7),
                            Colors.yellow.withValues(alpha: 0.7),
                          ],
                        ),
                      ),
                    ),
                    '''
ParticleBox(
  maxHeight: 280,
  maxWidth: width,
  velocityFactor: 0.5,
  particleCount: 300,
  heightFactor: 8,
  colors: [
    Colors.red.withValues(alpha: 0.7),
    Colors.orange.withValues(alpha: 0.7),
    Colors.yellow.withValues(alpha: 0.7),
  ],
)''',
                  ),

                  const SizedBox(height: 40),

                  buildExampleCard(
                    'Espacio Nocturno',
                    'Efecto de estrellas con partículas pequeñas y dispersas',
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
                        child: ParticleBox(
                          maxHeight: isNarrow ? 200 : 280,
                          maxWidth: screenWidth,
                          velocityFactor: 0.15,
                          particleCount: 100,
                          heightFactor: 3,
                          colors: [
                            Colors.white.withValues(alpha: 0.8),
                            Colors.blue[100]!.withValues(alpha: 0.6),
                            Colors.purple[100]!.withValues(alpha: 0.5),
                          ],
                        ),
                      ),
                    ),
                    '''
ParticleBox(
  maxHeight: 280,
  maxWidth: width,
  velocityFactor: 0.15,
  particleCount: 100,
  heightFactor: 3,
  colors: [
    Colors.white.withValues(alpha: 0.8),
    Colors.blue[100]!.withValues(alpha: 0.6),
    Colors.purple[100]!.withValues(alpha: 0.5),
  ],
)''',
                  ),

                  const SizedBox(height: 40),

                  buildExampleCard(
                    'Océano Digital',
                    'Efecto acuático con tonos azules y movimiento fluido',
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
                        child: ParticleBox(
                          maxHeight: isNarrow ? 200 : 280,
                          maxWidth: screenWidth,
                          velocityFactor: 0.25,
                          particleCount: 200,
                          heightFactor: 6,
                          colors: [
                            Colors.blue[300]!.withValues(alpha: 0.5),
                            Colors.blue[500]!.withValues(alpha: 0.5),
                            Colors.lightBlue[400]!.withValues(alpha: 0.5),
                          ],
                        ),
                      ),
                    ),
                    '''
ParticleBox(
  maxHeight: 280,
  maxWidth: width,
  velocityFactor: 0.25,
  particleCount: 200,
  heightFactor: 6,
  colors: [
    Colors.blue[300]!.withValues(alpha: 0.5),
    Colors.blue[500]!.withValues(alpha: 0.5),
    Colors.lightBlue[400]!.withValues(alpha: 0.5),
  ],
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
                                'Usa entre 50-150 partículas en móviles para mejor rendimiento',
                                'Aplica opacidad (0.4-0.7) para efectos sutiles y elegantes',
                                'Mantén velocityFactor entre 0.2-0.3 para movimiento suave',
                                'Ajusta particleCount según el tamaño de pantalla',
                                'Usa heightFactor entre 3-6 para variación visual',
                                'Combina 2-4 colores para paletas dinámicas',
                              ],
                              success.toColor(),
                              isNarrow,
                            ),
                            const SizedBox(height: 20),
                            buildPracticeCard(
                              '✗ Evitar',
                              [
                                'Más de 300 partículas (causa lag en dispositivos)',
                                'Velocidad muy alta (> 0.5) que maree al usuario',
                                'Colores completamente opacos que oculten el contenido',
                                'Usar como único elemento sin contexto visual',
                                'heightFactor muy bajo (< 2) que haga partículas uniformes',
                                'Demasiados colores (> 5) que creen confusión visual',
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
                                  'Usa entre 50-150 partículas en móviles para mejor rendimiento',
                                  'Aplica opacidad (0.4-0.7) para efectos sutiles y elegantes',
                                  'Mantén velocityFactor entre 0.2-0.3 para movimiento suave',
                                  'Ajusta particleCount según el tamaño de pantalla',
                                  'Usa heightFactor entre 3-6 para variación visual',
                                  'Combina 2-4 colores para paletas dinámicas',
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
                                  'Más de 300 partículas (causa lag en dispositivos)',
                                  'Velocidad muy alta (> 0.5) que maree al usuario',
                                  'Colores completamente opacos que oculten el contenido',
                                  'Usar como único elemento sin contexto visual',
                                  'heightFactor muy bajo (< 2) que haga partículas uniformes',
                                  'Demasiados colores (> 5) que creen confusión visual',
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
    'icon': Icons.palette,
    'title': 'Colores Personalizables',
    'description': 'Define múltiples colores para crear paletas dinámicas',
  },
  {
    'icon': Icons.flash_on,
    'title': 'Alto Rendimiento',
    'description': 'Optimizado para animar cientos de partículas fluidamente',
  },
  {
    'icon': Icons.refresh,
    'title': 'Movimiento Continuo',
    'description': 'Las partículas se mueven infinitamente de forma aleatoria',
  },
  {
    'icon': Icons.dashboard_customize,
    'title': 'Totalmente Responsivo',
    'description': 'Se adapta a cualquier tamaño de contenedor',
  },
  {
    'icon': Icons.tune,
    'title': 'Control Preciso',
    'description': 'Ajusta cantidad, velocidad y altura de partículas',
  },
  {
    'icon': Icons.integration_instructions,
    'title': 'Fácil Integración',
    'description': 'Simple de implementar como fondo o overlay',
  },
];

final _parameters = [
  {
    'name': 'maxHeight',
    'type': 'double',
    'description': 'Altura del área de animación',
    'default': 'requerido',
  },
  {
    'name': 'maxWidth',
    'type': 'double',
    'description': 'Ancho del área de animación',
    'default': 'requerido',
  },
  {
    'name': 'velocityFactor',
    'type': 'double',
    'description': 'Multiplicador de velocidad de movimiento',
    'default': '0.3',
  },
  {
    'name': 'particleCount',
    'type': 'int',
    'description': 'Número total de partículas a renderizar',
    'default': '150',
  },
  {
    'name': 'heightFactor',
    'type': 'int',
    'description': 'Factor que determina la variación de tamaño de partículas',
    'default': '5',
  },
  {
    'name': 'colors',
    'type': 'List<Color>',
    'description': 'Lista de colores para las partículas (selección aleatoria)',
    'default': 'requerido',
  },
];
