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
    final steps = fault.solution.split('\n').where((s) => s.trim().isNotEmpty).toList();
    final stepsText = steps.asMap().entries.map((e) => '${e.key + 1}. ${e.value.trim()}').join('\n');
    return '''\u{1F527} ${fault.title}\n\u{1F4C1} ${category?.nameAr ?? ''}\n\n\u26A0\uFE0F التحذير:\n${fault.warning}\n\n\u{1F50D} السبب:\n${fault.cause}\n\n\u2705 الحل:\n$stepsText\n\n---\nالمساعد الذكي - Smart Assistant\nMohamed_Bn_saber''';
  }

  void _shareText() => Share.share(_buildShareText(), subject: fault.title);

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: _buildShareText()));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم النسخ', style: TextStyle(color: AppTheme.darkBg, fontWeight: FontWeight.bold)), backgroundColor: AppTheme.greenNeon, duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sevColor = AppTheme.severityColor(fault.severity);
    final category = getCategoryById(fault.categoryId);
    final steps = fault.solution.split('\n').where((s) => s.trim().isNotEmpty).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          backgroundColor: AppTheme.darkBg,
          title: Text(fault.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: sevColor, shadows: [Shadow(color: sevColor, blurRadius: 8)]), textDirection: TextDirection.rtl),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppTheme.cyanGlow),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Severity + Equipment badge
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: sevColor.withOpacity(0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: sevColor.withOpacity(0.4))),
                    child: Row(children: [Icon(AppTheme.severityIcon(fault.severity), color: sevColor, size: 16), const SizedBox(width: 4), Text(AppTheme.severityLabel(fault.severity), style: TextStyle(color: sevColor, fontWeight: FontWeight.bold, fontSize: 12))]),
                  ),
                  const SizedBox(width: 8),
                  if (category != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Color(category.color).withOpacity(0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: Color(category.color).withOpacity(0.3))),
                      child: Text('${category.nameAr} - ${category.nameEn}', style: TextStyle(color: Color(category.color), fontSize: 12)),
                    ),
                ],
              ),
              const SizedBox(height: 16),

              // Warning
              Container(
                padding: const EdgeInsets.all(14),
                decoration: AppTheme.glowBox(AppTheme.fireRed, blur: 12, op: 0.3),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Icon(Icons.dangerous, color: AppTheme.fireRed),
                  const SizedBox(width: 10),
                  Expanded(child: Text(fault.warning, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textDirection: TextDirection.rtl)),
                ]),
              ),
              const SizedBox(height: 16),

              // Cause
              Container(
                padding: const EdgeInsets.all(14),
                decoration: AppTheme.glowBox(AppTheme.amber, blur: 12, op: 0.25),
                child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Row(children: [const Icon(Icons.search_rounded, color: AppTheme.amber), const SizedBox(width: 8), Text('السبب الغالب:', style: TextStyle(color: AppTheme.amber, fontSize: 17, fontWeight: FontWeight.bold))]),
                  const SizedBox(height: 10),
                  Text(fault.cause, style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.7), textDirection: TextDirection.rtl),
                ]),
              ),
              const SizedBox(height: 20),

              // Solution Steps
              Text('الحل خطوة بخطوة:', style: TextStyle(color: AppTheme.greenNeon, fontSize: 18, fontWeight: FontWeight.w900, shadows: [Shadow(color: AppTheme.greenNeon, blurRadius: 10)])),
              const SizedBox(height: 12),
              for (int i = 0; i < steps.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: AppTheme.greenNeon.withOpacity(0.15),
                        child: Text('${i + 1}', style: const TextStyle(color: AppTheme.greenNeon, fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: Text(steps[i].trim(), style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.6), textDirection: TextDirection.rtl)),
                    ],
                  ),
                ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _shareText,
                    icon: const Icon(Icons.share, size: 20),
                    label: const Text('مشاركة', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.darkBg)),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.cyanGlow, foregroundColor: AppTheme.darkBg, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _copyToClipboard(context),
                    icon: const Icon(Icons.copy, size: 20),
                    label: const Text('نسخ', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.darkBg)),
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.greenNeon, foregroundColor: AppTheme.darkBg, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  ),
                ),
              ]),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
