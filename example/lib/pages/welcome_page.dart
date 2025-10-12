import 'package:flutter/material.dart';
import 'package:flutter_motionly/widget/button/focus_button.dart';
import 'package:flutter_motionly/widget/text/animated_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/utils.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isNarrow = isNarrowScreen(context);
    final links = [
      _buildLinkButton(
        icon: Icons.code,
        label: 'pub.dev',
        url: 'https://pub.dev/packages/flutter_motionly',
        color: primary.toColor(),
      ),
      _buildLinkButton(
        icon: Icons.code_outlined,
        label: 'GitHub',
        url: 'https://github.com/palmerovicdev/flutter_motionly',
        color: info.toColor(),
        svgAsset: 'assets/github_svg.svg',
      ),
      _buildLinkButton(
        icon: Icons.person,
        label: 'LinkedIn',
        url: 'https://linkedin.com/in/palmerodev',
        color: secondary.toColor(),
        svgAsset: 'assets/linkedin_svg.svg',
      ),
      _buildLinkButton(
        icon: Icons.email,
        label: 'Email',
        url: 'mailto:palmerodev@gmail.com',
        color: success.toColor(),
        svgAsset: 'assets/mail_svg.svg',
      ),
    ];
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isNarrow ? 16.0 : 48.0,
            vertical: isNarrow ? 24.0 : 48.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              Icon(
                Icons.animation,
                size: isNarrow ? 80 : 120,
                color: primary.toColor(),
              ),

              const SizedBox(height: 32),

              FittedBox(
                fit: BoxFit.scaleDown,
                child: AnimatedText(
                  text: 'Flutter Motionly',
                  splitType: SplitType.char,
                  animationType: AnimationType.fade,
                  duration: Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  autoPlay: true,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Widgets animados personalizados para Flutter',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isNarrow ? 16 : 20,
                  color: textMuted.toColor(),
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 48),

              _buildFeatureSection(isNarrow),

              const SizedBox(height: 56),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: isNarrowScreen(context) ? 32.0 : 148),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isNarrow ? 2 : 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    mainAxisExtent: 50,
                  ),
                  itemCount: links.length,
                  itemBuilder: (context, index) => SizedBox(
                    width: 120,
                    child: links[index],
                  ),
                ),
              ),

              const SizedBox(height: 56),

              Container(
                padding: EdgeInsets.all(isNarrow ? 24 : 32),
                decoration: BoxDecoration(
                  color: bg.toColor(),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: border.toColor().withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      '🚀 Comienza a usar Flutter Motionly',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isNarrow ? 18 : 22,
                        fontWeight: FontWeight.w600,
                        color: text.toColor(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Selecciona un componente del menú lateral para ver ejemplos interactivos y código',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isNarrow ? 14 : 16,
                        color: textMuted.toColor(),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureSection(bool isNarrow) {
    return Container(
      constraints: BoxConstraints(maxWidth: 800),
      child: Wrap(
        spacing: isNarrow ? 16 : 24,
        runSpacing: isNarrow ? 16 : 24,
        alignment: WrapAlignment.center,
        children: [
          _buildFeatureCard(
            icon: Icons.touch_app,
            title: 'Botones Animados',
            description: '4 tipos de botones con efectos visuales impactantes',
            isNarrow: isNarrow,
          ),
          _buildFeatureCard(
            icon: Icons.text_fields,
            title: 'Textos Animados',
            description: '9 tipos de animaciones para textos dinámicos',
            isNarrow: isNarrow,
          ),
          _buildFeatureCard(
            icon: Icons.radio_button_checked,
            title: 'Indicadores',
            description: 'Indicadores circulares con revelación animada',
            isNarrow: isNarrow,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isNarrow,
  }) {
    return Container(
      width: isNarrow ? double.infinity : 240,
      padding: EdgeInsets.all(isNarrow ? 20 : 24),
      decoration: BoxDecoration(
        color: bgLight.toColor(),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: border.toColor().withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isNarrow ? 36 : 48,
            color: primary.toColor(),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isNarrow ? 16 : 18,
              fontWeight: FontWeight.w600,
              color: text.toColor(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isNarrow ? 13 : 14,
              color: textMuted.toColor(),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkButton({
    required IconData icon,
    required String label,
    required String url,
    required Color color,
    String? svgAsset,
  }) {
    return FocusButton(
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      height: 50,
      width: 160,
      duration: Duration(seconds: 2),
      borderRadius: 8,
      backgroundColor: bgLight.toColor(),
      gradientColors: [
        bgLight.toColor(),
        bgLight.toColor(),
        bgLight.toColor(),
        bgLight.toColor(),
        bgLight.toColor(),
        bgLight.toColor(),
        bgLight.toColor(),
        bgLight.toColor(),
        color,
      ],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          if (svgAsset != null)
            SvgPicture.asset(
              svgAsset,
              color: text.toColor(),
              width: 20,
              height: 20,
            )
          else
            Icon(icon, color: text.toColor(), size: 20),
          Text(
            label,
            style: TextStyle(
              color: text.toColor(),
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
