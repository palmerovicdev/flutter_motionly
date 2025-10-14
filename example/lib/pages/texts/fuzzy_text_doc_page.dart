import 'package:flutter/material.dart';
import 'package:flutter_motionly/widget/text/fuzzy_text.dart';

import '../../common/utils.dart';

class FuzzyTextDocPage extends StatelessWidget {
  FuzzyTextDocPage({super.key});

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
                    'FuzzyText',
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
                    'Efectos de texto difusos con distorsión continua. Perfecto para crear efectos glitch y vibraciones.',
                    style: TextStyle(
                      color: textMuted.toColor(),
                      fontSize: isNarrow ? 16 : 20,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: isNarrow ? 32 : 48),

                  Center(
                    child: FuzzyText.glitch(
                      'GLITCH',
                      style: TextStyle(
                        fontSize: isNarrow ? 36 : 56,
                        fontWeight: FontWeight.w900,
                        color: text.toColor(),
                      ),
                      amplitude: 12,
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
// Efecto Glitch
FuzzyText.glitch(
  'ERROR 404',
  style: TextStyle(
    fontSize: 32,
    color: Colors.white,
  ),
  amplitude: 12.0,
)

// Efecto Height
FuzzyText.height(
  'Loading...',
  style: TextStyle(
    fontSize: 24,
    color: Colors.blue,
  ),
  amplitude: 8.0,
)''',
                    isNarrow,
                  ),

                  const SizedBox(height: 80),

                  buildSectionTitle('Ejemplos', isNarrow),
                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Efecto Glitch',
                    'Desplazamiento horizontal de capas de color para simular fallos digitales',
                    isNarrow,
                    Center(
                      child: FuzzyText.glitch(
                        'SYSTEM ERROR',
                        style: TextStyle(
                          fontSize: isNarrow ? 24 : 32,
                          fontWeight: FontWeight.w800,
                          color: text.toColor(),
                        ),
                        amplitude: 10,
                      ),
                    ),
                    '''
FuzzyText.glitch(
  'SYSTEM ERROR',
  style: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  ),
  amplitude: 10,
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Efecto Height',
                    'Fluctuación sutil de escala, ideal para indicadores de carga',
                    isNarrow,
                    Center(
                      child: FuzzyText.height(
                        'Processing...',
                        style: TextStyle(
                          fontSize: isNarrow ? 20 : 28,
                          fontWeight: FontWeight.w600,
                          color: primary.toColor(),
                        ),
                        amplitude: 8,
                      ),
                    ),
                    '''
FuzzyText.height(
  'Processing...',
  style: TextStyle(
    fontSize: 28,
    color: Colors.blue,
  ),
  amplitude: 8,
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Glitch de Alta Intensidad',
                    'Aumenta la amplitud para efectos más dramáticos',
                    isNarrow,
                    Center(
                      child: FuzzyText.glitch(
                        'CORRUPTED',
                        style: TextStyle(
                          fontSize: isNarrow ? 22 : 30,
                          fontWeight: FontWeight.w900,
                          color: danger.toColor(),
                          letterSpacing: 2,
                        ),
                        amplitude: 18,
                      ),
                    ),
                    '''
FuzzyText.glitch(
  'CORRUPTED',
  style: TextStyle(
    fontSize: 30,
    color: Colors.red,
    letterSpacing: 2,
  ),
  amplitude: 18, // Mayor intensidad
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Fluctuación Sutil',
                    'Reduce la amplitud para efectos discretos',
                    isNarrow,
                    Center(
                      child: FuzzyText.height(
                        'Searching...',
                        style: TextStyle(
                          fontSize: isNarrow ? 18 : 24,
                          fontWeight: FontWeight.w500,
                          color: info.toColor(),
                        ),
                        amplitude: 4,
                      ),
                    ),
                    '''
FuzzyText.height(
  'Searching...',
  style: TextStyle(
    fontSize: 24,
    color: Colors.cyan,
  ),
  amplitude: 4, // Efecto sutil
)''',
                  ),

                  const SizedBox(height: 80),

                  buildSectionTitle('Comparación de Modos', isNarrow),
                  const SizedBox(height: 24),
                  _buildModesComparison(isNarrow),

                  const SizedBox(height: 80),

                  buildSectionTitle('Propiedades', isNarrow),
                  const SizedBox(height: 24),
                  buildPropertiesTable(isNarrow, properties),

                  const SizedBox(height: 80),

                  buildSectionTitle('Casos de Uso', isNarrow),
                  const SizedBox(height: 24),
                  _buildUseCases(isNarrow),

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
      'icon': Icons.videogame_asset,
      'title': 'Efecto Glitch',
      'description': 'Simulación de fallos digitales realista',
    },
    {
      'icon': Icons.graphic_eq,
      'title': 'Fluctuación',
      'description': 'Vibración y escalado dinámico',
    },
    {
      'icon': Icons.loop,
      'title': 'Animación Continua',
      'description': 'Bucle infinito a 60fps',
    },
    {
      'icon': Icons.tune,
      'title': 'Amplitud Ajustable',
      'description': 'Control preciso de la intensidad',
    },
  ];

