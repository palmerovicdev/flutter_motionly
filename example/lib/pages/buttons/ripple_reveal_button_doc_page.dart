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
                        unselectedChild: Text(
                          'Presiona',
                          style: TextStyle(
                            color: text.toColor(),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        selectedChild: Text(
                          'Otra vez',
                          style: TextStyle(
                            color: bgDark.toColor(),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        height: 56,
                        borderRadius: 12,
                        unselectedBackgroundColor: text.toColor(),
                        selectedBackgroundColor: primary.toColor(),
                        unselectedRippleColor: primary.toColor(),
                        selectedRippleColor: text.toColor(),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(3),
                        isSelected: _example1Selected,
                        animationDuration: const Duration(milliseconds: 400),
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
  selectedChild: Text('Estado A'),
  unselectedChild: Text('Estado B'),
  selectedBackgroundColor: Colors.black,
  unselectedBackgroundColor: Colors.white,
  selectedRippleColor: Colors.white,
  unselectedRippleColor: Colors.black,
  isSelected: isSelected,
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
                          unselectedChild: Icon(
                            Icons.favorite_border,
                            color: text.toColor(),
                            size: 28,
                          ),
                          selectedChild: Icon(
                            Icons.favorite,
                            color: bgDark.toColor(),
                            size: 28,
                          ),
                          height: 64,
                          borderRadius: 16,
                          unselectedBackgroundColor: text.toColor(),
                          selectedBackgroundColor: danger.toColor(),
                          unselectedRippleColor: danger.toColor(),
                          selectedRippleColor: text.toColor(),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(3),
                          isSelected: _example2Selected,
                          animationDuration: const Duration(milliseconds: 350),
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
  selectedChild: Icon(Icons.favorite),
  unselectedChild: Icon(Icons.favorite_border),
  height: 64,
  borderRadius: 16,
  selectedBackgroundColor: Colors.red,
  unselectedBackgroundColor: Colors.white,
  selectedRippleColor: Colors.white,
  unselectedRippleColor: Colors.red,
  isSelected: isFavorite,
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
                          unselectedChild: Row(
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
                          selectedChild: Row(
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
                          borderRadius: 26,
                          unselectedBackgroundColor: text.toColor(),
                          selectedBackgroundColor: success.toColor(),
                          unselectedRippleColor: success.toColor(),
                          selectedRippleColor: text.toColor(),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(3),
                          isSelected: _example3Selected,
                          animationDuration: const Duration(milliseconds: 400),
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
  selectedChild: Row(
    children: [
      Icon(Icons.play_arrow),
      SizedBox(width: 8),
      Text('Reproducir'),
    ],
  ),
  unselectedChild: Row(
    children: [
      Icon(Icons.pause),
      SizedBox(width: 8),
      Text('Pausar'),
    ],
  ),
  height: 52,
  borderRadius: 26,
  isSelected: isPlaying,
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
                            unselectedChild: Text(
                              'Small',
                              style: TextStyle(
                                color: text.toColor(),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            selectedChild: Text(
                              'Small',
                              style: TextStyle(
                                color: bgDark.toColor(),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            height: 36,
                            borderRadius: 8,
                            unselectedBackgroundColor: text.toColor(),
                            selectedBackgroundColor: info.toColor(),
                            unselectedRippleColor: info.toColor(),
                            selectedRippleColor: text.toColor(),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(2),
                            isSelected: _example4Selected,
                            animationDuration: const Duration(milliseconds: 300),
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
                            unselectedChild: Text(
                              'Medium',
                              style: TextStyle(
                                color: text.toColor(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            selectedChild: Text(
                              'Medium',
                              style: TextStyle(
                                color: bgDark.toColor(),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            height: 44,
                            borderRadius: 10,
                            unselectedBackgroundColor: text.toColor(),
                            selectedBackgroundColor: warning.toColor(),
                            unselectedRippleColor: warning.toColor(),
                            selectedRippleColor: text.toColor(),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(2),
                            isSelected: !_example4Selected,
                            animationDuration: const Duration(milliseconds: 300),
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
                            unselectedChild: Text(
                              'Large',
                              style: TextStyle(
                                color: text.toColor(),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            selectedChild: Text(
                              'Large',
                              style: TextStyle(
                                color: bgDark.toColor(),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            height: 56,
                            borderRadius: 12,
                            unselectedBackgroundColor: text.toColor(),
                            selectedBackgroundColor: primary.toColor(),
                            unselectedRippleColor: primary.toColor(),
                            selectedRippleColor: text.toColor(),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(3),
                            isSelected: _example4Selected,
                            animationDuration: const Duration(milliseconds: 350),
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
      'name': 'selectedChild',
      'type': 'Widget',
      'default': '-',
      'description': 'Contenido mostrado cuando el botón está en estado seleccionado (true).',
    },
    {
      'name': 'unselectedChild',
      'type': 'Widget?',
      'default': '-',
      'description': 'Contenido mostrado cuando el botón está en estado no seleccionado (false). Opcional; si no existe, se puede reutilizar `selectedChild`.',
    },
    {
      'name': 'selectedBackgroundColor',
      'type': 'Color',
      'default': 'Colors.black',
      'description': 'Color de fondo cuando el botón está seleccionado.',
    },
    {
      'name': 'unselectedBackgroundColor',
      'type': 'Color',
      'default': 'Colors.white',
      'description': 'Color de fondo cuando el botón está no seleccionado.',
    },
    {
      'name': 'selectedRippleColor',
      'type': 'Color',
      'default': 'Colors.white',
      'description': 'Color del círculo de ripple al pasar al estado seleccionado.',
    },
    {
      'name': 'unselectedRippleColor',
      'type': 'Color',
      'default': 'Colors.black',
      'description': 'Color del círculo de ripple al pasar al estado no seleccionado.',
    },
    {
      'name': 'width',
      'type': 'double',
      'default': '120.0',
      'description': 'Ancho del botón. Si es null, ocupa el ancho disponible.',
    },
    {
      'name': 'height',
      'type': 'double',
      'default': '48.0',
      'description': 'Altura del botón en píxeles lógicos.',
    },
    {
      'name': 'borderRadius',
      'type': 'double',
      'default': '2.0',
      'description': 'Radio de las esquinas. Debe ser >= 2.0 para un clip correcto.',
    },
    {
      'name': 'isSelected',
      'type': 'bool?',
      'default': 'null',
      'description': 'Estado controlable desde fuera. Si es null, el widget maneja su propio estado.',
    },
    {
      'name': 'animationDuration',
      'type': 'Duration',
      'default': 'Duration(milliseconds: 300)',
      'description': 'Duración de la animación del ripple.',
    },
    {
      'name': 'alignment',
      'type': 'Alignment',
      'default': 'Alignment.center',
      'description': 'Alineación del contenido dentro del botón.',
    },
    {
      'name': 'padding',
      'type': 'EdgeInsets',
      'default': 'EdgeInsets.symmetric(horizontal: 16)',
      'description': 'Padding interno del contenido.',
    },
    {
      'name': 'border',
      'type': 'BoxBorder?',
      'default': 'null',
      'description': 'Borde decorativo opcional (no cambia el área de toque).',
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
