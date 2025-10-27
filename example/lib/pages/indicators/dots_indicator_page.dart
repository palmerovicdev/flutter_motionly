import 'package:flutter/material.dart';
import 'package:flutter_motionly/widget/indicator/dots_indicator.dart';

import '../../common/utils.dart';

class DotsIndicatorPage extends StatefulWidget {
  const DotsIndicatorPage({super.key});

  @override
  State<DotsIndicatorPage> createState() => _DotsIndicatorPageState();
}

class _DotsIndicatorPageState extends State<DotsIndicatorPage> {
  final DotsIndicatorController _controller = DotsIndicatorController(0);
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                    'DotsIndicator',
                    style: TextStyle(
                      color: text.toColor(),
                      fontSize: isNarrow ? 32 : 72,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                      letterSpacing: -1.5,
                    ),
                  ),
                  SizedBox(height: isNarrow ? 16 : 24),
                  Text(
                    'Indicador de puntos animado con transiciones suaves. Ideal para paginación, onboarding, carruseles y flujos de pasos con control externo opcional.',
                    style: TextStyle(
                      color: textMuted.toColor(),
                      fontSize: isNarrow ? 16 : 20,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: isNarrow ? 32 : 48),
                  Center(
                    child: DotsIndicator(
                      numberOfDots: 5,
                      activeDotColor: primary.toColor(),
                      inactiveDotColor: textMuted.toColor(),
                      backgroundColor: bgLight.toColor(),
                      backgroundRadius: 24,
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.elasticOut,
                      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      activeDotSize: const Size(48, 14),
                      inactiveDotSize: const Size(14, 14),
                      separation: 6,
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
DotsIndicator(
  numberOfDots: 5,
  activeDotColor: Colors.blue,
  inactiveDotColor: Colors.grey,
  onChangeActiveDot: (index) {
    print('Dot \$index seleccionado');
  },
)''', isNarrow),
                  const SizedBox(height: 80),
                  buildSectionTitle('Ejemplos', isNarrow),
                  const SizedBox(height: 32),
                  buildExampleCard(
                    'Básico',
                    'Indicador simple con dots clickeables',
                    isNarrow,
                    Center(
                      child: DotsIndicator(
                        numberOfDots: 4,
                        activeDotColor: primary.toColor(),
                        inactiveDotColor: textMuted.toColor().withValues(alpha: 0.3),
                        activeDotSize: const Size(36, 12),
                        inactiveDotSize: const Size(12, 12),
                      ),
                    ),
                    '''
DotsIndicator(
  numberOfDots: 4,
  activeDotColor: Colors.blue,
  inactiveDotColor: Colors.grey,
  activeDotSize: const Size(36, 12),
  inactiveDotSize: const Size(12, 12),
)''',
                  ),
                  const SizedBox(height: 32),
                  buildExampleCard(
                    'Con Fondo Contenedor',
                    'Dots dentro de un contenedor con color de fondo',
                    isNarrow,
                    Center(
                      child: DotsIndicator(
                        numberOfDots: 5,
                        activeDotColor: info.toColor(),
                        inactiveDotColor: textMuted.toColor().withValues(alpha: 0.3),
                        backgroundColor: bg.toColor(),
                        backgroundRadius: 20,
                        activeDotSize: const Size(36, 12),
                        inactiveDotSize: const Size(12, 12),
                        margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                      ),
                    ),
                    '''
DotsIndicator(
  numberOfDots: 5,
  activeDotColor: Colors.cyan,
  backgroundColor: Colors.black12,
  backgroundRadius: 20,
  activeDotSize: const Size(36, 12),
  inactiveDotSize: const Size(12, 12),
  margin: EdgeInsets.symmetric(
    vertical: 14,
    horizontal: 10,
  ),
)''',
                  ),
                  const SizedBox(height: 32),
                  buildExampleCard(
                    'Con Botones de Navegación',
                    'Incluye botones prev/next para navegación manual',
                    isNarrow,
                    Center(
                      child: DotsIndicator(
                        numberOfDots: 6,
                        activeDotColor: success.toColor(),
                        inactiveDotColor: textMuted.toColor().withValues(alpha: 0.3),
                        backgroundColor: bg.toColor(),
                        showButtons: true,
                        activeDotSize: const Size(36, 12),
                        inactiveDotSize: const Size(12, 12),
                        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      ),
                    ),
                    '''
DotsIndicator(
  numberOfDots: 6,
  activeDotColor: Colors.green,
  showButtons: true,
  activeDotSize: const Size(36, 12),
  inactiveDotSize: const Size(12, 12),
  backgroundColor: Colors.black12,
)''',
                  ),
                  const SizedBox(height: 32),
                  buildExampleCard(
                    'Botones Personalizados',
                    'Botones de navegación con iconos personalizados',
                    isNarrow,
                    Center(
                      child: DotsIndicator(
                        numberOfDots: 5,
                        activeDotColor: secondary.toColor(),
                        inactiveDotColor: textMuted.toColor().withValues(alpha: 0.3),
                        backgroundColor: bg.toColor(),
                        showButtons: true,
                        activeDotSize: const Size(36, 12),
                        inactiveDotSize: const Size(12, 12),
                        backButton: Icon(
                          Icons.arrow_back_ios,
                          color: secondary.toColor(),
                          size: 16,
                        ),
                        nextButton: Icon(
                          Icons.arrow_forward_ios,
                          color: secondary.toColor(),
                          size: 16,
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                      ),
                    ),
                    '''
DotsIndicator(
  numberOfDots: 5,
  activeDotColor: Colors.purple,
  showButtons: true,
  activeDotSize: const Size(36, 12),
  inactiveDotSize: const Size(12, 12),
  backButton: Icon(
    Icons.arrow_back_ios,
    color: Colors.purple,
    size: 16,
  ),
  nextButton: Icon(
    Icons.arrow_forward_ios,
    color: Colors.purple,
    size: 16,
  ),
)''',
                  ),
                  const SizedBox(height: 32),
                  buildExampleCard(
                    'Tamaños Personalizados',
                    'Dots con tamaños y separación personalizada',
                    isNarrow,
                    Center(
                      child: DotsIndicator(
                        numberOfDots: 4,
                        height: 48,
                        activeDotColor: danger.toColor(),
                        inactiveDotColor: textMuted.toColor().withValues(alpha: 0.3),
                        activeDotSize: const Size(18, 18),
                        inactiveDotSize: const Size(12, 12),
                        curve: Curves.easeInOut,
                        separation: 4,
                      ),
                    ),
                    '''
DotsIndicator(
  numberOfDots: 4,
  activeDotColor: Colors.red,
  activeDotSize: Size(40, 12),
  inactiveDotSize: Size(12, 12),
  separation: 8,
)''',
                  ),
                  const SizedBox(height: 32),
                  buildExampleCard(
                    'Animación Personalizada',
                    'Curva y duración de animación customizada',
                    isNarrow,
                    Center(
                      child: DotsIndicator(
                        numberOfDots: 5,
                        activeDotColor: warning.toColor(),
                        inactiveDotColor: textMuted.toColor().withValues(alpha: 0.3),
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOutCubic,
                        backgroundColor: bg.toColor(),
                        margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                      ),
                    ),
                    '''
DotsIndicator(
  numberOfDots: 5,
  activeDotColor: Colors.orange,
  duration: Duration(milliseconds: 600),
  curve: Curves.easeInOutCubic,
)''',
                  ),
                  const SizedBox(height: 32),
                  buildExampleCard(
                    'Control Externo con Botones',
                    'Uso del DotsIndicatorController para control programático',
                    isNarrow,
                    Column(
                      children: [
                        DotsIndicator(
                          numberOfDots: 4,
                          controller: _controller,
                          activeDotColor: primary.toColor(),
                          inactiveDotColor: textMuted.toColor().withValues(alpha: 0.3),
                          backgroundColor: bg.toColor(),
                          margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: List.generate(
                              4,
                              (index) => ElevatedButton(
                                onPressed: () => _controller.jumpTo(index),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _currentPage == index
                                      ? primary.toColor()
                                      : bg.toColor(),
                                  foregroundColor: text.toColor(),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                ),
                                child: Text('Página ${index + 1}'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    '''
final controller = DotsIndicatorController(0);

DotsIndicator(
  numberOfDots: 4,
  controller: controller,
  activeDotColor: Colors.blue,
)

// Control programático
ElevatedButton(
  onPressed: () => controller.jumpTo(2),
  child: Text('Ir a página 3'),
)

// No olvides dispose
@override
void dispose() {
  controller.dispose();
  super.dispose();
}''',
                  ),
                  const SizedBox(height: 32),
                  buildExampleCard(
                    'Estilo Moderno',
                    'Combinación de colores y estilos para look moderno',
                    isNarrow,
                    Center(
                      child: DotsIndicator(
                        numberOfDots: 5,
                        activeDotColor: primary.toColor(),
                        inactiveDotColor: primary.toColor().withValues(alpha: 0.2),
                        backgroundColor: primary.toColor().withValues(alpha: 0.1),
                        backgroundRadius: 30,
                        activeDotSize: const Size(36, 10),
                        inactiveDotSize: const Size(10, 10),
                        separation: 5,
                        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutBack,
                      ),
                    ),
                    '''
DotsIndicator(
  numberOfDots: 5,
  activeDotColor: Colors.blue,
  inactiveDotColor: Colors.blue.withOpacity(0.2),
  backgroundColor: Colors.blue.withOpacity(0.1),
  backgroundRadius: 30,
  activeDotSize: Size(36, 10),
  inactiveDotSize: Size(10, 10),
  separation: 5,
  duration: Duration(milliseconds: 500),
  curve: Curves.easeInOutBack,
)''',
                  ),
                  const SizedBox(height: 80),
                  buildSectionTitle('Propiedades', isNarrow),
                  const SizedBox(height: 24),
                  buildPropertiesTable(isNarrow, _properties),
                  const SizedBox(height: 80),
                  buildSectionTitle('Mejores Prácticas', isNarrow),
                  const SizedBox(height: 24),
                  if (isNarrow)
                    Column(
                      children: [
                        buildPracticeCard('✓ Hacer', dos, success.toColor(), isNarrow),
                        const SizedBox(height: 20),
                        buildPracticeCard('✗ Evitar', donts, danger.toColor(), isNarrow),
                      ],
                    )
                  else
                    Row(
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
                    ),
                  const SizedBox(height: 80),
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
    'icon': Icons.touch_app,
    'title': 'Interactivo',
    'description': 'Tap directo en cualquier dot para saltar a ese índice',
  },
  {
    'icon': Icons.control_camera,
    'title': 'Control Externo',
    'description': 'Sincroniza con controlador para paginación manual',
  },
  {
    'icon': Icons.animation,
    'title': 'Animación Suave',
    'description': 'Transiciones fluidas con curvas personalizables',
  },
  {
    'icon': Icons.palette,
    'title': 'Personalizable',
    'description': 'Controla colores, tamaños, separación y estilo',
  },
];

final _properties = [
  {
    'name': 'numberOfDots',
    'type': 'int',
    'default': '4',
    'description': 'Número total de puntos a mostrar',
  },
  {
    'name': 'initialActiveDot',
    'type': 'int',
    'default': '0',
    'description': 'Índice del dot activo al inicio (base 0)',
  },
  {
    'name': 'controller',
    'type': 'DotsIndicatorController?',
    'default': 'null',
    'description': 'Controlador para sincronización externa',
  },
  {
    'name': 'height',
    'type': 'double?',
    'default': 'auto',
    'description': 'Altura del widget (calculada automáticamente)',
  },
  {
    'name': 'activeDotColor',
    'type': 'Color?',
    'default': 'primaryColor',
    'description': 'Color del dot activo',
  },
  {
    'name': 'inactiveDotColor',
    'type': 'Color?',
    'default': 'Colors.grey',
    'description': 'Color de los dots inactivos',
  },
  {
    'name': 'backgroundColor',
    'type': 'Color?',
    'default': 'transparent',
    'description': 'Color de fondo del contenedor',
  },
  {
    'name': 'activeDotSize',
    'type': 'Size?',
    'default': 'Size(24, 8)',
    'description': 'Tamaño del dot activo (estilo pill)',
  },
  {
    'name': 'inactiveDotSize',
    'type': 'Size?',
    'default': 'Size(8, 8)',
    'description': 'Tamaño de los dots inactivos',
  },
  {
    'name': 'separation',
    'type': 'double',
    'default': '4.0',
    'description': 'Espacio horizontal entre dots',
  },
  {
    'name': 'duration',
    'type': 'Duration?',
    'default': '300ms',
    'description': 'Duración de la animación de transición',
  },
  {
    'name': 'curve',
    'type': 'Curve?',
    'default': 'Curves.elasticOut',
    'description': 'Curva de animación para las transiciones',
  },
  {
    'name': 'showButtons',
    'type': 'bool',
    'default': 'false',
    'description': 'Muestra botones de navegación prev/next',
  },
  {
    'name': 'backButton',
    'type': 'Widget?',
    'default': 'chevron_left',
    'description': 'Widget personalizado para botón anterior',
  },
  {
    'name': 'nextButton',
    'type': 'Widget?',
    'default': 'chevron_right',
    'description': 'Widget personalizado para botón siguiente',
  },
  {
    'name': 'margin',
    'type': 'EdgeInsetsGeometry?',
    'default': 'symmetric(v:12,h:4)',
    'description': 'Padding interno del contenedor',
  },
  {
    'name': 'backgroundRadius',
    'type': 'double?',
    'default': '32.0',
    'description': 'Radio del borde del contenedor de fondo',
  },
  {
    'name': 'onChangeActiveDot',
    'type': 'ValueChanged<int>?',
    'default': 'null',
    'description': 'Callback cuando cambia el dot activo',
  },
];

final dos = [
  'Mantén numberOfDots entre 3-7 para no saturar la UI',
  'Usa contraste alto entre activeDotColor e inactiveDotColor',
  'Usa DotsIndicatorController para sincronizar con PageView',
  'Configura showButtons para interfaces desktop/web',
  'Llama a dispose() del controlador cuando ya no lo necesites',
];

final donts = [
  'Evita más de 10 dots (considera otro tipo de indicador)',
  'No uses tamaños muy pequeños (<6px) dificulta la interacción',
  'Evita animaciones muy lentas (>800ms) frustran al usuario',
  'No olvides el callback onChangeActiveDot si necesitas reaccionar',
];

