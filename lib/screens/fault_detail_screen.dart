import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../data/app_data.dart';
import '../theme/app_theme.dart';

class FaultDetailScreen extends StatelessWidget {
  final Fault fault;

  const FaultDetailScreen({super.key, required this.fault});

  String _buildShareText() {
    final category = getCategoryById(fault.categoryId);
    return '''
🔧 ${fault.title}
📁 ${category?.nameAr ?? ''}

⚠️ التحذير:
${fault.warning}

🔍 السبب:
${fault.cause}

✅ الحل:
${fault.solution}

---
المساعد الذكي - Smart Assistant
Mohamed_Bn_saber
''';
  }

  void _shareText() {
    Share.share(_buildShareText(), subject: fault.title);
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: _buildShareText()));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم النسخ ✅',
          style: TextStyle(color: AppTheme.darkBg, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppTheme.greenNeon,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          backgroundColor: AppTheme.darkBg,
          title: Text(
            fault.title,
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
              // Warning Section
              _buildSectionCard(
                icon: Icons.warning_amber_rounded,
                iconColor: AppTheme.fireRed,
                borderColor: AppTheme.fireRed,
                title: 'التحذير',
                body: fault.warning,
              ),
              const SizedBox(height: 16),
              // Cause Section
              _buildSectionCard(
                icon: Icons.search_rounded,
                iconColor: AppTheme.amber,
                borderColor: AppTheme.amber,
                title: 'السبب',
                body: fault.cause,
              ),
              const SizedBox(height: 16),
              // Solution Section
              _buildSolutionCard(),
              const SizedBox(height: 24),
              // Action Buttons
              _buildActionButtons(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required Color iconColor,
    required Color borderColor,
    required String title,
    required String body,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.1),
            blurRadius: 15,
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
                Icon(icon, color: iconColor, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(color: borderColor.withOpacity(0.2), thickness: 1),
            const SizedBox(height: 10),
            Text(
              body,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.white,
                height: 1.7,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSolutionCard() {
    final steps = fault.solution.split('\n').where((s) => s.trim().isNotEmpty).toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.greenNeon.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppTheme.greenNeon.withOpacity(0.1),
            blurRadius: 15,
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
                const Icon(Icons.check_circle_rounded,
                    color: AppTheme.greenNeon, size: 24),
                const SizedBox(width: 8),
                Text(
                  'الحل',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.greenNeon,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(color: AppTheme.greenNeon.withOpacity(0.2), thickness: 1),
            const SizedBox(height: 10),
            ...steps.map((step) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: AppTheme.greenNeon.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        step.trim().substring(0, 1),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.greenNeon,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        step.trim(),
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
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _shareText,
            icon: const Icon(Icons.share, size: 20),
            label: Text(
              'مشاركة',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkBg,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.cyanGlow,
              foregroundColor: AppTheme.darkBg,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _copyToClipboard(context),
            icon: const Icon(Icons.copy, size: 20),
            label: Text(
              '📋 نسخ',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkBg,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.greenNeon,
              foregroundColor: AppTheme.darkBg,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
