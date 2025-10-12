import 'package:flutter/material.dart';
import 'package:flutter_motionly/widget/text/animated_text.dart';

import '../../common/utils.dart';

class AnimatedTextDocPage extends StatefulWidget {
  const AnimatedTextDocPage({super.key});

  @override
  State<AnimatedTextDocPage> createState() => _AnimatedTextDocPageState();
}

class _AnimatedTextDocPageState extends State<AnimatedTextDocPage> {
  final _textKey1 = GlobalKey<AnimatedTextState>();
  final _textKey2 = GlobalKey<AnimatedTextState>();
  final _textKey3 = GlobalKey<AnimatedTextState>();
  final _textKey4 = GlobalKey<AnimatedTextState>();
  final _textKey5 = GlobalKey<AnimatedTextState>();

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
                    'AnimatedText',
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
                    'Texto animado con efectos en cascada. Múltiples tipos de animación y modos de división.',
                    style: TextStyle(
                      color: textMuted.toColor(),
                      fontSize: isNarrow ? 16 : 20,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: isNarrow ? 32 : 48),

                  Center(
                    child: AnimatedText(
                      key: _textKey1,
                      text: 'Hello World',
                      splitType: SplitType.char,
                      animationType: AnimationType.fade,
                      fontSize: isNarrow ? 32 : 48,
                      duration: const Duration(milliseconds: 500),
                      autoPlay: true,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _textKey1.currentState?.play(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary.toColor(),
                        foregroundColor: bgDark.toColor(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      child: const Text('Reproducir'),
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
                  buildCodeBlock(
                    '''
AnimatedText(
  text: 'Hello World',
  splitType: SplitType.char,
  animationType: AnimationType.fade,
  fontSize: 32,
  duration: Duration(milliseconds: 500),
  autoPlay: true,
)''',
                    isNarrow,
                  ),

                  const SizedBox(height: 80),

                  buildSectionTitle('Tipos de Animación', isNarrow),
                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Fade',
                    'Desvanecimiento suave con deslizamiento vertical',
                    isNarrow,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedText(
                          key: _textKey2,
                          text: 'Fade Effect',
                          splitType: SplitType.char,
                          animationType: AnimationType.fade,
                          fontSize: isNarrow ? 28 : 36,
                          duration: const Duration(milliseconds: 400),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _textKey2.currentState?.play(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: info.toColor(),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Animar'),
                        ),
                      ],
                    ),
                    '''
AnimatedText(
  text: 'Fade Effect',
  animationType: AnimationType.fade,
  splitType: SplitType.char,
  fontSize: 36,
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Blur',
                    'Desenfoque progresivo a nítido',
                    isNarrow,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedText(
                          key: _textKey3,
                          text: 'Blur Effect',
                          splitType: SplitType.char,
                          animationType: AnimationType.blur,
                          fontSize: isNarrow ? 28 : 36,
                          duration: const Duration(milliseconds: 500),
                          blurFactor: 50,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _textKey3.currentState?.play(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: success.toColor(),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Animar'),
                        ),
                      ],
                    ),
                    '''
AnimatedText(
  text: 'Blur Effect',
  animationType: AnimationType.blur,
  splitType: SplitType.char,
  blurFactor: 50,
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Rotate',
                    'Rotación horizontal con perspectiva 3D',
                    isNarrow,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedText(
                          key: _textKey4,
                          text: 'Rotate 3D',
                          splitType: SplitType.char,
                          animationType: AnimationType.rotate,
                          fontSize: isNarrow ? 28 : 36,
                          duration: const Duration(milliseconds: 450),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _textKey4.currentState?.play(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: warning.toColor(),
                            foregroundColor: bgDark.toColor(),
                          ),
                          child: const Text('Animar'),
                        ),
                      ],
                    ),
                    '''
AnimatedText(
  text: 'Rotate 3D',
  animationType: AnimationType.rotate,
  splitType: SplitType.char,
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Decode',
                    '',
                    isNarrow,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedText(
                          key: _textKey5,
                          text: 'Decode Random',
                          splitType: SplitType.char,
                          animationType: AnimationType.decode,
                          fontSize: isNarrow ? 28 : 36,
                          duration: const Duration(milliseconds: 450),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _textKey5.currentState?.play(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: warning.toColor(),
                            foregroundColor: bgDark.toColor(),
                          ),
                          child: const Text('Animar'),
                        ),
                      ],
                    ),
                    '''
AnimatedText(
  text: 'Rotate 3D',
  animationType: AnimationType.decode,
  splitType: SplitType.char,
)''',
                  ),

                  const SizedBox(height: 32),

                  _buildAnimationTypesGrid(isNarrow),

                  const SizedBox(height: 80),

                  buildSectionTitle('Modos de División', isNarrow),
                  const SizedBox(height: 24),
                  _buildSplitTypesInfo(isNarrow),

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
      'icon': Icons.animation,
      'title': 'Múltiples Animaciones',
      'description': '10 tipos de animación diferentes disponibles',
    },
    {
      'icon': Icons.text_fields,
      'title': 'División Flexible',
      'description': 'Por caracteres, palabras o líneas',
    },
    {
      'icon': Icons.layers,
      'title': 'Efecto Cascada',
      'description': 'Animación secuencial automática',
    },
    {
      'icon': Icons.settings,
      'title': 'Personalizable',
      'description': 'Control total de timing y curvas',
    },
  ];

  final properties = [
    {
      'name': 'text',
      'type': 'String',
      'default': '"Animated Text"',
      'description': 'Texto a animar',
    },
    {
      'name': 'splitType',
      'type': 'SplitType',
      'default': 'char',
      'description': 'Modo de división',
    },
    {
      'name': 'animationType',
      'type': 'AnimationType',
      'default': 'fade',
      'description': 'Tipo de animación',
    },
    {
      'name': 'fontSize',
      'type': 'double',
      'default': '64',
      'description': 'Tamaño de fuente',
    },
    {
      'name': 'duration',
      'type': 'Duration',
      'default': '500ms',
      'description': 'Duración base',
    },
    {
      'name': 'curve',
      'type': 'Curve',
      'default': 'bounceIn',
      'description': 'Curva de animación',
    },
    {
      'name': 'autoPlay',
      'type': 'bool',
      'default': 'true',
      'description': 'Inicio automático',
    },
    {
      'name': 'blurFactor',
      'type': 'double',
      'default': '100',
      'description': 'Intensidad desenfoque',
    },
  ];

  Widget _buildAnimationTypesGrid(bool isNarrow) {
    final animations = [
      {'name': 'fade', 'description': 'Desvanecimiento suave'},
      {'name': 'blur', 'description': 'Desenfoque progresivo'},
      {'name': 'rotate', 'description': 'Rotación horizontal 3D'},
      {'name': 'rotateVertical', 'description': 'Rotación vertical 3D'},
      {'name': 'erode', 'description': 'Erosión progresiva'},
      {'name': 'dilate', 'description': 'Dilatación progresiva'},
      {'name': 'erodeBlur', 'description': 'Erosión + desenfoque'},
      {'name': 'dilateBlur', 'description': 'Dilatación + desenfoque'},
      {'name': 'decode', 'description': 'Efecto de decodificación'},
    ];

    return Container(
      width: double.infinity,
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
            'Tipos Disponibles',
            style: TextStyle(
              color: text.toColor(),
              fontSize: isNarrow ? 18 : 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: animations.map((anim) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: bg.toColor(),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: border.toColor().withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      anim['name']!,
                      style: TextStyle(
                        color: primary.toColor(),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      anim['description']!,
                      style: TextStyle(
                        color: textMuted.toColor(),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSplitTypesInfo(bool isNarrow) {
    final types = [
      {
        'name': 'SplitType.char',
        'description': 'Divide el texto en caracteres individuales. Ideal para animaciones detalladas.',
        'example': '"Hello" → ["H", "e", "l", "l", "o"]',
      },
      {
        'name': 'SplitType.word',
        'description': 'Divide el texto por palabras. Perfecto para títulos y frases.',
        'example': '"Hello World" → ["Hello", "World"]',
      },
      {
        'name': 'SplitType.line',
        'description': 'Divide el texto por líneas. Útil para párrafos y listas.',
        'example': '"Line 1\\nLine 2" → ["Line 1", "Line 2"]',
      },
    ];

    return Column(
      children: types.map((type) {
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
                type['name']!,
                style: TextStyle(
                  color: primary.toColor(),
                  fontSize: isNarrow ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 12),
              Text(
                type['description']!,
                style: TextStyle(
                  color: text.toColor(),
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: bg.toColor(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  type['example']!,
                  style: TextStyle(
                    color: textMuted.toColor(),
                    fontSize: 13,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBestPractices(bool isNarrow) {
    var donts = [
      'Múltiples animaciones blur simultáneas',
      'SplitType.char en textos muy largos',
      'Duraciones muy cortas (< 200ms)',
      'blurFactor muy alto (> 150)',
      'Animaciones sin necesidad (sobreanimación)',
    ];
    var dos = [
      'Usa fade para mejor performance',
      'Ajusta blurFactor según el dispositivo',
      'Considera SplitType.word para textos largos',
      'Curvas suaves (easeOut) para mejor UX',
      'Controla manualmente con GlobalKey cuando sea necesario',
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
