import 'package:flutter/material.dart';
import 'package:flutter_motionly/widget/button/focus_button.dart';

import '../../common/utils.dart';

class FocusButtonDocPage extends StatelessWidget {
  FocusButtonDocPage({super.key});

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
                    'FocusButton',
                    style: TextStyle(
                      color: text.toColor(),
                      fontSize: isNarrow ? 36 : 72,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                      letterSpacing: -1.5,
                    ),
                  ),
                  SizedBox(height: isNarrow ? 16 : 24),
                  Text(
                    'Botón con gradiente animado en el borde que rota continuamente. Perfecto para CTAs y elementos destacados.',
                    style: TextStyle(
                      color: textMuted.toColor(),
                      fontSize: isNarrow ? 16 : 20,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: isNarrow ? 32 : 48),

                  Center(
                    child: FocusButton(
                      width: isNarrow ? null : 280,
                      height: 56,
                      borderRadius: 12,
                      borderWidth: 2.5,
                      backgroundColor: bgDark.toColor(),
                      gradientColors: [
                        primary.toColor(),
                        secondary.toColor(),
                        danger.toColor(),
                        warning.toColor(),
                        primary.toColor(),
                      ],
                      duration: const Duration(seconds: 3),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Click Me',
                          style: TextStyle(
                            color: text.toColor(),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
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
                  buildFeatureGrid(isNarrow, features),

                  const SizedBox(height: 80),

                  buildSectionTitle('Uso Básico', isNarrow),
                  const SizedBox(height: 24),
                  buildCodeBlock('''
FocusButton(
  child: Text(
    'Premium',
    style: TextStyle(color: Colors.white),
  ),
  onPressed: () => print('Clicked!'),
  gradientColors: [
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.blue,
  ],
  borderRadius: 12,
  height: 56,
)''', isNarrow),

                  const SizedBox(height: 80),

                  buildSectionTitle('Ejemplos', isNarrow),
                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Call to Action',
                    'Ideal para botones principales que necesitan llamar la atención',
                    isNarrow,
                    Center(
                      child: FocusButton(
                        width: isNarrow ? null : 240,
                        height: 52,
                        borderRadius: 26,
                        borderWidth: 2,
                        backgroundColor: bgDark.toColor(),
                        gradientColors: [
                          success.toColor(),
                          primary.toColor(),
                          secondary.toColor(),
                          success.toColor(),
                        ],
                        duration: const Duration(seconds: 2),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: Text(
                            'Comenzar Ahora',
                            style: TextStyle(
                              color: text.toColor(),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    '''
FocusButton(
  child: Text('Comenzar Ahora'),
  height: 52,
  borderRadius: 26,
  gradientColors: [
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.green,
  ],
  onPressed: () => startNow(),
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Botón con Icono',
                    'Combina iconos y texto para acciones más expresivas',
                    isNarrow,
                    Center(
                      child: FocusButton(
                        width: isNarrow ? null : 220,
                        height: 50,
                        borderRadius: 12,
                        borderWidth: 2,
                        backgroundColor: bg.toColor(),
                        gradientColors: [
                          info.toColor(),
                          primary.toColor(),
                          secondary.toColor(),
                          info.toColor(),
                        ],
                        duration: const Duration(milliseconds: 2500),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: text.toColor(),
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Premium',
                                style: TextStyle(
                                  color: text.toColor(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    '''
FocusButton(
  child: Row(
    children: [
      Icon(Icons.star),
      SizedBox(width: 10),
      Text('Premium'),
    ],
  ),
  gradientColors: [
    Colors.cyan,
    Colors.blue,
    Colors.orange,
    Colors.cyan,
  ],
  onPressed: () => upgrade(),
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Botón Cuadrado',
                    'Perfecto para iconos únicos o acciones rápidas',
                    isNarrow,
                    Center(
                      child: FocusButton(
                        width: 60,
                        height: 60,
                        borderRadius: 12,
                        borderWidth: 2.5,
                        backgroundColor: bgDark.toColor(),
                        gradientColors: [
                          danger.toColor(),
                          secondary.toColor(),
                          warning.toColor(),
                          danger.toColor(),
                        ],
                        duration: const Duration(seconds: 2),
                        onPressed: () {},
                        child: Icon(
                          Icons.favorite,
                          color: text.toColor(),
                          size: 26,
                        ),
                      ),
                    ),
                    '''
FocusButton(
  width: 60,
  height: 60,
  borderRadius: 12,
  child: Icon(Icons.favorite),
  gradientColors: [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.red,
  ],
  onPressed: () => like(),
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Velocidades de Animación',
                    'Controla la velocidad del gradiente con duration',
                    isNarrow,
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        FocusButton(
                          width: isNarrow ? 100 : 120,
                          height: 46,
                          borderRadius: 10,
                          borderWidth: 2,
                          backgroundColor: bgDark.toColor(),
                          gradientColors: [
                            info.toColor(),
                            primary.toColor(),
                            secondary.toColor(),
                            bgDark.toColor(),
                            info.toColor(),
                          ],
                          duration: const Duration(milliseconds: 1000),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'Rápido',
                              style: TextStyle(
                                color: text.toColor(),
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),

                        FocusButton(
                          width: isNarrow ? 100 : 120,
                          height: 46,
                          borderRadius: 10,
                          borderWidth: 2,
                          backgroundColor: bgDark.toColor(),
                          gradientColors: [
                            info.toColor(),
                            primary.toColor(),
                            secondary.toColor(),
                            bgDark.toColor(),
                            info.toColor(),
                          ],
                          duration: const Duration(milliseconds: 2000),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'Normal',
                              style: TextStyle(
                                color: text.toColor(),
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),

                        FocusButton(
                          width: isNarrow ? 100 : 120,
                          height: 46,
                          borderRadius: 10,
                          borderWidth: 2,
                          backgroundColor: bgDark.toColor(),
                          gradientColors: [
                            info.toColor(),
                            primary.toColor(),
                            secondary.toColor(),
                            bgDark.toColor(),
                            info.toColor(),
                          ],
                          duration: const Duration(milliseconds: 4000),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'Lento',
                              style: TextStyle(
                                color: text.toColor(),
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    '''
// Rápido (1 segundo)
FocusButton(
  duration: Duration(seconds: 1),
  child: Text('Rápido'),
  ...
)

// Normal (2 segundos) - Por defecto
FocusButton(
  duration: Duration(seconds: 2),
  child: Text('Normal'),
  ...
)

// Lento (4 segundos)
FocusButton(
  duration: Duration(seconds: 4),
  child: Text('Lento'),
  ...
)''',
                  ),

                  const SizedBox(height: 80),

                  buildSectionTitle('Propiedades', isNarrow),
                  const SizedBox(height: 24),
                  buildPropertiesTable(isNarrow, properties),

                  const SizedBox(height: 80),

                  buildSectionTitle('Tips para Gradientes', isNarrow),
                  const SizedBox(height: 24),
                  _buildGradientTips(isNarrow),

                  const SizedBox(height: 80),

                  buildSectionTitle('Mejores Prácticas', isNarrow),
                  const SizedBox(height: 24),
                  _buildBestPractices(isNarrow),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final features = [
    {
      'icon': Icons.palette,
      'title': 'Gradiente Animado',
      'description': 'Gradiente multicolor que rota continuamente',
    },
    {
      'icon': Icons.visibility,
      'title': 'Alta Visibilidad',
      'description': 'Perfecto para CTAs que necesitan destacar',
    },
    {
      'icon': Icons.speed,
      'title': 'Velocidad Ajustable',
      'description': 'Controla la velocidad de rotación',
    },
    {
      'icon': Icons.tune,
      'title': 'Totalmente Personalizable',
      'description': 'Colores, tamaño y grosor configurables',
    },
  ];

  final properties = [
    {
      'name': 'child',
      'type': 'Widget',
      'default': '-',
      'description': 'Contenido del botón (requerido)',
    },
    {
      'name': 'onPressed',
      'type': 'VoidCallback?',
      'default': 'null',
      'description': 'Acción al presionar',
    },
    {
      'name': 'gradientColors',
      'type': 'List<Color>',
      'default': '[azul, morado, rosa...]',
      'description': 'Colores del gradiente (≥2)',
    },
    {
      'name': 'borderWidth',
      'type': 'double',
      'default': '2.0',
      'description': 'Grosor del borde animado',
    },
    {
      'name': 'borderRadius',
      'type': 'double',
      'default': '8.0',
      'description': 'Radio de las esquinas',
    },
    {
      'name': 'backgroundColor',
      'type': 'Color',
      'default': 'Colors.black',
      'description': 'Color de fondo del botón',
    },
    {
      'name': 'duration',
      'type': 'Duration',
      'default': '2s',
      'description': 'Duración de rotación completa',
    },
    {
      'name': 'height',
      'type': 'double?',
      'default': 'null',
      'description': 'Altura del botón (opcional)',
    },
    {
      'name': 'width',
      'type': 'double?',
      'default': 'null',
      'description': 'Ancho del botón (opcional)',
    },
  ];

  Widget _buildGradientTips(bool isNarrow) {
    final tips = [
      {
        'title': 'Repite el primer color',
        'description': 'Incluye el primer color al final de la lista para una transición suave sin cortes: [azul, morado, rosa, azul]',
      },
      {
        'title': 'Usa 3-5 colores',
        'description': 'Demasiados colores pueden verse desordenados. 3-5 colores crean un efecto equilibrado y atractivo.',
      },
      {
        'title': 'Colores complementarios',
        'description': 'Usa colores que se complementen en la rueda de colores para transiciones armoniosas.',
      },
      {
        'title': 'Contraste con el fondo',
        'description': 'Asegúrate de que el gradiente contraste bien con el backgroundColor del botón.',
      },
    ];

    return Column(
      children: tips.map((tip) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(isNarrow ? 20 : 24),
          decoration: BoxDecoration(
            color: bgLight.toColor().withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: border.toColor().withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.lightbulb,
                    color: warning.toColor(),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      tip['title']!,
                      style: TextStyle(
                        color: text.toColor(),
                        fontSize: isNarrow ? 16 : 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                tip['description']!,
                style: TextStyle(
                  color: textMuted.toColor(),
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBestPractices(bool isNarrow) {
    var dos = [
      'Úsalo para CTAs principales y botones premium',
      'Ajusta la velocidad según el contexto (2-4s)',
      'Mantén el grosor del borde entre 2-3px',
      'Usa colores vibrantes para mayor impacto',
      'Combina con iconos relevantes',
    ];
    var donts = [
      'Usar en muchos botones (pierde el efecto)',
      'Animaciones muy rápidas (< 1s)',
      'Demasiados colores en el gradiente (> 6)',
      'Bordes muy gruesos (> 4px)',
      'Colores que no contrasten con el fondo',
    ];
    if (isNarrow) {
      return Column(
        children: [
          buildPracticeCard('✓ Hacer', dos, success.toColor(), isNarrow),
          const SizedBox(height: 20),
          buildPracticeCard('✗ Evitar', donts, danger.toColor(), isNarrow),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: buildPracticeCard('✓ Hacer', dos, success.toColor(), isNarrow),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: buildPracticeCard('✗ Evitar', donts, danger.toColor(), isNarrow),
          ),
        ],
      );
    }
  }
}
