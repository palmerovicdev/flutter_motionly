import 'package:flutter/material.dart';
import 'package:flutter_motionly/widget/loaders/wave_stick_loader.dart';

import '../../common/utils.dart';

class WaveStickPage extends StatefulWidget {
  const WaveStickPage({super.key});

  @override
  State<WaveStickPage> createState() => _WaveStickPageState();
}

class _WaveStickPageState extends State<WaveStickPage> {
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
                    'WaveSticksLoader',
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
                    'Loader animado con efecto de onda gaussiana. Perfecto para estados de carga elegantes y visualizaciones de audio.',
                    style: TextStyle(
                      color: textMuted.toColor(),
                      fontSize: isNarrow ? 16 : 20,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: isNarrow ? 32 : 48),

                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 120.0),
                          child: WaveSticksLoader(
                            size: Size(isNarrow ? 300 : 400, isNarrow ? 100 : 150),
                            duration: const Duration(milliseconds: 1500),
                            numberOfSticks: isNarrow ? 12 : 15,
                            stickWidth: 6,
                            stickHeight: isNarrow ? 30 : 40,
                            middleWaveStickHeight: isNarrow ? 30 : 40,
                            stickSpacing: 12,
                            stickColor: Colors.lightBlueAccent,
                            alignment: CrossAxisAlignment.end,
                            waveWidth: 1.2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 120.0),
                          child: WaveSticksLoader(
                            size: Size(isNarrow ? 300 : 400, isNarrow ? 100 : 150),
                            duration: const Duration(milliseconds: 1500),
                            numberOfSticks: isNarrow ? 12 : 15,
                            stickWidth: 6,
                            stickHeight: isNarrow ? 40 : 50,
                            middleWaveStickHeight: isNarrow ? 40 : 50,
                            stickSpacing: 12,
                            stickColor: Colors.amber,
                            alignment: CrossAxisAlignment.start,
                            waveWidth: 1.2,
                          ),
                        ),
                      ],
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
WaveSticksLoader(
  size: Size(400, 200),
  duration: Duration(milliseconds: 1500),
  numberOfSticks: 15,
  stickWidth: 6,
  stickHeight: 40,
  middleWaveStickHeight: 50,
  stickSpacing: 12,
  stickColor: Colors.blue,
  waveWidth: 1.5,
)''', isNarrow),

                  const SizedBox(height: 80),

                  buildSectionTitle('Ejemplos', isNarrow),
                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Loader Simple',
                    'Un loader básico con configuración predeterminada',
                    isNarrow,
                    Center(
                      child: WaveSticksLoader(
                        size: Size(isNarrow ? 250 : 350, 100),
                        duration: const Duration(milliseconds: 1200),
                        numberOfSticks: 10,
                        stickWidth: 5,
                        stickHeight: 30,
                        middleWaveStickHeight: 45,
                        stickSpacing: 8,
                        stickColor: primary.toColor(),
                        waveWidth: 1.5,
                      ),
                    ),
                    '''
