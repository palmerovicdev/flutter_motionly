import 'package:flutter/material.dart';
import 'package:flutter_motionly/widget/button/rect_reveal_button.dart';

import '../../common/utils.dart';

class RectRevealButtonDocPage extends StatefulWidget {
  const RectRevealButtonDocPage({super.key});

  @override
  State<RectRevealButtonDocPage> createState() => _RectRevealButtonDocPageState();
}

class _RectRevealButtonDocPageState extends State<RectRevealButtonDocPage> {
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
                    'RectRevealButton',
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
                    'Botón animado con efecto reveal rectangular. Ideal para toggles con dirección personalizable.',
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
                      child: RectRevealButton(
                        widgetA: Text(
                          'Activado',
                          style: TextStyle(
                            color: bgDark.toColor(),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        widgetB: Text(
                          'Desactivado',
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
                        revealDirection: RevealDirection.fromClick,
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
RectRevealButton(
  widgetA: Text('ON'),
  widgetB: Text('OFF'),
  backgroundColorA: Colors.green,
  backgroundColorB: Colors.grey,
  rippleColorA: Colors.green,
  rippleColorB: Colors.grey,
  revealDirection: RevealDirection.fromLeft,
  selected: isActive,
  onPressed: () {
    setState(() => isActive = !isActive);
  },
)''', isNarrow),

                  const SizedBox(height: 80),

                  buildSectionTitle('Ejemplos', isNarrow),
                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Desde Click',
                    'El reveal se expande desde donde tocas',
                    isNarrow,
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: RectRevealButton(
                          widgetA: Text(
                            'Click Anywhere',
                            style: TextStyle(
                              color: bgDark.toColor(),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          widgetB: Text(
                            'Interactive',
                            style: TextStyle(
                              color: bgDark.toColor(),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          height: 52,
                          radius: 12,
                          backgroundColorA: text.toColor(),
                          backgroundColorB: success.toColor(),
                          rippleColorA: success.toColor(),
                          rippleColorB: text.toColor(),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(3),
                          selected: _example2Selected,
                          duration: const Duration(milliseconds: 350),
                          revealDirection: RevealDirection.fromClick,
                          onPressed: () {
                            setState(() {
                              _example2Selected = !_example2Selected;
                            });
                          },
                        ),
                      ),
                    ),
                    '''
RectRevealButton(
  widgetA: Text('Click Anywhere'),
  widgetB: Text('Interactive'),
  revealDirection: RevealDirection.fromClick,
  selected: isSelected,
  onPressed: () => toggle(),
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Desde Izquierda',
                    'El reveal se expande de izquierda a derecha',
                    isNarrow,
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: RectRevealButton(
                          widgetA: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_forward,
                                color: bgDark.toColor(),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Next',
                                style: TextStyle(
                                  color: bgDark.toColor(),
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
                                Icons.check,
                                color: bgDark.toColor(),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Complete',
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
                          backgroundColorB: info.toColor(),
                          rippleColorA: info.toColor(),
                          rippleColorB: text.toColor(),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(3),
                          selected: _example3Selected,
                          duration: const Duration(milliseconds: 400),
                          revealDirection: RevealDirection.fromLeft,
                          onPressed: () {
                            setState(() {
                              _example3Selected = !_example3Selected;
                            });
                          },
                        ),
                      ),
                    ),
                    '''
RectRevealButton(
  widgetA: Row(
    children: [
      Icon(Icons.arrow_forward),
      Text('Next'),
    ],
  ),
  widgetB: Row(
    children: [
      Icon(Icons.check),
      Text('Complete'),
    ],
  ),
  revealDirection: RevealDirection.fromLeft,
  selected: isComplete,
  onPressed: () => proceed(),
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Desde Derecha',
                    'El reveal se expande de derecha a izquierda',
                    isNarrow,
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: RectRevealButton(
                          widgetA: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Back',
                                style: TextStyle(
                                  color: bgDark.toColor(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.arrow_back,
                                color: bgDark.toColor(),
                                size: 20,
                              ),
                            ],
                          ),
                          widgetB: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Cancel',
                                style: TextStyle(
                                  color: bgDark.toColor(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                Icons.close,
                                color: bgDark.toColor(),
                                size: 20,
                              ),
                            ],
                          ),
                          height: 52,
                          radius: 26,
                          backgroundColorA: text.toColor(),
                          backgroundColorB: warning.toColor(),
                          rippleColorA: warning.toColor(),
                          rippleColorB: text.toColor(),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(3),
                          selected: _example4Selected,
                          duration: const Duration(milliseconds: 400),
                          revealDirection: RevealDirection.fromRight,
                          onPressed: () {
                            setState(() {
                              _example4Selected = !_example4Selected;
                            });
                          },
                        ),
                      ),
                    ),
                    '''
RectRevealButton(
  widgetA: Row(
    children: [
      Text('Back'),
      Icon(Icons.arrow_back),
    ],
  ),
  widgetB: Row(
    children: [
      Text('Cancel'),
      Icon(Icons.close),
    ],
  ),
  revealDirection: RevealDirection.fromRight,
  selected: isCancelled,
  onPressed: () => goBack(),
)''',
                  ),

                  const SizedBox(height: 80),

                  buildSectionTitle('Propiedades', isNarrow),
                  const SizedBox(height: 24),
                  buildPropertiesTable(isNarrow, properties),

                  const SizedBox(height: 80),

                  buildSectionTitle('Direcciones de Reveal', isNarrow),
                  const SizedBox(height: 24),
                  _buildDirectionsInfo(isNarrow),

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
      'icon': Icons.swipe,
      'title': 'Reveal Rectangular',
      'description': 'Expansión horizontal suave y direccional',
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'Direcciones Múltiples',
      'description': 'Desde click, izquierda o derecha',
    },
    {
      'icon': Icons.touch_app,
      'title': 'Dinámico',
      'description': 'Responde a la posición del tap',
    },
    {
      'icon': Icons.settings,
      'title': 'Personalizable',
      'description': 'Control completo de colores y duración',
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
      'description': 'Color reveal estado A',
    },
    {
      'name': 'rippleColorB',
      'type': 'Color',
      'default': 'Colors.black',
      'description': 'Color reveal estado B',
    },
    {
      'name': 'revealDirection',
      'type': 'RevealDirection',
      'default': 'fromClick',
      'description': 'Dirección del reveal',
    },
    {
      'name': 'height',
      'type': 'double',
      'default': '48.0',
      'description': 'Altura del botón',
    },
    {
      'name': 'width',
      'type': 'double?',
      'default': 'null',
      'description': 'Ancho del botón (opcional)',
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
  ];

  Widget _buildDirectionsInfo(bool isNarrow) {
    final directions = [
      {
        'name': 'RevealDirection.fromClick',
        'description': 'El reveal se expande desde el punto exacto donde el usuario hace tap. Crea un efecto dinámico y responsive.',
      },
      {
        'name': 'RevealDirection.fromLeft',
        'description': 'El reveal siempre se expande desde el lado izquierdo hacia la derecha. Útil para indicar progresión.',
      },
      {
        'name': 'RevealDirection.fromRight',
        'description': 'El reveal siempre se expande desde el lado derecho hacia la izquierda. Útil para acciones de retroceso.',
      },
    ];

    return Column(
      children: directions.map((dir) {
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
              Text(
                dir['name']!,
                style: TextStyle(
                  color: primary.toColor(),
                  fontSize: isNarrow ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 12),
              Text(
                dir['description']!,
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
      'Usa fromLeft para indicar progresión o activación',
      'Usa fromRight para indicar retroceso o desactivación',
      'Usa fromClick para interacciones más dinámicas',
      'Combina con iconos direccionales apropiados',
      'Mantén duraciones entre 300-500ms',
    ];
    var donts = [
      'Usar direcciones inconsistentes con el significado',
      'Animaciones muy lentas (> 600ms)',
      'Mezclar direcciones sin contexto claro',
      'Colores que no contrasten suficientemente',
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
