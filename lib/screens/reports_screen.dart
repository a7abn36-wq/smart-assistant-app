import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import '../data/app_data.dart';
import '../theme/app_theme.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String? _selectedCategoryId;
  final TextEditingController _faultDescController = TextEditingController();
  final TextEditingController _actionsController = TextEditingController();
  String? _selectedStatus;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  final List<String> _statuses = [
    'تم الإصلاح',
    'تحت الصيانة',
    'يحتاج قطع غيار',
  ];

  @override
  void dispose() {
    _faultDescController.dispose();
    _actionsController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  String _generateReport() {
    final cat = _selectedCategoryId != null
        ? getCategoryById(_selectedCategoryId!)
        : null;
    final now = DateTime.now();
    final dateStr =
        '${now.year}/${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    return '''═══════════════════════════════════
📋 تقرير صيانة - محطة التبريد
═══════════════════════════════════
📅 التاريخ: $dateStr

📁 المعدة: ${cat?.nameAr ?? 'غير محدد'} - ${cat?.nameEn ?? ''}

📝 وصف العطل:
${_faultDescController.text.isEmpty ? '—' : _faultDescController.text}

🔧 الإجراءات المتخذة:
${_actionsController.text.isEmpty ? '—' : _actionsController.text}

📊 الحالة: ${_selectedStatus ?? 'غير محدد'}
${_selectedImage != null ? '\n📸 تم إرفاق صورة' : ''}

───────────────────────────────────
المساعد الذكي - Smart Assistant
Mohamed_Bn_saber
═══════════════════════════════════''';
  }

  void _shareWhatsApp() {
    final report = _generateReport();
    // share_plus will open the share sheet, user can pick WhatsApp
    Share.share(report, subject: 'تقرير صيانة محطة تبريد');
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
            '📋 التقارير',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.cyanGlow,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppTheme.cyanGlow),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Category Dropdown
              _buildLabel('📁 المعدة'),
              const SizedBox(height: 6),
              _buildDropdown(
                value: _selectedCategoryId,
                items: categories.map((cat) {
                  return DropdownMenuItem(
                    value: cat.id,
                    child: Text(
                      '${cat.icon} ${cat.nameAr} - ${cat.nameEn}',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.white,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  );
                }).toList(),
                hint: 'اختر المعدة',
                onChanged: (val) => setState(() => _selectedCategoryId = val),
              ),
              const SizedBox(height: 18),

              // Fault Description
              _buildLabel('📝 وصف العطل'),
              const SizedBox(height: 6),
              _buildTextField(
                controller: _faultDescController,
                hint: 'اكتب وصف العطل...',
                maxLines: 3,
              ),
              const SizedBox(height: 18),

              // Actions Taken
              _buildLabel('🔧 الإجراءات المتخذة'),
              const SizedBox(height: 6),
              _buildTextField(
                controller: _actionsController,
                hint: 'اكتب الإجراءات اللي اتعملت...',
                maxLines: 3,
              ),
              const SizedBox(height: 18),

              // Status Dropdown
              _buildLabel('📊 الحالة'),
              const SizedBox(height: 6),
              _buildDropdown<String>(
                value: _selectedStatus,
                items: _statuses.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.white,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  );
                }).toList(),
                hint: 'اختر الحالة',
                onChanged: (val) => setState(() => _selectedStatus = val),
              ),
              const SizedBox(height: 18),

              // Image Picker
              _buildLabel('📷 الصورة'),
              const SizedBox(height: 6),
              _buildImageSection(),
              const SizedBox(height: 28),

              // Generate Report Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final report = _generateReport();
                    showDialog(
                      context: context,
                      builder: (_) => _buildReportDialog(report),
                    );
                  },
                  icon: const Icon(Icons.description, size: 22),
                  label: Text(
                    '📄 توليد التقرير',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkBg,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.cyanGlow,
                    foregroundColor: AppTheme.darkBg,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Share WhatsApp Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _shareWhatsApp,
                  icon: const Icon(Icons.share, size: 22),
                  label: Text(
                    '📱 مشاركة واتساب',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkBg,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: AppTheme.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppTheme.cyanGlow,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontSize: 14,
        color: AppTheme.white,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: AppTheme.grayText,
          fontSize: 13,
        ),
        filled: true,
        fillColor: AppTheme.cardBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.cyanGlow.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.cyanGlow.withOpacity(0.3)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: AppTheme.cyanGlow, width: 2),
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required String hint,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.cyanGlow.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButton<T>(
        value: value,
        isExpanded: true,
        dropdownColor: AppTheme.cardBg,
        icon: const Icon(Icons.arrow_drop_down, color: AppTheme.cyanGlow),
        hint: Text(
          hint,
          style: TextStyle(
            color: AppTheme.grayText,
            fontSize: 14,
          ),
          textDirection: TextDirection.rtl,
        ),
        items: items,
        onChanged: onChanged,
        underline: const SizedBox(),
      ),
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_selectedImage != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              _selectedImage!,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () => setState(() => _selectedImage = null),
            icon: const Icon(Icons.delete, color: AppTheme.fireRed, size: 18),
            label: Text(
              'حذف الصورة',
              style: TextStyle(
                color: AppTheme.fireRed,
                fontSize: 13,
              ),
            ),
          ),
        ] else
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.cyanGlow.withOpacity(0.3),
                  width: 1.5,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.camera_alt,
                      color: AppTheme.cyanGlow, size: 32),
                  const SizedBox(height: 6),
                  Text(
                    '📸 التقط صورة',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.cyanGlow,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildReportDialog(String report) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: AppTheme.cardBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppTheme.cyanGlow, width: 1.5),
        ),
        title: Text(
          '📄 التقرير',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.cyanGlow,
          ),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Text(
            report,
            style: TextStyle(
              fontSize: 13,
              color: AppTheme.white,
              height: 1.6,
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إغلاق',
              style: TextStyle(
                color: AppTheme.grayText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Share.share(report, subject: 'تقرير صيانة');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.cyanGlow,
              foregroundColor: AppTheme.darkBg,
            ),
            child: Text(
              'مشاركة',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.darkBg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
