import 'package:flutter/material.dart';

bool isDesktop(BuildContext context) {
  return MediaQuery.of(context).size.width >= 1200;
}

bool isNarrowScreen(BuildContext context) {
  return MediaQuery.of(context).size.width < 600;
}

final bgDark = HSLColor.fromAHSL(1, 239, 0.61, 0.03);
final bg = HSLColor.fromAHSL(1, 236, 0.41, 0.06);
final bgLight = HSLColor.fromAHSL(1, 235, 0.26, 0.10);
final text = HSLColor.fromAHSL(1, 234, 1.0, 1.0);
final textMuted = HSLColor.fromAHSL(1, 234, 0.30, 0.74);
final highlight = HSLColor.fromAHSL(1, 235, 0.16, 0.43);
final border = HSLColor.fromAHSL(1, 235, 0.20, 0.32);
final borderMuted = HSLColor.fromAHSL(1, 236, 0.27, 0.22);
final primary = HSLColor.fromAHSL(1, 195, 0.65, 0.65);
final secondary = HSLColor.fromAHSL(1, 16, 0.69, 0.70);
final danger = HSLColor.fromAHSL(1, 9, 0.53, 0.66);
final warning = HSLColor.fromAHSL(1, 51, 0.35, 0.50);
final success = HSLColor.fromAHSL(1, 149, 0.34, 0.54);
final info = HSLColor.fromAHSL(1, 217, 0.59, 0.67);

Widget buildCodeBlock(String code, bool isNarrow) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(isNarrow ? 16 : 24),
    decoration: BoxDecoration(
      color: bg.toColor(),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: border.toColor().withValues(alpha: 0.3),
        width: 1,
      ),
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SelectableText(
        code,
        style: TextStyle(
          color: text.toColor(),
          fontSize: isNarrow ? 13 : 14,
          fontFamily: 'monospace',
          height: 1.6,
        ),
      ),
    ),
  );
}

Widget buildFeatureGrid(bool isNarrow, List features) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: isNarrow ? 1 : 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      mainAxisExtent: isNarrow ? 180 : 200,
      childAspectRatio: isNarrow ? 3 : 2.5,
    ),
    itemCount: features.length,
    itemBuilder: (context, index) {
      final feature = features[index];
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              feature['icon'] as IconData,
              color: primary.toColor(),
              size: isNarrowScreen(context) ? 24 : 48,
            ),
            const SizedBox(height: 12),
            Text(
              feature['title'] as String,
              style: TextStyle(
                color: text.toColor(),
                fontSize: isNarrowScreen(context) ? 12 : 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              feature['description'] as String,
              style: TextStyle(
                color: textMuted.toColor(),
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget buildSectionTitle(String title, bool isNarrow) {
  return Text(
    title,
    style: TextStyle(
      color: text.toColor(),
      fontSize: isNarrow ? 28 : 40,
      fontWeight: FontWeight.w800,
      height: 1.2,
    ),
  );
}

Widget buildPracticeCard(String title, List<String> items, Color color, bool isNarrow) {
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

Widget buildExampleCard(
  String title,
  String description,
  bool isNarrow,
  Widget demo,
  String? code,
) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(isNarrow ? 24 : 32),
    decoration: BoxDecoration(
      color: bgLight.toColor().withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: border.toColor().withValues(alpha: 0.3),
        width: 1,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: text.toColor(),
            fontSize: isNarrow ? 20 : 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            color: textMuted.toColor(),
            fontSize: 14,
            height: 1.5,
          ),
        ),
        SizedBox(height: isNarrow ? 24 : 32),
        demo,
        if (code != null) ...[
          SizedBox(height: isNarrow ? 24 : 32),
          buildCodeBlock(code, isNarrow),
        ],
      ],
    ),
  );
}

Widget buildPropertiesTable(bool isNarrow, List properties) {
  return Container(
    decoration: BoxDecoration(
      color: bgLight.toColor().withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: border.toColor().withValues(alpha: 0.3),
        width: 1,
      ),
    ),
    child: Column(
      children: properties.asMap().entries.map((entry) {
        final index = entry.key;
        final prop = entry.value;
        final isLast = index == properties.length - 1;

        return Container(
          padding: EdgeInsets.all(isNarrow ? 16 : 20),
          decoration: BoxDecoration(
            border: isLast
                ? null
                : Border(
                    bottom: BorderSide(
                      color: border.toColor().withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
          ),
          child: isNarrow
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          prop['name']!,
                          style: TextStyle(
                            color: primary.toColor(),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          prop['type']!,
                          style: TextStyle(
                            color: textMuted.toColor(),
                            fontSize: 12,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      prop['description']!,
                      style: TextStyle(
                        color: text.toColor(),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Por defecto: ${prop['default']}',
                      style: TextStyle(
                        color: textMuted.toColor(),
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        prop['name']!,
                        style: TextStyle(
                          color: primary.toColor(),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        prop['type']!,
                        style: TextStyle(
                          color: textMuted.toColor(),
                          fontSize: 13,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        prop['default']!,
                        style: TextStyle(
                          color: textMuted.toColor(),
                          fontSize: 13,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        prop['description']!,
                        style: TextStyle(
                          color: text.toColor(),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
        );
      }).toList(),
    ),
  );
}
