import 'package:flutter/material.dart';
import 'package:flutter_motionly/widget/button/pulsating_button.dart';

import '../../common/utils.dart';

class PulsatingButtonDocPage extends StatefulWidget {
  const PulsatingButtonDocPage({super.key});

  @override
  State<PulsatingButtonDocPage> createState() => _PulsatingButtonDocPageState();
}

class _PulsatingButtonDocPageState extends State<PulsatingButtonDocPage> {
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
                    'PulsatingButton',
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
                    'Botón con efecto de pulsación continua. Perfecto para llamar la atención y crear CTAs atractivos.',
                    style: TextStyle(
                      color: textMuted.toColor(),
                      fontSize: isNarrow ? 16 : 20,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: isNarrow ? 32 : 48),

                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 80,
                      child: PulsatingButton(
                        width: 180,
                        height: 60,
                        pulsationSize: 15,
                        color: primary.toColor(),
                        border: BoxBorder.all(
                          color: bgDark.toColor(),
                          width: 2,
                        ),
                        pulsationDuration: const Duration(milliseconds: 800),
                        onClick: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('¡Botón presionado!'),
                              backgroundColor: primary.toColor(),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Text(
                          'Presióname',
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
PulsatingButton(
  width: 180,
  height: 60,
  color: Colors.blue,
  borderColor: Colors.white,
  onClick: () {
    print('Botón presionado');
  },
  child: Text('Presióname'),
)''', isNarrow),

                  const SizedBox(height: 80),

                  buildSectionTitle('Ejemplos', isNarrow),
                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Botón Call to Action',
                    'Ideal para acciones principales que requieren atención',
                    isNarrow,
                    Center(
                      child: SizedBox(
                        height: 84,
                        width: 220,
                        child: PulsatingButton(
                          width: 200,
                          height: 64,
                          color: success.toColor(),
                          pulsationDuration: const Duration(milliseconds: 1200),
                          onClick: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.download,
                                color: text.toColor(),
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Descargar',
                                style: TextStyle(
                                  color: text.toColor(),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    '''
PulsatingButton(
  width: 200,
  height: 64,
  color: Colors.green,
  borderColor: Colors.white,
  borderRadius: 16,
  child: Row(
    children: [
      Icon(Icons.download),
      SizedBox(width: 12),
      Text('Descargar'),
    ],
  ),
  onClick: () => downloadFile(),
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Botón de Alerta',
                    'Perfecto para notificaciones o acciones urgentes',
                    isNarrow,
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 80,
                        child: PulsatingButton(
                          width: 180,
                          height: 60,
                          color: danger.toColor(),
                          pulsationDuration: const Duration(milliseconds: 800),
                          onClick: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.notification_important,
                                color: text.toColor(),
                                size: 22,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Alerta',
                                style: TextStyle(
                                  color: text.toColor(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    '''
PulsatingButton(
  width: 180,
  height: 60,
  color: Colors.red,
  borderColor: Colors.white,
  borderRadius: 30,
  pulsationDuration: Duration(milliseconds: 800),
  child: Row(
    children: [
      Icon(Icons.notification_important),
      SizedBox(width: 8),
      Text('Alerta'),
    ],
  ),
  onClick: () => showAlert(),
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Variaciones de Tamaño y Velocidad',
                    'Experimenta con diferentes tamaños y velocidades de pulsación',
                    isNarrow,
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 24,
                      runSpacing: 24,
                      children: [
                        SizedBox(
                          width: 140,
                          height: 70,
                          child: PulsatingButton(
                            width: 120,
                            height: 50,
                            color: info.toColor(),
                            pulsationDuration: const Duration(milliseconds: 600),
                            onClick: () {},
                            child: Text(
                              'Rápido',
                              style: TextStyle(
                                color: text.toColor(),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 160,
                          height: 76,
                          child: PulsatingButton(
                            width: 140,
                            height: 56,
                            color: warning.toColor(),
                            pulsationDuration: const Duration(milliseconds: 1000),
                            onClick: () {},
                            child: Text(
                              'Normal',
                              style: TextStyle(
                                color: text.toColor(),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 180,
                          height: 82,
                          child: PulsatingButton(
                            width: 160,
                            height: 62,
                            color: secondary.toColor(),
                            pulsationDuration: const Duration(milliseconds: 1500),
                            onClick: () {},
                            child: Text(
                              'Lento',
                              style: TextStyle(
                                color: text.toColor(),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    null,
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Botón Circular',
                    'Crea botones circulares para acciones flotantes',
                    isNarrow,
                    Center(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: PulsatingButton(
                          width: 80,
                          height: 80,
                          color: primary.toColor(),
                          pulsationDuration: const Duration(milliseconds: 900),
                          onClick: () {},
                          child: Icon(
                            Icons.add,
                            color: text.toColor(),
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                    '''
PulsatingButton(
  width: 80,
  height: 80,
  color: Colors.blue,
  borderColor: Colors.white,
  borderRadius: 40,
  child: Icon(Icons.add, size: 32),
  onClick: () => addItem(),
)''',
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
      'icon': Icons.graphic_eq,
      'title': 'Pulsación Continua',
      'description': 'Animación de escala suave que atrae la atención',
    },
    {
      'icon': Icons.palette,
      'title': 'Altamente Personalizable',
      'description': 'Controla colores, tamaño, velocidad y forma',
    },
    {
      'icon': Icons.touch_app,
      'title': 'Interactivo',
      'description': 'Responde al toque con callback onClick',
    },
    {
      'icon': Icons.speed,
      'title': 'Optimizado',
      'description': 'Animaciones fluidas sin afectar el rendimiento',
    },
  ];

  final properties = [
    {
      'name': 'width',
      'type': 'double',
      'default': '120.0',
      'description': 'Ancho del botón',
    },
    {
      'name': 'height',
      'type': 'double',
      'default': '60.0',
      'description': 'Altura del botón',
    },
    {
      'name': 'color',
      'type': 'Color',
      'default': 'Colors.blue',
      'description': 'Color principal del botón',
    },
    {
      'name': 'borderColor',
      'type': 'Color',
      'default': 'Colors.white',
      'description': 'Color del borde del botón',
    },
    {
      'name': 'borderRadius',
      'type': 'double',
      'default': '12.0',
      'description': 'Radio de las esquinas',
    },
    {
      'name': 'pulsationDuration',
      'type': 'Duration',
      'default': '800ms',
      'description': 'Duración de cada ciclo de pulsación',
    },
    {
      'name': 'curve',
      'type': 'Curve',
      'default': 'Curves.easeInOut',
      'description': 'Curva de animación',
    },
    {
      'name': 'child',
      'type': 'Widget?',
      'default': 'null',
      'description': 'Contenido interno del botón',
    },
    {
      'name': 'onClick',
      'type': 'VoidCallback?',
      'default': 'null',
      'description': 'Callback al presionar el botón',
    },
  ];

  Widget _buildBestPractices(bool isNarrow) {
    var dos = [
      'Usa para CTAs importantes que necesiten destacar',
      'Mantén duraciones entre 800-1500ms para efecto sutil',
      'Combina con texto o iconos claros',
      'Usa colores que contrasten con el fondo',
      'Considera el contexto: no abuses del efecto',
    ];
    var donts = [
      'Múltiples botones pulsando simultáneamente',
      'Duraciones muy rápidas (< 500ms) que distraen',
      'Usar en todos los botones de la interfaz',
      'Colores muy brillantes que cansen la vista',
      'Botones muy grandes con pulsación intensa',
    ];
    if (isNarrow) {
      return Column(
        children: [
          _buildPracticesList('✓ Hacer', dos, success.toColor(), isNarrow),
          const SizedBox(height: 32),
          _buildPracticesList('✗ Evitar', donts, danger.toColor(), isNarrow),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildPracticesList('✓ Hacer', dos, success.toColor(), isNarrow),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: _buildPracticesList('✗ Evitar', donts, danger.toColor(), isNarrow),
        ),
      ],
    );
  }

  Widget _buildPracticesList(String title, List<String> items, Color color, bool isNarrow) {
    return Container(
      padding: EdgeInsets.all(isNarrow ? 20 : 28),
      decoration: BoxDecoration(
        color: bgLight.toColor().withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: isNarrow ? 18 : 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(top: 7, right: 12),
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          color: textMuted.toColor(),
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