WaveSticksLoader(
  size: Size(350, 100),
  duration: Duration(milliseconds: 1200),
  numberOfSticks: 10,
  stickWidth: 5,
  stickHeight: 30,
  middleWaveStickHeight: 45,
  stickSpacing: 8,
  stickColor: Colors.blue,
  waveWidth: 1.5,
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Efecto Audio Spectrum',
                    'Simula un visualizador de audio con múltiples barras estrechas',
                    isNarrow,
                    Center(
                      child: WaveSticksLoader(
                        size: Size(isNarrow ? 280 : 400, 120),
                        duration: const Duration(milliseconds: 1800),
                        numberOfSticks: 20,
                        stickWidth: 4,
                        stickHeight: 20,
                        middleWaveStickHeight: 60,
                        stickSpacing: 6,
                        stickColor: secondary.toColor(),
                        waveWidth: 2.0,
                      ),
                    ),
                    '''
WaveSticksLoader(
  size: Size(400, 120),
  duration: Duration(milliseconds: 1800),
  numberOfSticks: 20,
  stickWidth: 4,
  stickHeight: 20,
  middleWaveStickHeight: 60,
  stickSpacing: 6,
  stickColor: Colors.orange,
  waveWidth: 2.0,
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Onda Estrecha y Rápida',
                    'Efecto de onda concentrada que se mueve rápidamente',
                    isNarrow,
                    Center(
                      child: WaveSticksLoader(
                        size: Size(isNarrow ? 250 : 350, 100),
                        duration: const Duration(milliseconds: 800),
                        numberOfSticks: 12,
                        stickWidth: 8,
                        stickHeight: 25,
                        middleWaveStickHeight: 50,
                        stickSpacing: 10,
                        stickColor: success.toColor(),
                        waveWidth: 0.8,
                      ),
                    ),
                    '''
WaveSticksLoader(
  size: Size(350, 100),
  duration: Duration(milliseconds: 800),
  numberOfSticks: 12,
  stickWidth: 8,
  stickHeight: 25,
  middleWaveStickHeight: 50,
  stickSpacing: 10,
  stickColor: Colors.green,
  waveWidth: 0.8,
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Efecto Espejo',
                    'Dos loaders sincronizados con alineación opuesta',
                    isNarrow,
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          WaveSticksLoader(
                            size: Size(isNarrow ? 250 : 350, isNarrow ? 80 : 100),
                            duration: const Duration(milliseconds: 1400),
                            numberOfSticks: 12,
                            stickWidth: 5,
                            stickHeight: 30,
                            middleWaveStickHeight: 35,
                            stickSpacing: 10,
                            stickColor: info.toColor(),
                            alignment: CrossAxisAlignment.end,
                            waveWidth: 1.3,
                          ),
                          WaveSticksLoader(
                            size: Size(isNarrow ? 250 : 350, isNarrow ? 80 : 100),
                            duration: const Duration(milliseconds: 1400),
                            numberOfSticks: 12,
                            stickWidth: 5,
                            stickHeight: 30,
                            middleWaveStickHeight: 35,
                            stickSpacing: 10,
                            stickColor: danger.toColor(),
                            alignment: CrossAxisAlignment.start,
                            waveWidth: 1.3,
                          ),
                        ],
                      ),
                    ),
                    '''
Stack(
  alignment: Alignment.center,
  children: [
    WaveSticksLoader(
      size: Size(350, 100),
      numberOfSticks: 12,
      stickColor: Colors.blue,
      alignment: CrossAxisAlignment.end,
      waveWidth: 1.3,
    ),
    WaveSticksLoader(
      size: Size(350, 100),
      numberOfSticks: 12,
      stickColor: Colors.red,
      alignment: CrossAxisAlignment.start,
      waveWidth: 1.3,
    ),
  ],
)''',
                  ),

                  const SizedBox(height: 80),

                  buildSectionTitle('Propiedades', isNarrow),
                  const SizedBox(height: 24),
                  buildPropertiesTable(isNarrow, _properties),

                  const SizedBox(height: 80),

                  buildSectionTitle('Uso con Controller', isNarrow),
                  const SizedBox(height: 24),
                  buildCodeBlock('''
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> 
    with TickerProviderStateMixin {
  late WaveStickAnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WaveStickAnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..start();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WaveSticksLoader(controller: _controller),
        ElevatedButton(
          onPressed: () => _controller.stopAnimation(),
          child: Text('Detener'),
        ),
        ElevatedButton(
          onPressed: () => _controller.start(),
          child: Text('Iniciar'),
        ),
      ],
    );
  }
}''', isNarrow),

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

  Widget _buildBestPractices(bool isNarrow) {
    final _dos = [
      'Ajusta waveWidth según el número de sticks. Para pocos sticks (5-10) usa valores entre 1.0-1.5. Para muchos sticks (15+) usa 1.5-2.5',
      'Mantén la duración proporcional. Animaciones más rápidas (<1000ms) funcionan mejor con ondas estrechas (waveWidth < 1.5)',
      'Usa alignment para efectos creativos. CrossAxisAlignment.end/start permiten crear efectos de espejo o visualizadores de audio',
    ];
    final _donts = [
      'Evita valores extremos de waveWidth. Valores menores a 0.5 o mayores a 3.0 pueden hacer la animación parecer brusca',
      'No olvides el spacing adecuado. Si stickWidth es grande, aumenta stickSpacing proporcionalmente para evitar solapamiento visual',
    ];
    if (isNarrow) {
      return Column(
        children: [
          buildPracticeCard('✓ Hacer', _dos, isNarrow, true),
          const SizedBox(height: 20),
          buildPracticeCard('✗ Evitar', _donts, isNarrow, false),
        ],
      );
    } else {
      return Row(
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
      );
    }
  }
}

final _features = [
  {
    'icon': Icons.waves,
    'title': 'Efecto de Onda Gaussiana',
    'description': 'Animación suave basada en función gaussiana para transiciones naturales',
  },
  {
    'icon': Icons.tune,
    'title': 'Totalmente Personalizable',
    'description': 'Controla tamaños, colores, spacing, duración y ancho de onda',
  },
  {
    'icon': Icons.speed,
    'title': 'Rendimiento Optimizado',
    'description': 'Animaciones fluidas con AnimatedBuilder para eficiencia máxima',
  },
  {
    'icon': Icons.control_camera,
    'title': 'Controller Opcional',
    'description': 'Controla la animación externamente con WaveStickAnimationController',
  },
];

final _properties = [
  {
    'name': 'size',
    'type': 'Size',
    'default': 'Size(100, 50)',
    'description': 'Tamaño del contenedor del loader',
  },
  {
    'name': 'duration',
    'type': 'Duration',
    'default': '1500ms',
    'description': 'Duración de un ciclo completo de la animación',
  },
  {
    'name': 'numberOfSticks',
    'type': 'int',
    'default': '5',
    'description': 'Número de barras/sticks a mostrar',
  },
  {
    'name': 'stickWidth',
    'type': 'double',
    'default': '5.0',
    'description': 'Ancho de cada stick individual',
  },
  {
    'name': 'stickHeight',
    'type': 'double',
    'default': '20.0',
    'description': 'Altura mínima de los sticks (altura en reposo)',
  },
  {
    'name': 'middleWaveStickHeight',
    'type': 'double',
    'default': '30.0',
    'description': 'Altura máxima en el centro de la onda',
  },
  {
    'name': 'stickSpacing',
    'type': 'double',
    'default': '5.0',
    'description': 'Espacio horizontal entre sticks',
  },
  {
    'name': 'stickColor',
    'type': 'Color',
    'default': 'Colors.blue',
    'description': 'Color de los sticks',
  },
  {
    'name': 'alignment',
    'type': 'CrossAxisAlignment',
    'default': 'center',
    'description': 'Alineación vertical de los sticks (start, center, end)',
  },
  {
    'name': 'waveWidth',
    'type': 'double',
    'default': '1.5',
    'description': 'Ancho de la onda (0.5-3.0 recomendado). Mayor = onda más ancha',
  },
  {
    'name': 'controller',
    'type': 'WaveStickAnimationController?',
    'default': 'null',
    'description': 'Controller opcional para control externo de la animación',
  },
];
