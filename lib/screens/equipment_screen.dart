// ═══════════════════════════════════════════════════════════════════════════════
// معدات المحطة — Equipment Inventory Screen
// كل المعدات المتسجلة في المحطة مع حالتها
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/equipment_inventory.dart';
import 'eq_detail_screen.dart';

class EquipmentScreen extends StatelessWidget {
  const EquipmentScreen({super.key});

  /// بيرجع لون الحالة
  Color _statusColor(String status) {
    switch (status) {
      case 'شغال':
        return AppTheme.greenNeon;
      case 'واقف':
        return AppTheme.fireRed;
      case 'تحت صيانة':
        return AppTheme.amber;
      default:
        return AppTheme.grayText;
    }
  }

  /// بيرجع أيقونة الحالة
  IconData _statusIcon(String status) {
    switch (status) {
      case 'شغال':
        return Icons.check_circle;
      case 'واقف':
        return Icons.cancel;
      case 'تحت صيانة':
        return Icons.build;
      default:
        return Icons.help_outline;
    }
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
            'معدات المحطة',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.cyanGlow,
              shadows: [Shadow(color: AppTheme.cyanGlow, blurRadius: 10)],
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppTheme.cyanGlow),
        ),
        body: Column(
          children: [
            // ملخص سريع - عدد المعدات والحالات
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(14),
              decoration: AppTheme.glowBox(AppTheme.cyanGlow, blur: 14, op: 0.25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatChip(
                    '${plantEquipment.length}',
                    'معدة',
                    AppTheme.cyanGlow,
                  ),
                  _buildStatChip(
                    '${plantEquipment.where((e) => e.status == "شغال").length}',
                    'شغال',
                    AppTheme.greenNeon,
                  ),
                  _buildStatChip(
                    '${plantEquipment.where((e) => e.status == "واقف").length}',
                    'واقف',
                    AppTheme.fireRed,
                  ),
                  _buildStatChip(
                    '${plantEquipment.where((e) => e.status == "تحت صيانة").length}',
                    'تحت صيانة',
                    AppTheme.amber,
                  ),
                ],
              ),
            ),
            // قايمة المعدات
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                itemCount: plantEquipment.length,
                itemBuilder: (context, index) {
                  final eq = plantEquipment[index];
                  final stColor = _statusColor(eq.status);
                  final eqColor = Color(eq.color);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => EqDetailScreen(equipment: eq)),
                      ),
                      child: Container(
                        decoration: AppTheme.glowBox(eqColor, blur: 10, op: 0.2),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: eqColor.withOpacity(0.15),
                            child: Text(eq.icon, style: const TextStyle(fontSize: 22)),
                          ),
                          title: Text(
                            eq.nameAr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Row(
                              children: [
                                Icon(Icons.business, size: 12, color: AppTheme.ice),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    eq.brand,
                                    style: const TextStyle(color: AppTheme.ice, fontSize: 11),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(_statusIcon(eq.status), color: stColor, size: 18),
                              const SizedBox(height: 2),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: stColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: stColor.withOpacity(0.3)),
                                ),
                                child: Text(
                                  eq.status,
                                  style: TextStyle(
                                    color: stColor,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ودجت الشريحة الإحصائية
  Widget _buildStatChip(String count, String label, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            color: color,
            fontSize: 22,
            fontWeight: FontWeight.w900,
            shadows: [Shadow(color: color, blurRadius: 8)],
          ),
        ),
        Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
