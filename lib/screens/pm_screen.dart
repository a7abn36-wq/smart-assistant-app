// ═══════════════════════════════════════════════════════════════════════════════
// جدول الصيانة — PM Schedule Screen
// كل مهام الصيانة الدورية مجمعة حسب التكرار
// ═══════════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../data/equipment_inventory.dart';

class PMScreen extends StatelessWidget {
  const PMScreen({super.key});

  /// ترتيب التكرارات
  static const List<String> _freqOrder = [
    'يومياً',
    'كل أسبوع',
    'كل شهر',
    'كل 3 شهور',
    'كل 6 شهور',
    'كل سنة',
    'كل 4000 ساعة تشغيل',
  ];

  /// أيقونة التكرار
  IconData _freqIcon(String freq) {
    switch (freq) {
      case 'يومياً':
        return Icons.today;
      case 'كل أسبوع':
        return Icons.date_range;
      case 'كل شهر':
        return Icons.calendar_month;
      case 'كل 3 شهور':
        return Icons.schedule;
      case 'كل 6 شهور':
        return Icons.update;
      case 'كل سنة':
        return Icons.event_note;
      case 'كل 4000 ساعة تشغيل':
        return Icons.hourglass_top;
      default:
        return Icons.timer;
    }
  }

  /// لون التكرار
  Color _freqColor(String freq) {
    switch (freq) {
      case 'يومياً':
        return AppTheme.fireRed;
      case 'كل أسبوع':
        return AppTheme.amber;
      case 'كل شهر':
        return AppTheme.cyanGlow;
      case 'كل 3 شهور':
        return AppTheme.ice;
      case 'كل 6 شهور':
        return AppTheme.greenNeon;
      case 'كل سنة':
        return AppTheme.greenNeon;
      case 'كل 4000 ساعة تشغيل':
        return AppTheme.amber;
      default:
        return AppTheme.grayText;
    }
  }

  /// جيب اسم المعدة من الـ ID
  String _equipName(String equipId) {
    final eq = plantEquipment.where((e) => e.id == equipId);
    if (eq.isNotEmpty) return eq.first.nameAr;
    return equipId;
  }

  /// جيب أيقونة المعدة من الـ ID
  String _equipIcon(String equipId) {
    final eq = plantEquipment.where((e) => e.id == equipId);
    if (eq.isNotEmpty) return eq.first.icon;
    return '⚙️';
  }

  @override
  Widget build(BuildContext context) {
    // تجميع المهام حسب التكرار
    final Map<String, List<PMTask>> grouped = {};
    for (final task in pmSchedule) {
      grouped.putIfAbsent(task.frequency, () => []).add(task);
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          backgroundColor: AppTheme.darkBg,
          title: Text(
            'جدول الصيانة',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.greenNeon,
              shadows: [Shadow(color: AppTheme.greenNeon, blurRadius: 10)],
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppTheme.cyanGlow),
        ),
        body: Column(
          children: [
            // ملخص سريع
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(14),
              decoration: AppTheme.glowBox(AppTheme.greenNeon, blur: 14, op: 0.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatChip(
                    '${pmSchedule.length}',
                    'مهمة صيانة',
                    AppTheme.greenNeon,
                  ),
                  _buildStatChip(
                    '${pmSchedule.where((t) => t.severity == "critical").length}',
                    'حرج',
                    AppTheme.fireRed,
                  ),
                  _buildStatChip(
                    '${pmSchedule.where((t) => t.severity == "warning").length}',
                    'تحذير',
                    AppTheme.amber,
                  ),
                  _buildStatChip(
                    '${pmSchedule.where((t) => t.severity == "info").length}',
                    'معلومة',
                    AppTheme.greenNeon,
                  ),
                ],
              ),
            ),
            // المهام مجمعة
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  for (final freq in _freqOrder)
                    if (grouped.containsKey(freq)) ...[
                      // هدر التكرار
                      Padding(
                        padding: const EdgeInsets.only(top: 14, bottom: 8),
                        child: Row(
                          children: [
                            Icon(_freqIcon(freq), color: _freqColor(freq), size: 20),
                            const SizedBox(width: 8),
                            Text(
                              freq,
                              style: TextStyle(
                                color: _freqColor(freq),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                shadows: [Shadow(color: _freqColor(freq), blurRadius: 6)],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: _freqColor(freq).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${grouped[freq]!.length}',
                                style: TextStyle(
                                  color: _freqColor(freq),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // كروت المهام
                      ...grouped[freq]!.map((task) {
                        final sevColor = AppTheme.severityColor(task.severity);
                        final sevIcon = AppTheme.severityIcon(task.severity);
                        final sevLabel = AppTheme.severityLabel(task.severity);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GestureDetector(
                            onTap: () => _showNotesDialog(context, task),
                            child: Container(
                              decoration: AppTheme.glowBox(sevColor, blur: 8, op: 0.15),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // السطر الأول: أيقونة + المهمة + شارة الأهمية
                                    Row(
                                      children: [
                                        Text(task.icon, style: const TextStyle(fontSize: 20)),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            task.taskAr,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: sevColor.withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: sevColor.withOpacity(0.3)),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(sevIcon, color: sevColor, size: 12),
                                              const SizedBox(width: 3),
                                              Text(
                                                sevLabel,
                                                style: TextStyle(
                                                  color: sevColor,
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    // السطر التاني: المعدة
                                    Row(
                                      children: [
                                        Text(_equipIcon(task.equipmentId), style: const TextStyle(fontSize: 14)),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            _equipName(task.equipmentId),
                                            style: const TextStyle(
                                              color: AppTheme.ice,
                                              fontSize: 11,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// عرض ملاحظات المهمة في دايلوج
  void _showNotesDialog(BuildContext context, PMTask task) {
    final sevColor = AppTheme.severityColor(task.severity);

    showDialog(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: AppTheme.cardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: sevColor.withOpacity(0.4)),
          ),
          title: Row(
            children: [
              Text(task.icon, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  task.taskAr,
                  style: TextStyle(
                    color: sevColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // التكرار
              _buildDialogRow('التكرار', task.frequency, AppTheme.cyanGlow),
              const SizedBox(height: 6),
              // المعدة
              _buildDialogRow('المعدة', _equipName(task.equipmentId), AppTheme.ice),
              const SizedBox(height: 6),
              // آخر مرة
              _buildDialogRow('آخر مرة اتعملت', task.lastDone, AppTheme.grayText),
              const SizedBox(height: 6),
              // المرة الجاية
              _buildDialogRow('المرة الجاية', task.nextDue, AppTheme.grayText),
              const SizedBox(height: 10),
              // ملاحظات
              const Text(
                'ملاحظات:',
                style: TextStyle(
                  color: AppTheme.amber,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                task.notes,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(
                'فهمت',
                style: TextStyle(color: AppTheme.cyanGlow, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// سطر في الدايلوج
  Widget _buildDialogRow(String label, String value, Color valueColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(color: AppTheme.grayText, fontSize: 12, fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: Text(
            value.isEmpty ? '—' : value,
            style: TextStyle(color: valueColor, fontSize: 12),
          ),
        ),
      ],
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
