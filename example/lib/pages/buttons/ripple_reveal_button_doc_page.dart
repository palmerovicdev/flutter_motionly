import 'package:flutter/material.dart';
import 'package:flutter_motionly/widget/button/ripple_reveal_button.dart';

import '../../common/utils.dart';

class RippleRevealButtonDocPage extends StatefulWidget {
  const RippleRevealButtonDocPage({super.key});

  @override
  State<RippleRevealButtonDocPage> createState() => _RippleRevealButtonDocPageState();
}

class _RippleRevealButtonDocPageState extends State<RippleRevealButtonDocPage> {
  bool _example1Selected = false;
  bool _example2Selected = true;
  bool _example3Selected = false;
  bool _example4Selected = true;

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
                    'RippleRevealButton',
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
                    'Botón dinámico con animación circular de revelación. Perfecto para crear toggles atractivos y elementos UI interactivos.',
                    style: TextStyle(
                      color: textMuted.toColor(),
                      fontSize: isNarrow ? 16 : 20,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: isNarrow ? 32 : 48),

                  Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: RippleRevealButton(
                        widgetA: Text(
                          'Presiona',
                          style: TextStyle(
                            color: text.toColor(),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        widgetB: Text(
                          'Otra vez',
                          style: TextStyle(
                            color: bgDark.toColor(),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        height: 56,
                        radius: 12,
                        backgroundColorA: text.toColor(),
                        backgroundColorB: primary.toColor(),
                        rippleColorA: primary.toColor(),
                        rippleColorB: text.toColor(),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(3),
                        selected: _example1Selected,
                        duration: const Duration(milliseconds: 400),
                        onPressed: () {
                          setState(() {
                            _example1Selected = !_example1Selected;
                          });
                        },
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
RippleRevealButton(
  widgetA: Text('Estado A'),
  widgetB: Text('Estado B'),
  backgroundColorA: Colors.black,
  backgroundColorB: Colors.white,
  rippleColorA: Colors.white,
  rippleColorB: Colors.black,
  selected: isSelected,
  onPressed: () {
    setState(() => isSelected = !isSelected);
  },
)''', isNarrow),

                  const SizedBox(height: 80),

                  buildSectionTitle('Ejemplos', isNarrow),
                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Botón con Icono',
                    'Ideal para favoritos, likes o acciones simples',
                    isNarrow,
                    Center(
                      child: SizedBox(
                        width: 64,
                        height: 64,
                        child: RippleRevealButton(
                          widgetA: Icon(
                            Icons.favorite_border,
                            color: text.toColor(),
                            size: 28,
                          ),
                          widgetB: Icon(
                            Icons.favorite,
                            color: bgDark.toColor(),
                            size: 28,
                          ),
                          height: 64,
                          radius: 16,
                          backgroundColorA: text.toColor(),
                          backgroundColorB: danger.toColor(),
                          rippleColorA: danger.toColor(),
                          rippleColorB: text.toColor(),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(3),
                          selected: _example2Selected,
                          duration: const Duration(milliseconds: 350),
                          onPressed: () {
                            setState(() {
                              _example2Selected = !_example2Selected;
                            });
                          },
                        ),
                      ),
                    ),
                    '''
RippleRevealButton(
  widgetA: Icon(Icons.favorite_border),
  widgetB: Icon(Icons.favorite),
  height: 64,
  radius: 16,
  backgroundColorA: Colors.white,
  backgroundColorB: Colors.red,
  rippleColorA: Colors.red,
  rippleColorB: Colors.white,
  selected: isFavorite,
  onPressed: () => toggleFavorite(),
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Botón con Icono y Texto',
                    'Perfecto para controles de media o acciones contextuales',
                    isNarrow,
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 320),
                        child: RippleRevealButton(
                          widgetA: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.play_arrow,
                                color: text.toColor(),
                                size: 22,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Reproducir',
                                style: TextStyle(
                                  color: text.toColor(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          widgetB: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.pause,
                                color: bgDark.toColor(),
                                size: 22,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Pausar',
                                style: TextStyle(
                                  color: bgDark.toColor(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          height: 52,
                          radius: 26,
                          backgroundColorA: text.toColor(),
                          backgroundColorB: success.toColor(),
                          rippleColorA: success.toColor(),
                          rippleColorB: text.toColor(),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(3),
                          selected: _example3Selected,
                          duration: const Duration(milliseconds: 400),
                          onPressed: () {
                            setState(() {
                              _example3Selected = !_example3Selected;
                            });
                          },
                        ),
                      ),
                    ),
                    '''
RippleRevealButton(
  widgetA: Row(
    children: [
      Icon(Icons.play_arrow),
      SizedBox(width: 8),
      Text('Reproducir'),
    ],
  ),
  widgetB: Row(
    children: [
      Icon(Icons.pause),
      SizedBox(width: 8),
      Text('Pausar'),
    ],
  ),
  height: 52,
  radius: 26,
  selected: isPlaying,
  onPressed: () => togglePlay(),
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Variaciones de Tamaño',
                    'Crea botones de diferentes tamaños para varios casos de uso',
                    isNarrow,
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        SizedBox(
                          width: 100,
                          child: RippleRevealButton(
                            widgetA: Text(
                              'Small',
                              style: TextStyle(
                                color: text.toColor(),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            widgetB: Text(
                              'Small',
                              style: TextStyle(
                                color: bgDark.toColor(),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            height: 36,
                            radius: 8,
                            backgroundColorA: text.toColor(),
                            backgroundColorB: info.toColor(),
                            rippleColorA: info.toColor(),
                            rippleColorB: text.toColor(),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(2),
                            selected: _example4Selected,
                            duration: const Duration(milliseconds: 300),
                            onPressed: () {
                              setState(() {
                                _example4Selected = !_example4Selected;
                              });
                            },
                          ),
                        ),

                        SizedBox(
                          width: 120,
                          child: RippleRevealButton(
                            widgetA: Text(
                              'Medium',
                              style: TextStyle(
                                color: text.toColor(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            widgetB: Text(
                              'Medium',
                              style: TextStyle(
                                color: bgDark.toColor(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            height: 44,
                            radius: 10,
                            backgroundColorA: text.toColor(),
                            backgroundColorB: warning.toColor(),
                            rippleColorA: warning.toColor(),
                            rippleColorB: text.toColor(),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(2),
                            selected: !_example4Selected,
                            duration: const Duration(milliseconds: 300),
                            onPressed: () {
                              setState(() {
                                _example4Selected = !_example4Selected;
                              });
                            },
                          ),
                        ),

                        SizedBox(
                          width: 140,
                          child: RippleRevealButton(
                            widgetA: Text(
                              'Large',
                              style: TextStyle(
                                color: text.toColor(),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            widgetB: Text(
                              'Large',
                              style: TextStyle(
                                color: bgDark.toColor(),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            height: 56,
                            radius: 12,
                            backgroundColorA: text.toColor(),
                            backgroundColorB: primary.toColor(),
                            rippleColorA: primary.toColor(),
                            rippleColorB: text.toColor(),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(3),
                            selected: _example4Selected,
                            duration: const Duration(milliseconds: 350),
                            onPressed: () {
                              setState(() {
                                _example4Selected = !_example4Selected;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    null,
                  ),

                  const SizedBox(height: 80),

                  buildSectionTitle('Propiedades', isNarrow),
                  const SizedBox(height: 24),
                  buildPropertiesTable(isNarrow, properties),

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
      'icon': Icons.water_drop,
      'title': 'Efecto Ripple Circular',
      'description': 'Animación radial suave desde la posición del tap',
    },
    {
      'icon': Icons.palette,
      'title': 'Diseño Dual',
      'description': 'Personaliza ambos estados independientemente',
    },
    {
      'icon': Icons.touch_app,
      'title': 'Interactivo',
      'description': 'Responde al toque con feedback visual',
    },
    {
      'icon': Icons.sync,
      'title': 'Reversible',
      'description': 'Alterna entre estados sin problemas',
    },
  ];

  final properties = [
    {
      'name': 'widgetA',
      'type': 'Widget',
      'default': '-',
      'description': 'Contenido en estado seleccionado',
    },
    {
      'name': 'widgetB',
      'type': 'Widget',
      'default': '-',
      'description': 'Contenido en estado no seleccionado',
    },
    {
      'name': 'backgroundColorA',
      'type': 'Color',
      'default': 'Colors.black',
      'description': 'Color de fondo estado A',
    },
    {
      'name': 'backgroundColorB',
      'type': 'Color',
      'default': 'Colors.white',
      'description': 'Color de fondo estado B',
    },
    {
      'name': 'rippleColorA',
      'type': 'Color',
      'default': 'Colors.white',
      'description': 'Color ripple estado A',
    },
    {
      'name': 'rippleColorB',
      'type': 'Color',
      'default': 'Colors.black',
      'description': 'Color ripple estado B',
    },
    {
      'name': 'height',
      'type': 'double',
      'default': '48.0',
      'description': 'Altura del botón',
    },
    {
      'name': 'radius',
      'type': 'double',
      'default': '2.0',
      'description': 'Radio de las esquinas',
    },
    {
      'name': 'selected',
      'type': 'bool?',
      'default': 'null',
      'description': 'Estado actual (control externo)',
    },
    {
      'name': 'duration',
      'type': 'Duration',
      'default': '300ms',
      'description': 'Duración de la animación',
    },
    {
      'name': 'alignment',
      'type': 'Alignment',
      'default': 'center',
      'description': 'Alineación del contenido',
    },
    {
      'name': 'padding',
      'type': 'EdgeInsets',
      'default': 'horizontal(16)',
      'description': 'Padding interno',
    },
  ];

  Widget _buildBestPractices(bool isNarrow) {
    var dos = [
      'Usa colores contrastantes para mejor feedback visual',
      'Mantén las animaciones suaves (300-500ms)',
      'Asegura que ambos estados sean distinguibles',
      'Proporciona padding apropiado para el contenido',
      'Usa iconos o texto significativos',
    ];
    var donts = [
      'Animaciones muy rápidas (< 200ms)',
      'Colores similares entre estados',
      'Widgets complejos que ralenticen el render',
      'Botones muy pequeños para touch targets',
      'Estados sin diferencias visuales claras',
    ];
    if (isNarrow) {
      return Column(
        children: [
          buildPracticeCard('✓ Hacer', dos, isNarrow, true),
          const SizedBox(height: 20),
          buildPracticeCard('✗ Evitar', donts, isNarrow, false),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: buildPracticeCard('✓ Hacer', dos, isNarrow, true),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: buildPracticeCard('✗ Evitar', donts, isNarrow, false),
          ),
        ],
      );
    }
  }
}
