import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../theme/app_theme.dart';

class GuideDetailScreen extends StatelessWidget {
  final Guide guide;

  const GuideDetailScreen({super.key, required this.guide});

  Widget _sectionHeader(String title, Color c) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 8),
    child: Text(title, style: TextStyle(color: c, fontSize: 17, fontWeight: FontWeight.w900, shadows: [Shadow(color: c, blurRadius: 8)])),
  );

  Widget _numberedList(List<String> items, Color c) => Column(
    children: items.asMap().entries.map((e) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 12, backgroundColor: c.withOpacity(0.15),
              child: Text('${e.key + 1}', style: TextStyle(color: c, fontWeight: FontWeight.bold, fontSize: 11))),
          const SizedBox(width: 8),
          Expanded(child: Text(e.value, style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.6), textDirection: TextDirection.rtl)),
        ],
      ),
    )).toList(),
  );

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          backgroundColor: AppTheme.darkBg,
          title: Text(guide.title, style: TextStyle(color: AppTheme.cyanGlow, fontWeight: FontWeight.bold, shadows: [Shadow(color: AppTheme.cyanGlow, blurRadius: 8)]), textDirection: TextDirection.rtl),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppTheme.cyanGlow),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _sectionHeader('ما هو؟', AppTheme.cyanGlow),
              Text(guide.whatIs, style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.7), textDirection: TextDirection.rtl),
              _sectionHeader('مكوناته:', AppTheme.amber),
              _numberedList(guide.parts, AppTheme.amber),
              _sectionHeader('تفحصه إزاي في الموقع؟', AppTheme.greenNeon),
              _numberedList(guide.check, AppTheme.greenNeon),
              _sectionHeader('أعطاله الشائعة:', AppTheme.cyanGlow),
              _numberedList(guide.commonFaults, AppTheme.cyanGlow),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: AppTheme.glowBox(AppTheme.fireRed, blur: 12, op: 0.3),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Icon(Icons.dangerous, color: AppTheme.fireRed),
                  const SizedBox(width: 10),
                  Expanded(child: Text(guide.warn, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textDirection: TextDirection.rtl)),
                ]),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