  final properties = [
    {
      'name': 'text',
      'type': 'String',
      'default': '-',
      'description': 'Texto a mostrar',
    },
    {
      'name': 'style',
      'type': 'TextStyle',
      'default': '-',
      'description': 'Estilo del texto',
    },
    {
      'name': 'mode',
      'type': 'FuzzyMode',
      'default': 'glitch/height',
      'description': 'Tipo de efecto',
    },
    {
      'name': 'amplitude',
      'type': 'double',
      'default': '12',
      'description': 'Intensidad del efecto',
    },
    {
      'name': 'speed',
      'type': 'double',
      'default': '1.6',
      'description': 'Velocidad (reservado)',
    },
    {
      'name': 'debugBox',
      'type': 'bool',
      'default': 'false',
      'description': 'Muestra borde de debug',
    },
  ];

  Widget _buildModesComparison(bool isNarrow) {
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
        children: [
          _buildModeRow(
            'FuzzyMode.glitch',
            'Desplaza capas de color (rojo/azul) horizontalmente',
            'Efectos dramáticos, errores digitales, alertas',
            Icons.error_outline,
            danger.toColor(),
            isNarrow,
          ),
          const SizedBox(height: 20),
          _buildModeRow(
            'FuzzyMode.height',
            'Escala el texto aleatoriamente',
            'Indicadores de carga, efectos sutiles, animaciones de fondo',
            Icons.height,
            info.toColor(),
            isNarrow,
          ),
        ],
      ),
    );
  }

  Widget _buildModeRow(
    String name,
    String description,
    String useCase,
    IconData icon,
    Color color,
    bool isNarrow,
  ) {
    return Container(
      padding: EdgeInsets.all(isNarrow ? 16 : 20),
      decoration: BoxDecoration(
        color: bg.toColor(),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    color: primary.toColor(),
                    fontSize: isNarrow ? 14 : 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              color: text.toColor(),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: bgLight.toColor().withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: warning.toColor(),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    useCase,
                    style: TextStyle(
                      color: textMuted.toColor(),
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUseCases(bool isNarrow) {
    final useCases = [
      {
        'title': 'Páginas de Error',
        'description': 'Usa glitch para errores 404, 500 o mensajes de sistema no disponible',
        'icon': Icons.error,
      },
      {
        'title': 'Indicadores de Carga',
        'description': 'Height para "Loading...", "Processing..." con efecto sutil',
        'icon': Icons.hourglass_empty,
      },
      {
        'title': 'Títulos Cyberpunk',
        'description': 'Glitch de alta intensidad para estética futurista o retro',
        'icon': Icons.computer,
      },
      {
        'title': 'Estados de Alerta',
        'description': 'Efectos glitch para warnings críticos o alertas de seguridad',
        'icon': Icons.warning,
      },
    ];

    return Column(
      children: useCases.map((useCase) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(isNarrow ? 18 : 22),
          decoration: BoxDecoration(
            color: bgLight.toColor().withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: border.toColor().withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primary.toColor().withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  useCase['icon'] as IconData,
                  color: primary.toColor(),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      useCase['title'] as String,
                      style: TextStyle(
                        color: text.toColor(),
                        fontSize: isNarrow ? 15 : 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      useCase['description'] as String,
                      style: TextStyle(
                        color: textMuted.toColor(),
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
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
      'Usa height para efectos sutiles y continuos',
      'Glitch para momentos de impacto o error',
      'Amplitud 6-12 para efectos moderados',
      'Combina con colores apropiados al contexto',
      'Úsalo con moderación (no abuses del efecto)',
    ];
    var donts = [
      'Múltiples instancias en la misma vista',
      'Amplitudes muy altas (> 20) sin razón',
      'Uso en textos largos o párrafos',
      'Efectos glitch en toda la interfaz',
      'Combinación con otras animaciones pesadas',
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
