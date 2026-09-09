// ═══════════════════════════════════════════════════════════════════════════════
// تفاصيل المعدة — Equipment Detail Screen
// كل المواصفات والبيانات بتاعة المعدة الواحدة
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/equipment_inventory.dart';

class EqDetailScreen extends StatelessWidget {
  final EquipmentItem equipment;

  const EqDetailScreen({super.key, required this.equipment});

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
    final stColor = _statusColor(equipment.status);
    final eqColor = Color(equipment.color);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          backgroundColor: AppTheme.darkBg,
          title: Text(
            equipment.nameAr,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: eqColor,
              shadows: [Shadow(color: eqColor, blurRadius: 8)],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppTheme.cyanGlow),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── الهدر: الأيقونة الكبيرة + الاسم + الحالة ──
              Container(
                padding: const EdgeInsets.all(20),
                decoration: AppTheme.glowBox(eqColor, blur: 20, op: 0.3),
                child: Column(
                  children: [
                    // الأيقونة الكبيرة
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: eqColor.withOpacity(0.12),
                        border: Border.all(color: eqColor.withOpacity(0.4), width: 2),
                        boxShadow: [BoxShadow(color: eqColor.withOpacity(0.3), blurRadius: 16)],
                      ),
                      child: Center(
                        child: Text(equipment.icon, style: const TextStyle(fontSize: 36)),
                      ),
                    ),
                    const SizedBox(height: 14),
                    // الاسم بالعربي
                    Text(
                      equipment.nameAr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // الاسم بالإنجليزي
                    Text(
                      equipment.nameEn,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppTheme.ice, fontSize: 13),
                    ),
                    const SizedBox(height: 10),
                    // شارة الحالة
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: stColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: stColor.withOpacity(0.4)),
                        boxShadow: [BoxShadow(color: stColor.withOpacity(0.2), blurRadius: 8)],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(_statusIcon(equipment.status), color: stColor, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            equipment.status,
                            style: TextStyle(
                              color: stColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // ── بيانات أساسية: الماركة / الموديل / السريال / البلد / التاريخ ──
              Container(
                padding: const EdgeInsets.all(16),
                decoration: AppTheme.glowBox(AppTheme.cyanGlow, blur: 10, op: 0.15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.info_outline, color: AppTheme.cyanGlow, size: 18),
                        SizedBox(width: 6),
                        Text(
                          'بيانات أساسية',
                          style: TextStyle(
                            color: AppTheme.cyanGlow,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow('الفئة', equipment.category, AppTheme.ice),
                    _buildInfoRow('الماركة (Brand)', equipment.brand, AppTheme.ice),
                    _buildInfoRow('الموديل (Model)', equipment.model, AppTheme.white),
                    _buildInfoRow('الرقم التسلسلي (Serial No)', equipment.serialNo, AppTheme.ice),
                    _buildInfoRow('بلد التصنيع (Made In)', equipment.madeIn, AppTheme.ice),
                    _buildInfoRow('تاريخ التصنيع (Mfg Date)', equipment.mfgDate, AppTheme.ice),
                    _buildInfoRow('المكان (Location)', equipment.location, AppTheme.greenNeon),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // ── المواصفات التقنية ──
              Container(
                padding: const EdgeInsets.all(16),
                decoration: AppTheme.glowBox(AppTheme.greenNeon, blur: 10, op: 0.15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.settings, color: AppTheme.greenNeon, size: 18),
                        SizedBox(width: 6),
                        Text(
                          'المواصفات التقنية (Specifications)',
                          style: TextStyle(
                            color: AppTheme.greenNeon,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...equipment.specs.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // المفتاح (اسم المواصفة)
                            Text(
                              entry.key,
                              style: const TextStyle(
                                color: AppTheme.ice,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            // القيمة
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppTheme.cardBg,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppTheme.subtleBorder),
                              ),
                              child: Text(
                                entry.value,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // ── ملاحظات ──
              if (equipment.notes.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: AppTheme.glowBox(AppTheme.amber, blur: 12, op: 0.2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.warning_amber, color: AppTheme.amber, size: 18),
                          SizedBox(width: 6),
                          Text(
                            'ملاحظات مهمة',
                            style: TextStyle(
                              color: AppTheme.amber,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        equipment.notes,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// سطر معلومات: ليل + قيمة
  Widget _buildInfoRow(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              color: AppTheme.grayText,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? '—' : value,
              style: TextStyle(
                color: value.isEmpty ? AppTheme.grayText : valueColor,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
