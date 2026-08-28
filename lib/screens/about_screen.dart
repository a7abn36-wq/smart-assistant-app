import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final critCount = allFaults.where((f) => f.severity == 'critical').length;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(backgroundColor: AppTheme.darkBg, title: Text('حول التطبيق', style: TextStyle(color: AppTheme.cyanGlow, fontWeight: FontWeight.bold)), centerTitle: true, iconTheme: const IconThemeData(color: AppTheme.cyanGlow)),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            const SizedBox(height: 20),
            Container(width: 120, height: 120,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppTheme.cyanGlow.withOpacity(0.4), width: 2),
                boxShadow: [BoxShadow(color: AppTheme.cyanGlow.withOpacity(0.2), blurRadius: 30, spreadRadius: 5)]),
              child: ClipOval(child: Image.asset('assets/images/logo.jpg', fit: BoxFit.cover)),
            ),
            const SizedBox(height: 20),
            const Text(
              'المساعد الذكي',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppTheme.greenNeon,
                shadows: [Shadow(color: AppTheme.greenNeon, blurRadius: 15)],
              ),
            ),
            const SizedBox(height: 8),
            const Text('Smart Assistant', style: TextStyle(fontSize: 16, color: AppTheme.cyanGlow)),
            const SizedBox(height: 4),
            const Text('Mohamed_Bn_saber', style: TextStyle(fontSize: 14, color: AppTheme.ice)),
            const SizedBox(height: 30),
            // Stats
            Container(padding: const EdgeInsets.all(16), decoration: AppTheme.glowBox(AppTheme.cyanGlow, blur: 14, op: 0.2),
              child: Column(children: [
                const Text('محتوى التطبيق', style: TextStyle(color: AppTheme.cyanGlow, fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _statRow('الأعطال', '${allFaults.length} عطل', AppTheme.cyanGlow),
                _statRow('الشروحات', '${allGuides.length} شرح', AppTheme.greenNeon),
                _statRow('الفئات', '${categories.length} فئة', AppTheme.amber),
                _statRow('المصطلحات العامية', '${colloquialTerms.length} مصطلح', AppTheme.ice),
                _statRow('أعطال الطوارئ', '${emergencyFaultIds.length} عطل حرج', AppTheme.fireRed),
              ]),
            ),
            const SizedBox(height: 20),
            // Terms preview
            Container(padding: const EdgeInsets.all(14), decoration: AppTheme.glowBox(AppTheme.amber, blur: 12, op: 0.2),
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                const Text('أمثلة المصطلحات', style: TextStyle(color: AppTheme.amber, fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ...colloquialTerms.entries.take(8).map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(children: [
                    Text(e.key, style: const TextStyle(color: AppTheme.ice, fontSize: 13, fontWeight: FontWeight.w600)),
                    const Text('  →  ', style: TextStyle(color: AppTheme.grayText)),
                    Expanded(child: Text(e.value, style: const TextStyle(color: Colors.white, fontSize: 12))),
                  ]),
                )),
              ]),
            ),
            const SizedBox(height: 20),
            const Text('تطبيق أوفلاين 100% — صيانة محطة التبريد', style: TextStyle(color: AppTheme.grayText, fontSize: 13)),
            const SizedBox(height: 30),
          ]),
        ),
      ),
    );
  }

  Widget _statRow(String label, String value, Color c) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [
      Expanded(child: Text(label, style: const TextStyle(color: AppTheme.ice, fontSize: 14))),
      Text(value, style: TextStyle(color: c, fontSize: 14, fontWeight: FontWeight.bold)),
    ]),
  );
}