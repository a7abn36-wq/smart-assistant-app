import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../theme/app_theme.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  bool _isAuthenticated = false;
  final String _correctPin = 'wolf';
  final TextEditingController _pinController = TextEditingController();
  bool _pinError = false;
  String? _selectedCategoryId;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _warningController = TextEditingController();
  final TextEditingController _causeController = TextEditingController();
  final TextEditingController _solutionController = TextEditingController();
  final TextEditingController _keywordsController = TextEditingController();
  String? _selectedSeverity;
  final List<Fault> _newFaults = [];

  @override
  void dispose() {
    _pinController.dispose();
    _titleController.dispose();
    _warningController.dispose();
    _causeController.dispose();
    _solutionController.dispose();
    _keywordsController.dispose();
    super.dispose();
  }

  void _checkPin() {
    if (_pinController.text.trim().toLowerCase() == _correctPin) {
      setState(() { _isAuthenticated = true; _pinError = false; });
    } else {
      setState(() => _pinError = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('كلمة السر غلط!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), backgroundColor: AppTheme.fireRed, duration: Duration(seconds: 2)),
      );
    }
  }

  void _saveFault() {
    if (_selectedCategoryId == null || _titleController.text.trim().isEmpty || _warningController.text.trim().isEmpty || _causeController.text.trim().isEmpty || _solutionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لازم تملا كل الحقول المطلوبة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), backgroundColor: AppTheme.fireRed),
      );
      return;
    }
    final keywordsList = _keywordsController.text.split(',').map((k) => k.trim()).where((k) => k.isNotEmpty).toList();
    setState(() {
      _newFaults.add(Fault(
        id: 'custom-${DateTime.now().millisecondsSinceEpoch}',
        categoryId: _selectedCategoryId!,
        title: _titleController.text.trim(),
        warning: _warningController.text.trim(),
        cause: _causeController.text.trim(),
        solution: _solutionController.text.trim(),
        keywords: keywordsList,
        severity: _selectedSeverity ?? 'warning',
      ));
    });
    _titleController.clear(); _warningController.clear(); _causeController.clear(); _solutionController.clear(); _keywordsController.clear();
    setState(() { _selectedCategoryId = null; _selectedSeverity = null; });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حفظ العطل بنجاح!', style: TextStyle(color: AppTheme.darkBg, fontWeight: FontWeight.bold)), backgroundColor: AppTheme.greenNeon, duration: Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(backgroundColor: AppTheme.darkBg, title: const Text('لوحة التحكم', style: TextStyle(color: AppTheme.cyanGlow, fontWeight: FontWeight.bold)), centerTitle: true, iconTheme: const IconThemeData(color: AppTheme.cyanGlow)),
        body: _isAuthenticated ? _buildForm() : _buildPinEntry(),
      ),
    );
  }

  Widget _buildPinEntry() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.lock, size: 60, color: AppTheme.cyanGlow),
          const SizedBox(height: 16),
          const Text('أدخل كلمة السر', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 24),
          Container(
            width: 250,
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _pinError ? AppTheme.fireRed : AppTheme.cyanGlow.withOpacity(0.4), width: 2),
              boxShadow: [BoxShadow(color: (_pinError ? AppTheme.fireRed : AppTheme.cyanGlow).withOpacity(0.15), blurRadius: 16)],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _pinController,
              obscureText: true,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 22, letterSpacing: 8),
              decoration: const InputDecoration(border: InputBorder.none, hintText: '****', hintStyle: TextStyle(color: AppTheme.grayText, letterSpacing: 12)),
              onSubmitted: (_) => _checkPin(),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(width: 250, height: 50,
            child: ElevatedButton(
              onPressed: _checkPin,
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.cyanGlow, foregroundColor: AppTheme.darkBg, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              child: const Text('دخول', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildForm() {
    final critCount = allFaults.where((f) => f.severity == 'critical').length;
    final warnCount = allFaults.where((f) => f.severity == 'warning').length;
    final infoCount = allFaults.where((f) => f.severity == 'info').length;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Container(padding: const EdgeInsets.all(14), decoration: AppTheme.glowBox(AppTheme.cyanGlow, blur: 14, op: 0.2),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            const Text('إحصائيات المحتوى', style: TextStyle(color: AppTheme.cyanGlow, fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(children: [_statChip('الأعطال', '${allFaults.length}', AppTheme.cyanGlow), const SizedBox(width: 8), _statChip('الشروحات', '${allGuides.length}', AppTheme.greenNeon)]),
            const SizedBox(height: 8),
            Row(children: [_statChip('حرج', '$critCount', AppTheme.fireRed), const SizedBox(width: 8), _statChip('تحذير', '$warnCount', AppTheme.amber), const SizedBox(width: 8), _statChip('معلومة', '$infoCount', AppTheme.infoGreen)]),
          ]),
        ),
        const SizedBox(height: 24), const Divider(color: AppTheme.subtleBorder), const SizedBox(height: 16),
        const Text('إضافة عطل جديد', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.greenNeon)),
        const SizedBox(height: 16),
        _buildLabel('القسم'), const SizedBox(height: 6),
        Container(decoration: BoxDecoration(color: AppTheme.cardBg, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.cyanGlow.withOpacity(0.3))),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButton<String>(value: _selectedCategoryId, isExpanded: true, dropdownColor: AppTheme.cardBg, icon: const Icon(Icons.arrow_drop_down, color: AppTheme.cyanGlow),
            hint: const Text('اختر القسم', style: TextStyle(color: AppTheme.grayText)),
            items: categories.map((cat) => DropdownMenuItem(value: cat.id, child: Text('${cat.icon} ${cat.nameAr}', style: const TextStyle(color: Colors.white)))).toList(),
            onChanged: (val) => setState(() => _selectedCategoryId = val), underline: const SizedBox())),
        const SizedBox(height: 12),
        Row(children: [Expanded(child: _buildLabel('مستوى الخطورة')), Expanded(child: DropdownButton<String>(value: _selectedSeverity, dropdownColor: AppTheme.cardBg,
          hint: const Text('اختر', style: TextStyle(color: AppTheme.grayText, fontSize: 12)),
          items: ['critical', 'warning', 'info'].map((s) => DropdownMenuItem(value: s, child: Text(AppTheme.severityLabel(s), style: TextStyle(color: AppTheme.severityColor(s), fontSize: 12)))).toList(),
          onChanged: (val) => setState(() => _selectedSeverity = val), underline: const SizedBox(), isExpanded: true))]),
        const SizedBox(height: 12), _buildLabel('عنوان العطل'), const SizedBox(height: 6), _buildFormField(controller: _titleController, hint: 'مثال: الشيلر بيقف وبيطلع HP Lockout'),
        const SizedBox(height: 12), _buildLabel('التحذير'), const SizedBox(height: 6), _buildFormField(controller: _warningController, hint: 'اكتب التحذير...', maxLines: 3),
        const SizedBox(height: 12), _buildLabel('السبب'), const SizedBox(height: 6), _buildFormField(controller: _causeController, hint: 'اكتب السبب المحتمل...', maxLines: 3),
        const SizedBox(height: 12), _buildLabel('الحل (كل خطوة في سطر)'), const SizedBox(height: 6), _buildFormField(controller: _solutionController, hint: 'اكتب خطوات الحل...', maxLines: 5),
        const SizedBox(height: 12), _buildLabel('كلمات مفتاحية'), const SizedBox(height: 6), _buildFormField(controller: _keywordsController, hint: 'كلمة1, كلمة2, keyword1'),
        const SizedBox(height: 20),
        SizedBox(width: double.infinity, child: ElevatedButton.icon(
          onPressed: _saveFault,
          icon: const Icon(Icons.save, size: 22),
          label: const Text('حفظ العطل', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.darkBg)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.greenNeon,
            foregroundColor: AppTheme.darkBg,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        )),
        if (_newFaults.isNotEmpty) ...[
          const SizedBox(height: 16),
          Container(width: double.infinity, padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppTheme.cardBg, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.greenNeon.withOpacity(0.3))),
            child: Row(children: [const Icon(Icons.check_circle, color: AppTheme.greenNeon, size: 20), const SizedBox(width: 8), Text('تم إضافة ${_newFaults.length} عطل جديد', style: const TextStyle(color: AppTheme.greenNeon, fontSize: 13))])),
        ],
        const SizedBox(height: 24),
      ]),
    );
  }

  Widget _statChip(String label, String value, Color c) => Expanded(
    child: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: c.withOpacity(0.3))),
      child: Column(children: [Text(value, style: TextStyle(color: c, fontSize: 20, fontWeight: FontWeight.bold)), Text(label, style: const TextStyle(color: AppTheme.ice, fontSize: 11))])),
  );

  Widget _buildLabel(String text) => Text(text, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.cyanGlow));

  Widget _buildFormField({required TextEditingController controller, required String hint, int maxLines = 1}) => TextField(
    controller: controller, maxLines: maxLines, textDirection: TextDirection.rtl, style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(color: AppTheme.grayText, fontSize: 13), filled: true, fillColor: AppTheme.cardBg,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.cyanGlow.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppTheme.cyanGlow.withOpacity(0.3))),
      focusedBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: AppTheme.cyanGlow, width: 2))),
  );
}
