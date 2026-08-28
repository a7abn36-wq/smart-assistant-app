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
  final String _correctPin = '1234';
  final List<String> _enteredPin = [];

  // Form controllers
  String? _selectedCategoryId;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _warningController = TextEditingController();
  final TextEditingController _causeController = TextEditingController();
  final TextEditingController _solutionController = TextEditingController();
  final TextEditingController _keywordsController = TextEditingController();

  // In-memory list for new faults
  final List<Fault> _newFaults = [];

  @override
  void dispose() {
    _titleController.dispose();
    _warningController.dispose();
    _causeController.dispose();
    _solutionController.dispose();
    _keywordsController.dispose();
    super.dispose();
  }

  void _onPinDigit(String digit) {
    if (_enteredPin.length >= 4) return;
    setState(() {
      _enteredPin.add(digit);
    });
    if (_enteredPin.length == 4) {
      _checkPin();
    }
  }

  void _deletePinDigit() {
    if (_enteredPin.isNotEmpty) {
      setState(() {
        _enteredPin.removeLast();
      });
    }
  }

  void _checkPin() {
    final entered = _enteredPin.join();
    if (entered == _correctPin) {
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _isAuthenticated = true;
        });
      });
    } else {
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _enteredPin.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '❌ رقم PIN غلط!',
              style: TextStyle(
                color: AppTheme.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: AppTheme.fireRed,
            duration: const Duration(seconds: 2),
          ),
        );
      });
    }
  }

  void _saveFault() {
    if (_selectedCategoryId == null ||
        _titleController.text.trim().isEmpty ||
        _warningController.text.trim().isEmpty ||
        _causeController.text.trim().isEmpty ||
        _solutionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '⚠️ لازم تملا كل الحقول المطلوبة',
            style: TextStyle(
              color: AppTheme.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppTheme.fireRed,
        ),
      );
      return;
    }

    final keywordsList = _keywordsController.text
        .split(',')
        .map((k) => k.trim())
        .where((k) => k.isNotEmpty)
        .toList();

    final newFault = Fault(
      id: 'custom-${DateTime.now().millisecondsSinceEpoch}',
      categoryId: _selectedCategoryId!,
      title: _titleController.text.trim(),
      warning: _warningController.text.trim(),
      cause: _causeController.text.trim(),
      solution: _solutionController.text.trim(),
      keywords: keywordsList,
    );

    setState(() {
      _newFaults.add(newFault);
    });

    // Clear form
    _titleController.clear();
    _warningController.clear();
    _causeController.clear();
    _solutionController.clear();
    _keywordsController.clear();
    setState(() {
      _selectedCategoryId = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '✅ تم حفظ العطل بنجاح!',
          style: TextStyle(
            color: AppTheme.darkBg,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppTheme.greenNeon,
        duration: const Duration(seconds: 2),
      ),
    );
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
            '👑 إضافة محتوى',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.cyanGlow,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppTheme.cyanGlow),
        ),
        body: _isAuthenticated ? _buildForm() : _buildPinEntry(),
      ),
    );
  }

  // ─── PIN Entry Screen ───
  Widget _buildPinEntry() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock, size: 60, color: AppTheme.cyanGlow),
            const SizedBox(height: 16),
            Text(
              'أدخل رقم PIN',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.white,
              ),
            ),
            const SizedBox(height: 24),
            // PIN dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final filled = index < _enteredPin.length;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: filled ? AppTheme.cyanGlow : AppTheme.cardBg,
                    border: Border.all(
                      color: filled
                          ? AppTheme.cyanGlow
                          : AppTheme.cyanGlow.withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: filled
                        ? [
                            BoxShadow(
                              color: AppTheme.cyanGlow.withOpacity(0.4),
                              blurRadius: 12,
                            ),
                          ]
                        : null,
                  ),
                  child: filled
                      ? const Icon(Icons.circle,
                          color: AppTheme.darkBg, size: 16)
                      : null,
                );
              }),
            ),
            const SizedBox(height: 36),
            // Numpad
            ...List.generate(3, (row) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (col) {
                    final num = row * 3 + col + 1;
                    return _buildPinButton(num.toString());
                  }),
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Empty space
                  const SizedBox(width: 80, height: 60),
                  const SizedBox(width: 10),
                  _buildPinButton('0'),
                  const SizedBox(width: 10),
                  // Delete button
                  SizedBox(
                    width: 80,
                    height: 60,
                    child: IconButton(
                      onPressed: _deletePinDigit,
                      icon: const Icon(Icons.backspace,
                          color: AppTheme.fireRed, size: 28),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinButton(String digit) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        width: 80,
        height: 60,
        child: ElevatedButton(
          onPressed: () => _onPinDigit(digit),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.cardBg,
            foregroundColor: AppTheme.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: AppTheme.cyanGlow.withOpacity(0.3)),
            ),
          ),
          child: Text(
            digit,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.white,
            ),
          ),
        ),
      ),
    );
  }

  // ─── Add Fault Form ───
  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Category Dropdown
          _buildLabel('📁 القسم'),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.cyanGlow.withOpacity(0.3)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButton<String>(
              value: _selectedCategoryId,
              isExpanded: true,
              dropdownColor: AppTheme.cardBg,
              icon: const Icon(Icons.arrow_drop_down, color: AppTheme.cyanGlow),
              hint: Text(
                'اختر القسم',
                style: TextStyle(
                  color: AppTheme.grayText,
                  fontSize: 14,
                ),
                textDirection: TextDirection.rtl,
              ),
              items: categories.map((cat) {
                return DropdownMenuItem(
                  value: cat.id,
                  child: Text(
                    '${cat.icon} ${cat.nameAr}',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.white,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                );
              }).toList(),
              onChanged: (val) => setState(() => _selectedCategoryId = val),
              underline: const SizedBox(),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          _buildLabel('📝 عنوان العطل'),
          const SizedBox(height: 6),
          _buildFormField(controller: _titleController, hint: 'مثال: الشيلر بيقف وبيطلع HP Lockout'),
          const SizedBox(height: 16),

          // Warning
          _buildLabel('⚠️ التحذير'),
          const SizedBox(height: 6),
          _buildFormField(
            controller: _warningController,
            hint: 'اكتب التحذير للفني...',
            maxLines: 3,
          ),
          const SizedBox(height: 16),

          // Cause
          _buildLabel('🔍 السبب'),
          const SizedBox(height: 6),
          _buildFormField(
            controller: _causeController,
            hint: 'اكتب السبب المحتمل...',
            maxLines: 3,
          ),
          const SizedBox(height: 16),

          // Solution
          _buildLabel('✅ الحل'),
          const SizedBox(height: 6),
          _buildFormField(
            controller: _solutionController,
            hint: 'اكتب خطوات الحل (كل خطوة في سطر)...',
            maxLines: 5,
          ),
          const SizedBox(height: 16),

          // Keywords
          _buildLabel('🏷️ كلمات مفتاحية'),
          const SizedBox(height: 6),
          _buildFormField(
            controller: _keywordsController,
            hint: 'كلمة1، كلمة2، keyword1، keyword2',
          ),
          const SizedBox(height: 24),

          // Save Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _saveFault,
              icon: const Icon(Icons.save, size: 22),
              label: Text(
                '💾 حفظ العطل',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkBg,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.greenNeon,
                foregroundColor: AppTheme.darkBg,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Show count of added faults
          if (_newFaults.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.greenNeon.withOpacity(0.3)),
              ),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  const Icon(Icons.check_circle,
                      color: AppTheme.greenNeon, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'تم إضافة ${_newFaults.length} عطل جديد في هذه الجلسة',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.greenNeon,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 24),
        ],
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

  Widget _buildFormField({
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
}