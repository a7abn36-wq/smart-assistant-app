// ═══════════════════════════════════════════════════════════════════════════════
// المساعد الذكي - Nameplate Scanner | مسح لوحة بيانات المعدات
// بيسمح للمستخدم يصور لوحة البيانات ويسجل المواصفات يدوياً
// كل المصطلحات التقنية مكتوب معناها بالعامية المصرية جمبها
// ═══════════════════════════════════════════════════════════════════════════════

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../theme/app_theme.dart';

/// نموذج لوحة البيانات المحفوظة
class SavedNameplate {
  final String id;
  final String equipmentName;
  final String brand;
  final String model;
  final String serialNo;
  final Map<String, String> specs;
  final String? imagePath;
  final DateTime savedAt;

  const SavedNameplate({
    required this.id,
    required this.equipmentName,
    required this.brand,
    required this.model,
    required this.serialNo,
    required this.specs,
    this.imagePath,
    required this.savedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'equipmentName': equipmentName,
    'brand': brand,
    'model': model,
    'serialNo': serialNo,
    'specs': specs,
    'imagePath': imagePath,
    'savedAt': savedAt.toIso8601String(),
  };

  factory SavedNameplate.fromJson(Map<String, dynamic> json) => SavedNameplate(
    id: json['id'],
    equipmentName: json['equipmentName'],
    brand: json['brand'],
    model: json['model'],
    serialNo: json['serialNo'],
    specs: Map<String, String>.from(json['specs']),
    imagePath: json['imagePath'],
    savedAt: DateTime.parse(json['savedAt']),
  );
}

class NameplateScannerScreen extends StatefulWidget {
  const NameplateScannerScreen({super.key});

  @override
  State<NameplateScannerScreen> createState() => _NameplateScannerScreenState();
}

class _NameplateScannerScreenState extends State<NameplateScannerScreen> {
  File? _selectedImage;
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _serialController = TextEditingController();

  // حقول المواصفات التقنية
  final _voltageController = TextEditingController();
  final _currentController = TextEditingController();
  final _powerController = TextEditingController();
  final _rpmController = TextEditingController();
  final _frequencyController = TextEditingController();
  final _refrigerantController = TextEditingController();
  final _madeInController = TextEditingController();
  final _mfgDateController = TextEditingController();
  final _customKeyController = TextEditingController();
  final _customValueController = TextEditingController();

  Map<String, String> _customSpecs = {};
  List<SavedNameplate> _savedNameplates = [];
  bool _showForm = false;
  bool _showSaved = false;

  @override
  void initState() {
    super.initState();
    _loadSavedNameplates();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _serialController.dispose();
    _voltageController.dispose();
    _currentController.dispose();
    _powerController.dispose();
    _rpmController.dispose();
    _frequencyController.dispose();
    _refrigerantController.dispose();
    _madeInController.dispose();
    _mfgDateController.dispose();
    _customKeyController.dispose();
    _customValueController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedNameplates() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getStringList('saved_nameplates') ?? [];
      setState(() {
        _savedNameplates = saved.map((s) => SavedNameplate.fromJson(jsonDecode(s))).toList();
      });
    } catch (_) {}
  }

