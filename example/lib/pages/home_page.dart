import 'package:example/pages/buttons/animated_state_button_doc_page.dart';
import 'package:example/pages/buttons/focus_button_doc_page.dart';
import 'package:example/pages/buttons/rect_reveal_button_doc_page.dart';
import 'package:example/pages/buttons/ripple_reveal_button_doc_page.dart';
import 'package:example/pages/indicators/indicators_page.dart';
import 'package:example/pages/loaders/square_matrix_page.dart';
import 'package:example/pages/loaders/wave_stick_page.dart';
import 'package:example/pages/texts/animated_text_doc_page.dart';
import 'package:example/pages/texts/fuzzy_text_doc_page.dart';
import 'package:example/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_motionly/widget/button/focus_button.dart';
import 'package:flutter_motionly/widget/button/ripple_reveal_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDark.toColor(),
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: bgDark.toColor(),
        centerTitle: true,
        leadingWidth: MediaQuery.sizeOf(context).width,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: isDesktop(context) ? 24 : 12,
            children: [
              if (isDesktop(context))
                Text(
                  'Flutter Motionly',
                  style: TextStyle(
                    color: text.toColor(),
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              if (!isDesktop(context))
                Icon(
                  Icons.animation,
                  color: text.toColor(),
                  size: 24,
                ),
              if (!isDesktop(context))
                PopupMenuButton(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: border.toColor(),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  borderRadius: BorderRadius.circular(12),
                  itemBuilder: (context) => [
                    ...components.map(
                      (b) => PopupMenuItem<String>(
                        mouseCursor: SystemMouseCursors.click,
                        value: b.title,
                        child: Text(
                          b.title,
                          style: TextStyle(color: text.toColor()),
                        ),
                      ),
                    ),
                  ],
                  color: bgDark.toColor(),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: text.toColor(),
                  ),
                  onSelected: (String? value) {
                    if (value != null) {
                      setState(() {
                        selectedIndex = components.indexWhere(
                          (b) => b.title == value,
                        );
                        toggleButton(value);
                      });
                    }
                  },
                ),
            ],
          ),
        ),
        actionsPadding: EdgeInsets.only(right: 24.0),
        actions: [
          TextButton(
            onPressed: () async {
              final uri = Uri.parse('https://linkedin.com/in/palmerodev');
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(50, 30),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerLeft,
              foregroundColor: textMuted.toColor(),
              overlayColor: textMuted.toColor().withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/linkedin_svg.svg',
                    color: textMuted.toColor(),
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'in/palmerodev',
                    style: TextStyle(
                      color: textMuted.toColor(),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: isDesktop(context) ? 22 : 28,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isDesktop(context))
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: bgDark.toColor(),
                        border: Border.all(color: bgDark.toColor()),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Column(
                          spacing: 12,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            _buildSectionTitle('Home'),
                            RippleRevealButton(
                              radius: 4,
                              widgetA: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Welcome',
                                  style: TextStyle(
                                    color: bgDark.toColor(),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              widgetB: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Welcome',
                                  style: TextStyle(
                                    color: text.toColor(),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedIndex = 0;
                                  toggleButton('Welcome');
                                });
                              },
                              height: 35,
                              backgroundColorA: bgLight.toColor(),
                              selected: components[0].selected,
                              backgroundColorB: text.toColor(),
                              rippleColorA: text.toColor(),
                              rippleColorB: bgLight.toColor(),
                            ),
                            _buildSectionTitle('Buttons'),
                            ...buttons.map(
                              (e) {
                                return RippleRevealButton(
                                  radius: 4,
                                  widgetA: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      e.title,
                                      style: TextStyle(
                                        color: bgDark.toColor(),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  widgetB: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      e.title,
                                      style: TextStyle(
                                        color: text.toColor(),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedIndex = components.indexOf(e);
                                      toggleButton(e.title);
                                    });
                                  },
                                  height: 35,
                                  backgroundColorA: bgLight.toColor(),
                                  selected: e.selected,
                                  backgroundColorB: text.toColor(),
                                  rippleColorA: text.toColor(),
                                  rippleColorB: bgLight.toColor(),
                                );
                              },
                            ),
                            _buildSectionTitle('Texts'),
                            ...texts.map(
                              (e) {
                                return RippleRevealButton(
                                  radius: 4,
                                  widgetA: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      e.title,
                                      style: TextStyle(
                                        color: bgDark.toColor(),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  widgetB: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      e.title,
                                      style: TextStyle(
                                        color: text.toColor(),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedIndex = components.indexOf(e);
                                      toggleButton(e.title);
                                    });
                                  },
                                  height: 35,
                                  backgroundColorA: bgLight.toColor(),
                                  selected: e.selected,
                                  backgroundColorB: text.toColor(),
                                  rippleColorA: text.toColor(),
                                  rippleColorB: bgLight.toColor(),
                                );
                              },
                            ),
                            _buildSectionTitle('Indicators'),
                            ...indicators.map(
                              (e) {
                                return RippleRevealButton(
                                  radius: 4,
                                  widgetA: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      e.title,
                                      style: TextStyle(
                                        color: bgDark.toColor(),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  widgetB: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      e.title,
                                      style: TextStyle(
                                        color: text.toColor(),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedIndex = components.indexOf(e);
                                      toggleButton(e.title);
                                    });
                                  },
                                  height: 35,
                                  backgroundColorA: bgLight.toColor(),
                                  selected: e.selected,
                                  backgroundColorB: text.toColor(),
                                  rippleColorA: text.toColor(),
                                  rippleColorB: bgLight.toColor(),
                                );
                              },
                            ),
                            _buildSectionTitle('Loaders'),
                            ...loaders.map(
                              (e) {
                                return RippleRevealButton(
                                  radius: 4,
                                  widgetA: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      e.title,
                                      style: TextStyle(
                                        color: bgDark.toColor(),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  widgetB: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      e.title,
                                      style: TextStyle(
                                        color: text.toColor(),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedIndex = components.indexOf(e);
                                      toggleButton(e.title);
                                    });
                                  },
                                  height: 35,
                                  backgroundColorA: bgLight.toColor(),
                                  selected: e.selected,
                                  backgroundColorB: text.toColor(),
                                  rippleColorA: text.toColor(),
                                  rippleColorB: bgLight.toColor(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  flex: 15,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 24.0,
                      left: 32.0,
                      right: 32.0,
                    ),
                    child: components.elementAt(selectedIndex).page,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: isDesktop(context) ? 2 : 3,
            child: Container(
              color: bg.toColor(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Flutter Motionly',
                          style: TextStyle(
                            color: text.toColor(),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '© ${DateTime.now().year} Palmerodev. ${!isDesktop(context) ? '' : 'Todos los derechos reservados.'}',
                          style: TextStyle(
                            color: textMuted.toColor(),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Row(
                      spacing: 8,
                      children: [
                        _buildSocialButton(
                          icon: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/github_svg.svg',
                                color: textMuted.toColor(),
                                width: 18,
                                height: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'GitHub',
                                style: TextStyle(
                                  color: textMuted.toColor(),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          url: 'https://github.com/palmerovicdev/flutter_motionly_web',
                        ),
                        _buildSocialButton(
                          icon: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/mail_svg.svg',
                                color: textMuted.toColor(),
                                width: 18,
                                height: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'GMail',
                                style: TextStyle(
                                  color: textMuted.toColor(),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          url: 'mailto:palmerodev@gmail.com',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text _buildSectionTitle(String s) {
    return Text(
      s,
      style: TextStyle(
        color: textMuted.toColor(),
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    );
  }

  Widget _buildSocialButton({
    required Widget icon,
    required String url,
  }) {
    return FocusButton(
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      height: 36,
      width: 90,
      duration: Duration(seconds: 2),
      borderRadius: 4,
      backgroundColor: bg.toColor(),
      gradientColors: [
        bg.toColor(),
        bg.toColor(),
        bg.toColor(),
        bg.toColor(),
        bg.toColor(),
        bg.toColor(),
        bg.toColor(),
        bg.toColor(),
        bg.toColor(),
        bg.toColor(),
        bg.toColor(),
        info.toColor(),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [icon],
      ),
    );
  }

  void toggleButton(String key) {
    setState(() {
      for (var v in components) {
        if (v.title == key) {
          v.selected = true;
        } else {
          v.selected = false;
        }
      }
    });
  }
}

class ButtonItem {
  final String title;
  final Widget page;
  bool selected;

  ButtonItem({
    required this.title,
    required this.page,
    required this.selected,
  });
}

final components = [
  ButtonItem(
    title: 'Welcome',
    page: WelcomePage(),
    selected: true,
  ),
  ...buttons,
  ...texts,
  ...indicators,
  ...loaders,
];

final loaders = [
  ButtonItem(
    title: 'Wave Stick Loader',
    page: WaveStickPage(),
    selected: false,
  ),
  ButtonItem(
    title: 'Square Matrix Loader',
    page: SquareMatrixPage(),
    selected: false,
  ),
];

final texts = [
  ButtonItem(
    title: 'Animated Text',
    page: AnimatedTextDocPage(),
    selected: false,
  ),
  ButtonItem(
    title: 'Fuzzy Text',
    page: FuzzyTextDocPage(),
    selected: false,
  ),
];

final indicators = [
  ButtonItem(
    title: 'Indicator',
    page: IndicatorsPage(),
    selected: false,
  ),
];

final buttons = [
  ButtonItem(
    title: 'Ripple Reveal Button',
    page: RippleRevealButtonDocPage(),
    selected: false,
  ),
  ButtonItem(
    title: 'Rect Reveal Button',
    page: RectRevealButtonDocPage(),
    selected: false,
  ),
  ButtonItem(
    title: 'Focus Button',
    page: FocusButtonDocPage(),
    selected: false,
  ),
  ButtonItem(
    title: 'State Button',
    page: AnimatedStateButtonDocPage(),
    selected: false,
  ),
];
