import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../theme/app_theme.dart';

class GuideDetailScreen extends StatelessWidget {
  final Guide guide;

  const GuideDetailScreen({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          backgroundColor: AppTheme.darkBg,
          title: Text(
            guide.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.cyanGlow,
            ),
            textDirection: TextDirection.rtl,
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppTheme.cyanGlow),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Image placeholder
              if (guide.hasImage) ...[
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: AppTheme.cardBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.cyanGlow.withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('📸', style: TextStyle(fontSize: 40)),
                      const SizedBox(height: 8),
                      Text(
                        'صورة توضيحية',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.grayText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
              // Warning if exists
              if (guide.warning != null && guide.warning!.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.cardBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.fireRed.withOpacity(0.5),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.fireRed.withOpacity(0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            const Icon(Icons.warning_amber_rounded,
                                color: AppTheme.fireRed, size: 22),
                            const SizedBox(width: 8),
                            Text(
                              'تحذير',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.fireRed,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          guide.warning!,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.white,
                            height: 1.6,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              // Steps header
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  const Icon(Icons.format_list_numbered_rtl,
                      color: AppTheme.cyanGlow, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'الخطوات (${guide.steps.length})',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.cyanGlow,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Steps list
              ...guide.steps.asMap().entries.map((entry) {
                final stepNum = entry.key + 1;
                final stepText = entry.value;
                return _buildStepItem(stepNum, stepText);
              }),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepItem(int number, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.subtleBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: [
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: AppTheme.cyanGlow.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppTheme.cyanGlow.withOpacity(0.3),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                '$number',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.cyanGlow,
                ),
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.white,
                  height: 1.6,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
