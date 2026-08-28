import 'package:flutter/material.dart';import '../data/app_data.dart';import '../theme/app_theme.dart';import 'guide_detail_screen.dart';

final Map<String, IconData> _guideIcons = {
  'chillers': Icons.ac_unit,
  'primaryPumps': Icons.water_drop,
  'condenserPumps': Icons.water_drop,
  'secondaryPumps': Icons.water_drop,
  'coolingTowers': Icons.air,
  'drives': Icons.electrical_services,
  'valves': Icons.settings,
  'waterTreatment': Icons.science,
  'expansionTank': Icons.propane_tank,
};

final Map<String, Color> _guideColors = {
  'chillers': const Color(0xFF00E5FF),
  'primaryPumps': const Color(0xFF38BDF8),
  'condenserPumps': const Color(0xFF2979FF),
  'secondaryPumps': const Color(0xFF00B0FF),
  'coolingTowers': const Color(0xFF2DD4BF),
  'drives': const Color(0xFF39FF14),
  'valves': const Color(0xFFFFAB00),
  'waterTreatment': const Color(0xFF4ADE80),
  'expansionTank': const Color(0xFF7DD3FC),
};

class GuidesScreen extends StatelessWidget {
  const GuidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          backgroundColor: AppTheme.darkBg,
          title: Text('الشروحات', style: TextStyle(color: AppTheme.greenNeon, fontWeight: FontWeight.bold, shadows: [Shadow(color: AppTheme.greenNeon, blurRadius: 10)])),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppTheme.cyanGlow),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: allGuides.length,
          itemBuilder: (context, index) {
            final g = allGuides[index];
            return _buildGuideCard(context, g);
          },
        ),
      ),
    );
  }

  Widget _buildGuideCard(BuildContext context, Guide g) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => GuideDetailScreen(guide: g))),
        child: Container(
          decoration: AppTheme.glowBox(AppTheme.cyanGlow, blur: 10, op: 0.2),
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppTheme.cyanGlow.withOpacity(0.12),
                child: const Icon(Icons.menu_book, color: AppTheme.cyanGlow, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(g.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15), textDirection: TextDirection.rtl, maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text('${g.parts.length} مكون • ${g.check.length} نقطة فحص • ${g.commonFaults.length} عطل شائع', style: const TextStyle(color: AppTheme.ice, fontSize: 11)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_left, color: AppTheme.ice),
            ],
          ),
        ),
      ),
    );
  }
}