  Future<void> _saveNameplates() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = _savedNameplates.map((n) => jsonEncode(n.toJson())).toList();
      await prefs.setStringList('saved_nameplates', encoded);
    } catch (_) {}
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 85,
    );
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
        _showForm = true;
      });
    }
  }

  Future<void> _pickFromGallery() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 85,
    );
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
        _showForm = true;
      });
    }
  }

  void _addCustomSpec() {
    final key = _customKeyController.text.trim();
    final value = _customValueController.text.trim();
    if (key.isNotEmpty && value.isNotEmpty) {
      setState(() {
        _customSpecs[key] = value;
        _customKeyController.clear();
        _customValueController.clear();
      });
    }
  }

  void _saveNameplate() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لازم تكتب اسم المعدة!', textDirection: TextDirection.rtl)),
      );
      return;
    }

    final allSpecs = <String, String>{};

    if (_voltageController.text.isNotEmpty)
      allSpecs['الجهد (Voltage - الفولت)'] = _voltageController.text;
    if (_currentController.text.isNotEmpty)
      allSpecs['التيار (Current - الأمبير)'] = _currentController.text;
    if (_powerController.text.isNotEmpty)
      allSpecs['القدرة (Power - كيلو وات)'] = _powerController.text;
    if (_rpmController.text.isNotEmpty)
      allSpecs['سرعة الدوران (RPM - لفات/د)'] = _rpmController.text;
    if (_frequencyController.text.isNotEmpty)
      allSpecs['التردد (Frequency - هيرتز)'] = _frequencyController.text;
    if (_refrigerantController.text.isNotEmpty)
      allSpecs['غاز التبريد (Refrigerant - الفريون)'] = _refrigerantController.text;
    if (_madeInController.text.isNotEmpty)
      allSpecs['بلد التصنيع (Made In)'] = _madeInController.text;
    if (_mfgDateController.text.isNotEmpty)
      allSpecs['تاريخ التصنيع (Mfg Date)'] = _mfgDateController.text;

    allSpecs.addAll(_customSpecs);

    final nameplate = SavedNameplate(
      id: 'np-${DateTime.now().millisecondsSinceEpoch}',
      equipmentName: name,
      brand: _brandController.text.trim(),
      model: _modelController.text.trim(),
      serialNo: _serialController.text.trim(),
      specs: allSpecs,
      imagePath: _selectedImage?.path,
      savedAt: DateTime.now(),
    );

    setState(() {
      _savedNameplates.insert(0, nameplate);
      _showForm = false;
      _selectedImage = null;
      _nameController.clear();
      _brandController.clear();
      _modelController.clear();
      _serialController.clear();
      _voltageController.clear();
      _currentController.clear();
      _powerController.clear();
      _rpmController.clear();
      _frequencyController.clear();
      _refrigerantController.clear();
      _madeInController.clear();
      _mfgDateController.clear();
      _customSpecs = {};
    });
    _saveNameplates();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم حفظ لوحة البيانات بنجاح!', textDirection: TextDirection.rtl),
        backgroundColor: AppTheme.greenNeon,
      ),
    );
  }

  void _deleteNameplate(int index) {
    setState(() => _savedNameplates.removeAt(index));
    _saveNameplates();
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
            'مسح لوحة البيانات (Nameplate Scanner)',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppTheme.amber,
              shadows: [Shadow(color: AppTheme.amber, blurRadius: 8)],
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppTheme.cyanGlow),
          actions: [
            IconButton(
              icon: Icon(Icons.history, color: _savedNameplates.isNotEmpty ? AppTheme.greenNeon : AppTheme.grayText),
              tooltip: 'اللوحات المحفوظة',
              onPressed: () => setState(() => _showSaved = !_showSaved),
            ),
          ],
        ),
        body: _showSaved ? _buildSavedList() : _buildScannerView(),
      ),
    );
  }

  Widget _buildScannerView() {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // ── تعليمات ──
        Container(
          padding: const EdgeInsets.all(14),
          decoration: AppTheme.glowBox(AppTheme.amber, blur: 14, op: 0.25),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline, color: AppTheme.amber, size: 20),
                  SizedBox(width: 8),
                  Text('إزاي تستخدم الميزة دي؟', style: TextStyle(color: AppTheme.amber, fontWeight: FontWeight.bold, fontSize: 15)),
                ],
              ),
              SizedBox(height: 8),
              Text('١. صور لوحة البيانات (Nameplate - لوحة المعدة المكتوب عليها المواصفات)', style: TextStyle(color: Colors.white70, fontSize: 13), textDirection: TextDirection.rtl),
              Text('٢. سجل المواصفات اللي على اللوحة في الفورم تحت', style: TextStyle(color: Colors.white70, fontSize: 13), textDirection: TextDirection.rtl),
              Text('٣. احفظ البيانات — هتلاقيها في قسم "اللوحات المحفوظة"', style: TextStyle(color: Colors.white70, fontSize: 13), textDirection: TextDirection.rtl),
              SizedBox(height: 6),
              Text('نصيحة: صور اللوحة بصورة واضحة عشان لو حبيت ترجع تشوفها تاني', style: TextStyle(color: AppTheme.ice, fontSize: 12, fontStyle: FontStyle.italic), textDirection: TextDirection.rtl),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── أزرار التصوير ──
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.camera_alt, size: 20),
                label: const Text('صور بالكاميرا'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.cyanGlow,
                  foregroundColor: AppTheme.darkBg,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _pickFromGallery,
                icon: const Icon(Icons.photo_library, size: 20),
                label: const Text('اختار من الجاليري'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.greenNeon,
                  foregroundColor: AppTheme.darkBg,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ── صورة اللوحة ──
        if (_selectedImage != null) ...[
          Container(
            decoration: AppTheme.glowBox(AppTheme.amber, blur: 10, op: 0.2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(_selectedImage!, fit: BoxFit.contain, height: 250, width: double.infinity),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // ── فورم الإدخال ──
        Container(
          padding: const EdgeInsets.all(14),
          decoration: AppTheme.glowBox(AppTheme.cyanGlow, blur: 10, op: 0.15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'سجل بيانات لوحة المعدة',
                style: TextStyle(color: AppTheme.cyanGlow, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              _buildField(_nameController, 'اسم المعدة *', 'مثال: الشيلر الرئيسي / مضخة برايمري 1'),
              _buildField(_brandController, 'الماركة (Brand)', 'مثال: Trane / B&G / FELM'),
              _buildField(_modelController, 'الموديل (Model)', 'مثال: CVHF1300 / GLC 200-320'),
              _buildField(_serialController, 'الرقم التسلسلي (Serial No)', 'مثال: CZ24003145'),

              const Divider(color: AppTheme.subtleBorder, height: 24),
              const Text('المواصفات التقنية', style: TextStyle(color: AppTheme.ice, fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),

              _buildField(_powerController, 'القدرة (Power - كيلو وات)', 'مثال: 729 kW'),
              _buildField(_voltageController, 'الجهد (Voltage - الفولت)', 'مثال: 380V / 3Ph'),
              _buildField(_currentController, 'التيار (Current - الأمبير)', 'مثال: 1161A'),
              _buildField(_rpmController, 'سرعة الدوران (RPM)', 'مثال: 1480 RPM'),
              _buildField(_frequencyController, 'التردد (Frequency - هيرتز)', 'مثال: 50 Hz'),
              _buildField(_refrigerantController, 'غاز التبريد (Refrigerant - الفريون)', 'مثال: HFO-514A'),
              _buildField(_madeInController, 'بلد التصنيع (Made In)', 'مثال: إيطاليا'),
              _buildField(_mfgDateController, 'تاريخ التصنيع (Mfg Date)', 'مثال: 2024'),

              const Divider(color: AppTheme.subtleBorder, height: 24),
              const Text('مواصفات إضافية (Custom Specs)', style: TextStyle(color: AppTheme.ice, fontSize: 13)),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(child: _buildField(_customKeyController, 'اسم المواصفة', 'مثال: IP Rating')),
                  const SizedBox(width: 8),
                  Expanded(child: _buildField(_customValueController, 'القيمة', 'مثال: IP55')),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: AppTheme.greenNeon),
                    onPressed: _addCustomSpec,
                  ),
                ],
              ),
              if (_customSpecs.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: _customSpecs.entries.map((e) => Chip(
                    label: Text('${e.key}: ${e.value}', style: const TextStyle(fontSize: 11)),
                    backgroundColor: AppTheme.greenNeon.withOpacity(0.15),
                    side: BorderSide(color: AppTheme.greenNeon.withOpacity(0.3)),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () => setState(() => _customSpecs.remove(e.key)),
                  )).toList(),
                ),
              ],

              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveNameplate,
                  icon: const Icon(Icons.save, size: 20),
                  label: const Text('احفظ لوحة البيانات', style: TextStyle(fontSize: 15)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.greenNeon,
                    foregroundColor: AppTheme.darkBg,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildField(TextEditingController controller, String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppTheme.ice, fontSize: 12),
          hintText: hint,
          hintStyle: const TextStyle(color: AppTheme.grayText, fontSize: 11),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppTheme.cyanGlow.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppTheme.subtleBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppTheme.cyanGlow),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
    );
  }

  Widget _buildSavedList() {
    if (_savedNameplates.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.save_alt, size: 48, color: AppTheme.grayText.withOpacity(0.5)),
            const SizedBox(height: 12),
            const Text('مفيش لوحات بيانات محفوظة لسه', style: TextStyle(color: AppTheme.grayText, fontSize: 16)),
            const SizedBox(height: 6),
            const Text('صور لوحة بيانات واحفظها!', style: TextStyle(color: AppTheme.ice, fontSize: 13)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _savedNameplates.length,
      itemBuilder: (context, index) {
        final np = _savedNameplates[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            decoration: AppTheme.glowBox(AppTheme.amber, blur: 10, op: 0.2),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              iconColor: AppTheme.amber,
              collapsedIconColor: AppTheme.ice,
              title: Text(np.equipmentName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text('${np.brand} ${np.model}'.trim(), style: const TextStyle(color: AppTheme.ice, fontSize: 12)),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: AppTheme.fireRed, size: 18),
                onPressed: () => _deleteNameplate(index),
              ),
              children: [
                if (np.imagePath != null)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(File(np.imagePath!), fit: BoxFit.contain, height: 200),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (np.serialNo.isNotEmpty)
                        Text('الرقم التسلسلي: ${np.serialNo}', style: const TextStyle(color: AppTheme.ice, fontSize: 12)),
                      const SizedBox(height: 8),
                      for (final entry in np.specs.entries) ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${entry.key}: ', style: const TextStyle(color: AppTheme.cyanGlow, fontSize: 12, fontWeight: FontWeight.w600)),
                            Expanded(child: Text(entry.value, style: const TextStyle(color: Colors.white70, fontSize: 12))),
                          ],
                        ),
                        const SizedBox(height: 2),
                      ],
                      const SizedBox(height: 4),
                      Text('محفوظ: ${_formatDate(np.savedAt)}', style: const TextStyle(color: AppTheme.grayText, fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
