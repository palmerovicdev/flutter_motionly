import 'package:flutter/material.dart';
import 'package:flutter_motionly/widget/button/animated_state_button.dart';

import '../../common/utils.dart';

class AnimatedStateButtonDocPage extends StatefulWidget {
  const AnimatedStateButtonDocPage({super.key});

  @override
  State<AnimatedStateButtonDocPage> createState() => _AnimatedStateButtonDocPageState();
}

class _AnimatedStateButtonDocPageState extends State<AnimatedStateButtonDocPage> {
  late AnimatedStateButtonController _controller1;
  late AnimatedStateButtonController _controller2;
  late AnimatedStateButtonController _controller3;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimatedStateButtonController(
      states: {
        'success': ButtonState.success(),
        'error': ButtonState.error(),
      },
    );

    _controller2 = AnimatedStateButtonController(
      states: {
        'success': ButtonState.success(color: success.toColor()),
        'error': ButtonState.error(color: danger.toColor()),
      },
    );

    _controller3 = AnimatedStateButtonController(
      states: {
        'success': ButtonState.success(),
        'error': ButtonState.error(),
        'warning': ButtonState(
          id: 'warning',
          color: warning.toColor(),
          child: const Icon(Icons.warning, color: Colors.white, size: 28),
        ),
      },
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
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
                    'AnimatedStateButton',
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
                    'Botón con estados personalizables y transiciones suaves. Perfecto para operaciones asíncronas con feedback visual.',
                    style: TextStyle(
                      color: textMuted.toColor(),
                      fontSize: isNarrow ? 16 : 20,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: isNarrow ? 32 : 48),

                  Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 280),
                      child: AnimatedStateButton(
                        controller: _controller1,
                        initChild: const Text(
                          'Enviar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        initColor: primary.toColor(),
                        height: 56,
                        compactSize: 56,
                        borderRadius: 12,
                        onPressed: () async {
                          await _controller1.run(() async {
                            await Future.delayed(const Duration(seconds: 2));
                            return 'success';
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
// 1. Crea el controlador
final controller = AnimatedStateButtonController(
  states: {
    'success': ButtonState.success(),
    'error': ButtonState.error(),
  },
);

// 2. Usa el botón
AnimatedStateButton(
  controller: controller,
  initChild: Text('Enviar'),
  onPressed: () async {
    await controller.run(() async {
      await miOperacion();
      return 'success'; // o 'error'
    });
  },
)

// 3. Limpia el controlador
@override
void dispose() {
  controller.dispose();
  super.dispose();
}''', isNarrow),

                  const SizedBox(height: 80),

                  buildSectionTitle('Ejemplos', isNarrow),
                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Operación Asíncrona Básica',
                    'Muestra loading, success o error automáticamente',
                    isNarrow,
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 280),
                        child: AnimatedStateButton(
                          controller: _controller2,
                          initChild: const Text(
                            'Guardar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          initColor: info.toColor(),
                          height: 52,
                          compactSize: 52,
                          borderRadius: 12,
                          onPressed: () async {
                            await _controller2.run(() async {
                              await Future.delayed(const Duration(seconds: 2));

                              return DateTime.now().millisecond % 10 > 3 ? 'success' : 'error';
                            });
                          },
                        ),
                      ),
                    ),
                    '''
AnimatedStateButton(
  controller: controller,
  initChild: Text('Guardar'),
  initColor: Colors.blue,
  onPressed: () async {
    await controller.run(() async {
      await saveData();
      return 'success';
    });
  },
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Estados Personalizados',
                    'Crea tus propios estados con colores e iconos custom',
                    isNarrow,
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 280),
                        child: AnimatedStateButton(
                          controller: _controller3,
                          initChild: const Text(
                            'Verificar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          initColor: secondary.toColor(),
                          height: 52,
                          compactSize: 52,
                          borderRadius: 12,
                          onPressed: () async {
                            await _controller3.run(() async {
                              await Future.delayed(
                                const Duration(milliseconds: 1500),
                              );
                              final random = DateTime.now().millisecond % 3;
                              return random == 0
                                  ? 'success'
                                  : random == 1
                                  ? 'error'
                                  : 'warning';
                            });
                          },
                        ),
                      ),
                    ),
                    '''
final controller = AnimatedStateButtonController(
  states: {
    'success': ButtonState.success(),
    'error': ButtonState.error(),
    'warning': ButtonState(
      id: 'warning',
      color: Colors.orange,
      child: Icon(Icons.warning),
    ),
  },
);

AnimatedStateButton(
  controller: controller,
  initChild: Text('Verificar'),
  onPressed: () async {
    await controller.run(() async {
      final result = await checkStatus();
      return result; // 'success', 'error', o 'warning'
    });
  },
)''',
                  ),

                  const SizedBox(height: 32),

                  buildExampleCard(
                    'Control Manual de Estados',
                    'Cambia estados manualmente sin operaciones asíncronas',
                    isNarrow,
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          ElevatedButton(
                            onPressed: () => _controller1.init(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: bgLight.toColor(),
                              foregroundColor: text.toColor(),
                            ),
                            child: const Text('Init'),
                          ),
                          ElevatedButton(
                            onPressed: () => _controller1.loading(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: info.toColor(),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Loading'),
                          ),
                          ElevatedButton(
                            onPressed: () => _controller1.changeState('success'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: success.toColor(),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Success'),
                          ),
                          ElevatedButton(
                            onPressed: () => _controller1.changeState('error'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: danger.toColor(),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Error'),
                          ),
                        ],
                      ),
                    ),
                    '''
// Cambiar estados manualmente
controller.init();              // Estado inicial
controller.loading();           // Estado de carga
controller.changeState('success'); // Estado custom
controller.changeState('error');   // Otro estado''',
                  ),

                  const SizedBox(height: 80),

                  buildSectionTitle('Propiedades del Botón', isNarrow),
                  const SizedBox(height: 24),
                  buildPropertiesTable(isNarrow, properties),

                  const SizedBox(height: 80),

                  buildSectionTitle('API del Controlador', isNarrow),
                  const SizedBox(height: 24),
                  _buildControllerAPI(isNarrow),

                  const SizedBox(height: 80),

                  buildSectionTitle('Estados Predefinidos', isNarrow),
                  const SizedBox(height: 24),
                  _buildButtonStatesInfo(isNarrow),

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

  final properties = [
    {
      'name': 'controller',
      'type': 'Controller',
      'default': '-',
      'description': 'Controlador de estados (requerido)',
    },
    {
      'name': 'initChild',
      'type': 'Widget?',
      'default': 'Text("Enviar")',
      'description': 'Widget en estado inicial',
    },
    {
      'name': 'initColor',
      'type': 'Color',
      'default': 'Colors.black',
      'description': 'Color en estado inicial',
    },
    {
      'name': 'onPressed',
      'type': 'Future Function()?',
      'default': 'null',
      'description': 'Acción al presionar',
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
      'description': 'Ancho (null = full width)',
    },
    {
      'name': 'borderRadius',
      'type': 'double',
      'default': '8.0',
      'description': 'Radio de esquinas',
    },
    {
      'name': 'compactSize',
      'type': 'double',
      'default': '48.0',
      'description': 'Tamaño en estado compacto',
    },
    {
      'name': 'animationDuration',
      'type': 'Duration',
      'default': '400ms',
      'description': 'Duración de animación',
    },
    {
      'name': 'enabled',
      'type': 'bool',
      'default': 'true',
      'description': 'Si el botón está habilitado',
    },
  ];

  final features = [
    {
      'icon': Icons.auto_awesome,
      'title': 'Estados Personalizables',
      'description': 'Crea tus propios estados con colores e iconos',
    },
    {
      'icon': Icons.sync,
      'title': 'Manejo Automático',
      'description': 'Gestiona loading, success y error automáticamente',
    },
    {
      'icon': Icons.transform,
      'title': 'Transiciones Suaves',
      'description': 'Animaciones fluidas entre tamaños y estados',
    },
    {
      'icon': Icons.code,
      'title': 'API Intuitiva',
      'description': 'Fácil de usar con async/await',
    },
  ];

  Widget _buildControllerAPI(bool isNarrow) {
    final methods = [
      {
        'name': 'run(task)',
        'description': 'Ejecuta una tarea asíncrona con manejo automático de estados. La tarea debe retornar el ID del estado final.',
      },
      {
        'name': 'init()',
        'description': 'Cambia manualmente al estado inicial (botón expandido).',
      },
      {
        'name': 'loading()',
        'description': 'Cambia manualmente al estado de carga.',
      },
      {
        'name': 'changeState(id)',
        'description': 'Cambia manualmente a un estado personalizado por su ID.',
      },
      {
        'name': 'isInit',
        'description': 'Getter que retorna true si está en estado inicial.',
      },
      {
        'name': 'isLoading',
        'description': 'Getter que retorna true si está en estado de carga.',
      },
    ];

    return Column(
      children: methods.map((method) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(isNarrow ? 18 : 20),
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
                method['name']!,
                style: TextStyle(
                  color: primary.toColor(),
                  fontSize: isNarrow ? 14 : 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                method['description']!,
                style: TextStyle(
                  color: textMuted.toColor(),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildButtonStatesInfo(bool isNarrow) {
    final states = [
      {
        'name': 'ButtonState.loading()',
        'description': 'Estado de carga con CircularProgressIndicator. Color por defecto: azul claro.',
      },
      {
        'name': 'ButtonState.success()',
        'description': 'Estado de éxito con icono de check. Color por defecto: verde.',
      },
      {
        'name': 'ButtonState.error()',
        'description': 'Estado de error con icono de error. Color por defecto: rojo.',
      },
      {
        'name': 'ButtonState(id, color, child)',
        'description': 'Crea un estado personalizado con ID único, color y widget custom.',
      },
    ];

    return Column(
      children: states.map((state) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(isNarrow ? 18 : 20),
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
                state['name']!,
                style: TextStyle(
                  color: primary.toColor(),
                  fontSize: isNarrow ? 14 : 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                state['description']!,
                style: TextStyle(
                  color: textMuted.toColor(),
                  fontSize: 14,
                  height: 1.5,
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
      'Siempre limpia el controlador en dispose()',
      'Define todos los estados posibles al crear el controlador',
      'Usa run() para operaciones asíncronas automáticas',
      'Mantén las animaciones entre 300-500ms',
      'Proporciona feedback claro en cada estado',
    ];
    var donts = [
      'Olvidar dispose() del controlador',
      'Cambiar estados mientras está en loading',
      'Usar estados no definidos en el controlador',
      'Animaciones muy largas (> 600ms)',
      'Estados sin widgets o colores diferenciados',
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
