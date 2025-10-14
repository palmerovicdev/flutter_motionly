import 'package:flutter/material.dart';
import 'package:flutter_motionly/common/utils.dart';
import 'package:flutter_motionly/widget/loaders/circle_matrix_loader.dart';

import '../../common/utils.dart';

class CircleMatrixPage extends StatefulWidget {
  const CircleMatrixPage({super.key});

  @override
  State<CircleMatrixPage> createState() => _CircleMatrixPageState();
}

class _CircleMatrixPageState extends State<CircleMatrixPage> {
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
                    'CircleMatrixLoader',
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
                    'Loader animado con matriz de círculos que se expanden, contraen y desvanecen en diferentes direcciones. Perfecto para estados de carga elegantes y suaves.',
                    style: TextStyle(
                      color: textMuted.toColor(),
                      fontSize: isNarrow ? 16 : 20,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: isNarrow ? 32 : 48),

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: isNarrow ? 40 : 80,
                      children: [
                        CircleMatrixLoader(
                          numberOfSquares: isNarrow ? 4 : 5,
                          squareHeight: isNarrow ? 25 : 35,
                          duration: const Duration(milliseconds: 1500),
                          color: Colors.purpleAccent,
                          direction: TraverseDirection.LEFT_UP_RIGHT_BOTTOM,
                        ),
                        CircleMatrixLoader(
                          numberOfSquares: isNarrow ? 4 : 5,
                          squareHeight: isNarrow ? 25 : 35,
                          duration: const Duration(milliseconds: 1500),
                          color: Colors.pinkAccent,
                          direction: TraverseDirection.RIGHT_BOTTOM_LEFT_UP,
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
CircleMatrixLoader(
  numberOfSquares: 5,
  squareHeight: 40,
  duration: Duration(milliseconds: 1500),
  color: Colors.purple,
  direction: TraverseDirection.LEFT_UP_RIGHT_BOTTOM,
  curve: Curves.linear,
)''', isNarrow),

                  const SizedBox(height: 80),

                  buildSectionTitle('Ejemplos', isNarrow),
                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Loader Simple',
                    'Un loader básico con círculos que se desvanecen suavemente',
                    isNarrow,
                    Center(
                      child: CircleMatrixLoader(
                        numberOfSquares: isNarrow ? 3 : 4,
                        squareHeight: isNarrow ? 30 : 40,
                        duration: const Duration(milliseconds: 1500),
                        color: primary.toColor(),
                        direction: TraverseDirection.LEFT_UP_RIGHT_BOTTOM,
                      ),
                    ),
                    '''
CircleMatrixLoader(
  numberOfSquares: 4,
  squareHeight: 40,
  duration: Duration(milliseconds: 1500),
  color: Colors.blue,
  direction: TraverseDirection.LEFT_UP_RIGHT_BOTTOM,
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Efecto Diagonal Inverso',
                    'Animación con desvanecimiento desde la esquina inferior derecha',
                    isNarrow,
                    Center(
                      child: CircleMatrixLoader(
                        numberOfSquares: isNarrow ? 4 : 5,
                        squareHeight: isNarrow ? 25 : 35,
                        duration: const Duration(milliseconds: 1800),
                        color: secondary.toColor(),
                        direction: TraverseDirection.RIGHT_BOTTOM_LEFT_UP,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    '''
CircleMatrixLoader(
  numberOfSquares: 5,
  squareHeight: 35,
  duration: Duration(milliseconds: 1800),
  color: Colors.orange,
  direction: TraverseDirection.RIGHT_BOTTOM_LEFT_UP,
  curve: Curves.easeInOut,
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Efecto Vertical',
                    'Animación fluida que fluye de arriba hacia abajo',
                    isNarrow,
                    Center(
                      child: CircleMatrixLoader(
                        numberOfSquares: isNarrow ? 3 : 4,
                        squareHeight: isNarrow ? 30 : 40,
                        duration: const Duration(milliseconds: 1200),
                        color: success.toColor(),
                        direction: TraverseDirection.UP_BOTTOM,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    '''
CircleMatrixLoader(
  numberOfSquares: 4,
  squareHeight: 40,
  duration: Duration(milliseconds: 1200),
  color: Colors.green,
  direction: TraverseDirection.UP_BOTTOM,
  curve: Curves.easeInOut,
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Efecto Horizontal',
                    'Ola de círculos que fluye de izquierda a derecha',
                    isNarrow,
                    Center(
                      child: CircleMatrixLoader(
                        numberOfSquares: isNarrow ? 3 : 4,
                        squareHeight: isNarrow ? 30 : 40,
                        duration: const Duration(milliseconds: 1400),
                        color: info.toColor(),
                        direction: TraverseDirection.LEFT_RIGHT,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    '''
CircleMatrixLoader(
  numberOfSquares: 4,
  squareHeight: 40,
  duration: Duration(milliseconds: 1400),
  color: Colors.blue,
  direction: TraverseDirection.LEFT_RIGHT,
  curve: Curves.easeInOut,
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Efecto Rápido y Pequeño',
                    'Loader compacto con desvanecimiento rápido y elegante',
                    isNarrow,
                    Center(
                      child: CircleMatrixLoader(
                        numberOfSquares: 3,
                        squareHeight: isNarrow ? 25 : 30,
                        duration: const Duration(milliseconds: 800),
                        color: danger.toColor(),
                        direction: TraverseDirection.RIGHT_UP_LEFT_BOTTOM,
                        curve: Curves.bounceInOut,
                      ),
                    ),
                    '''
CircleMatrixLoader(
  numberOfSquares: 3,
  squareHeight: 30,
  duration: Duration(milliseconds: 800),
  color: Colors.red,
  direction: TraverseDirection.RIGHT_UP_LEFT_BOTTOM,
  curve: Curves.bounceInOut,
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Matriz Grande',
                    'Loader con más círculos para un efecto complejo y orgánico',
                    isNarrow,
                    Center(
                      child: CircleMatrixLoader(
                        numberOfSquares: isNarrow ? 5 : 6,
                        squareHeight: isNarrow ? 20 : 25,
                        duration: const Duration(milliseconds: 2000),
                        color: warning.toColor(),
                        direction: TraverseDirection.LEFT_BOTTOM_RIGHT_UP,
                        curve: Curves.linear,
                      ),
                    ),
                    '''
CircleMatrixLoader(
  numberOfSquares: 6,
  squareHeight: 25,
  duration: Duration(milliseconds: 2000),
  color: Colors.yellow,
  direction: TraverseDirection.LEFT_BOTTOM_RIGHT_UP,
  curve: Curves.linear,
)''',
                  ),

                  const SizedBox(height: 80),

                  buildSectionTitle('Propiedades', isNarrow),
                  const SizedBox(height: 24),
                  buildPropertiesTable(isNarrow, _properties),

                  const SizedBox(height: 80),

                  buildSectionTitle('Direcciones Disponibles', isNarrow),
                  const SizedBox(height: 24),
                  _buildDirectionsGrid(isNarrow),

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

  Widget _buildDirectionsGrid(bool isNarrow) {
    final directions = [
      {
        'name': 'BOTTOM_UP',
        'description': 'De abajo hacia arriba',
        'direction': TraverseDirection.BOTTOM_UP,
      },
      {
        'name': 'UP_BOTTOM',
        'description': 'De arriba hacia abajo',
        'direction': TraverseDirection.UP_BOTTOM,
      },
      {
        'name': 'LEFT_RIGHT',
        'description': 'De izquierda a derecha',
        'direction': TraverseDirection.LEFT_RIGHT,
      },
      {
        'name': 'RIGHT_LEFT',
        'description': 'De derecha a izquierda',
        'direction': TraverseDirection.RIGHT_LEFT,
      },
      {
        'name': 'LEFT_UP_RIGHT_BOTTOM',
        'description': 'Diagonal: Superior izquierda a inferior derecha',
        'direction': TraverseDirection.LEFT_UP_RIGHT_BOTTOM,
      },
      {
        'name': 'RIGHT_BOTTOM_LEFT_UP',
        'description': 'Diagonal: Inferior derecha a superior izquierda',
        'direction': TraverseDirection.RIGHT_BOTTOM_LEFT_UP,
      },
      {
        'name': 'LEFT_BOTTOM_RIGHT_UP',
        'description': 'Diagonal: Inferior izquierda a superior derecha',
        'direction': TraverseDirection.LEFT_BOTTOM_RIGHT_UP,
      },
      {
        'name': 'RIGHT_UP_LEFT_BOTTOM',
        'description': 'Diagonal: Superior derecha a inferior izquierda',
        'direction': TraverseDirection.RIGHT_UP_LEFT_BOTTOM,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isNarrow ? 1 : 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        mainAxisExtent: isNarrow ? 180 : 200,
      ),
      itemCount: directions.length,
      itemBuilder: (context, index) {
        final direction = directions[index];
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: bgLight.toColor().withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: border.toColor().withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleMatrixLoader(
                numberOfSquares: 3,
                squareHeight: 20,
                duration: const Duration(milliseconds: 1500),
                color: primary.toColor(),
                direction: direction['direction'] as TraverseDirection,
              ),
              const SizedBox(height: 16),
              Text(
                direction['name'] as String,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: text.toColor(),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                direction['description'] as String,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textMuted.toColor(),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBestPractices(bool isNarrow) {
    final dos = [
      'Usa numberOfSquares entre 3-6 para mejor rendimiento y claridad visual',
      'Aprovecha el efecto de opacidad: los círculos se desvanecen suavemente creando un efecto orgánico',
      'Experimenta con diferentes curvas. Curves.easeInOut complementa perfectamente el desvanecimiento',
      'Usa direcciones diagonales para efectos más dinámicos y fluidos',
      'Combina con fondos oscuros para resaltar el efecto de desvanecimiento',
    ];
    final donts = [
      'Evita matrices muy grandes (8+ círculos) ya que el efecto de desvanecimiento puede perder impacto',
      'No uses duraciones muy cortas (<600ms) con matrices grandes, el desvanecimiento necesita tiempo',
      'Evita colores muy claros en fondos claros, el efecto de opacidad no se verá bien',
      'No combines con animaciones muy rápidas, los círculos necesitan tiempo para desvanecerse',
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

final _features = [
  {
    'icon': Icons.bubble_chart,
    'title': 'Círculos Perfectos',
    'description': 'Formas circulares suaves con efecto de desvanecimiento elegante',
  },
  {
    'icon': Icons.opacity,
    'title': 'Desvanecimiento Fluido',
    'description': 'Animación de opacidad coordinada con el tamaño para un efecto orgánico',
  },
  {
    'icon': Icons.trending_up,
    'title': '8 Direcciones',
    'description': 'Múltiples direcciones de animación: vertical, horizontal y diagonal',
  },
  {
    'icon': Icons.palette,
    'title': 'Altamente Personalizable',
    'description': 'Colores, tamaños, velocidades y curvas completamente configurables',
  },
];

final _properties = [
  {
    'name': 'numberOfSquares',
    'type': 'int',
    'default': '3',
    'description': 'Número de círculos en cada fila y columna de la matriz',
  },
  {
    'name': 'squareHeight',
    'type': 'double',
    'default': '40',
    'description': 'Altura y ancho de cada círculo en la matriz',
  },
  {
    'name': 'duration',
    'type': 'Duration',
    'default': '1500ms',
    'description': 'Duración de un ciclo completo de la animación con desvanecimiento',
  },
  {
    'name': 'color',
    'type': 'Color',
    'default': 'Colors.blue',
    'description': 'Color de los círculos (la opacidad se anima automáticamente)',
  },
  {
    'name': 'direction',
    'type': 'TraverseDirection',
    'default': 'LEFT_UP_RIGHT_BOTTOM',
    'description': 'Dirección en la que fluye la ola de desvanecimiento',
  },
  {
    'name': 'curve',
    'type': 'Curve',
    'default': 'Curves.linear',
    'description': 'Curva de animación para las transiciones de escala y opacidad',
  },
];
