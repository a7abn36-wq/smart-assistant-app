// ═══════════════════════════════════════════════════════════════════════════════
// المساعد الذكي - Equipment Inventory | بيانات معدات المحطة الحقيقية
// كل المصطلحات التقنية مكتوب معناها بالعامية المصرية جمبها
// ═══════════════════════════════════════════════════════════════════════════════

// ───────────────────────────────────────────────────────────────────────────────
// Equipment Item — وحدة معدات واحدة في المحطة
// ───────────────────────────────────────────────────────────────────────────────

class EquipmentItem {
  final String id;
  final String nameAr;         // اسم المعدة بالعربي
  final String nameEn;         // اسم المعدة بالإنجليزي
  final String category;       // الفئة (شيلر/بامب/موتور...)
  final String brand;          // الماركة (Trane/B&G/FELM...)
  final String model;          // الموديل
  final String serialNo;       // الرقم التسلسلي
  final String madeIn;         // بلد التصنيع
  final String mfgDate;        // تاريخ التصنيع
  final String location;       // المكان في المحطة
  final String status;         // الحالة (شغال/واقف/تحت صيانة)
  final Map<String, String> specs;  // المواصفات التقنية
  final String notes;          // ملاحظات بالعامية
  final String icon;           // أيقونة
  final int color;             // لون

  const EquipmentItem({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.category,
    required this.brand,
    required this.model,
    required this.serialNo,
    required this.madeIn,
    required this.mfgDate,
    required this.location,
    required this.status,
    required this.specs,
    required this.notes,
    required this.icon,
    required this.color,
  });
}

// ═══════════════════════════════════════════════════════════════════════════════
// المعدات الحقيقية بتاعة المحطة
// ═══════════════════════════════════════════════════════════════════════════════

List<EquipmentItem> plantEquipment = [

  // ═══════════════════════════════════════════════════════════════════════════
  // الشيلر الرئيسي — TRANE CenTraVac CVHF1300
  // ═══════════════════════════════════════════════════════════════════════════
  EquipmentItem(
    id: "chiller-01",
    nameAr: "الشيلر الرئيسي - ترين سنترا فاك",
    nameEn: "Main Chiller - Trane CenTraVac",
    category: "شيلرات",
    brand: "Trane (ترين - شركة أمريكية)",
    model: "CVHF1300",
    serialNo: "CZ24003145",
    madeIn: "الصين (China)",
    mfgDate: "أغسطس 2024",
    location: "غرفة الشيلرات - المحطة الرئيسية",
    status: "شغال",
    icon: "❄️",
    color: 0xFF00E5FF,
    specs: {
      // القدرة والكهرباء
      "القدرة التبريدية (Cooling Capacity - يعني قوة التبريد)": "729 kW (كيلو وات) ≈ 207 Ton (طن تبريد)",
      "جهد التشغيل (Voltage - الفولت)": "380V (فولت) - 3 Phase (ثلاثي الأطوار)",
      "التردد (Frequency - هيرتز)": "50 Hz (هيرتز)",
      "تيار التشغيل (Current - الأمبير)": "1161A (أمبير) - ده تيار عالي أوي!",
      "أقصى فيوز (Max Fuse - الحماية)": "2500A (أمبير)",
      "القدرة الكهربائية (Nameplate kW - الكيلو وات)": "729 kW",

      // الفريون والضغط
      "غاز التبريد (Refrigerant - الفريون)": "HFO-514A (صديق للبيئة - بديل R-123 القديم)",
      "شحن المصنع (Factory Charge - كمية الفريون)": "1500 lbs (رطل) ≈ 680 kg",
      "ضغط العمل الأقصى (Max Working Pressure - High Side)": "15 PSIG (باوند لكل بوصة مربعة)",
      "ضغط الاختبار (Test Pressure)": "45.0 PSI",

      // الكمبريسور
      "نوع الكمبريسور (Compressor Type - الضاغط)": "Centrifugal (سنتروبيفوجل - طرد مركزي)",
      "تيار البدء (LRA - Locked Rotor Amps)": "1233A (أمبير - تيار البدء لما الموتور بيدور)",
      "سخان الزيت (Oil Heater - بيسخن الزيت قبل التشغيل)": "115V / 750W",

      // التحكم
      "نظام التحكم (Controller - الدماغ بتاع الشيلر)": "Tracer CH530 (شاشة تحكم ترين)",
      "مضخة الزيت (Oil Pump - بتصرف الزيت للكمبريسور)": "115V / 1.7A",
    },
    notes: "⚠️ الشيلر ده سنتروبيفوجل (Centrifugal) يعني بيتحكم فيه بـ Inlet Guide Vanes (ريش مدخل) وبيعمل Surge (سيرج - تذبذب) لو الحمل قل. لازم تنتبه للـ CH530 Controller (شاشة التحكم) لو طلعت Error Code (كود خطأ) تراجع الـ Service Manual (كتيب الصيانة). الفريون HFO-514A (إتش إف أو 514 إيه) ده غاز جديد وصديق للبيئة - ممنوع تخلطه بـ R-123 (آر 123) القديم خالص!",
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // مضخة برايمري 1 — Bell & Gossett GLC 200-320
  // ═══════════════════════════════════════════════════════════════════════════
  EquipmentItem(
    id: "pump-primary-01",
    nameAr: "مضخة برايمري 1 - بيل آند جوسيت",
    nameEn: "Primary Pump 1 - Bell & Gossett GLC",
    category: "مضخات برايمري",
    brand: "Bell & Gossett / Xylem (بيل آند جوسيت - أمريكية)",
    model: "GLC 200-320 45kW/4P",
    serialNo: "—",
    madeIn: "الإمارات (UAE)",
    mfgDate: "—",
    location: "غرفة المضخات - خط مية الشيلد CHW",
    status: "شغال",
    icon: "💧",
    color: 0xFF448AFF,
    specs: {
      "القدرة (Power - الكيلو وات)": "45 kW (كيلو وات) ≈ 60 HP (حصان)",
      "التدفق (Flow Rate - كمية الميه)": "1800 GPM (جالون في الدقيقة) ≈ 409 m³/h",
      "الرأس (TDH - Total Dynamic Head - الرفع)": "80 FT (قدم) ≈ 24.4m",
      "سرعة الدوران (RPM - لفات في الدقيقة)": "1480 RPM",
      "أقصى ضغط (Max W.P - أقصى ضغط تشغيلي)": "1.6 MPa (ميجا باسكال) ≈ 16 بار",
      "قطر المروحة (Impeller Dia - العجلة جوا المضخة)": "11.97 بوصة",
      "أقصى قطر مروحة (Max Impeller Dia)": "13.15 بوصة",
      "خامة الجسم (Material - من إيه عاملها)": "CI/BR/SS (حديد زهر/برونز/ستنلس ستيل)",
      "الوزن (Weight)": "610 kg (كيلوجرام)",
      "عدد الأقطاب (Poles - أقطاب الموتور)": "4P (أربع أقطاب)",
    },
    notes: "🔴 تحذير مهم: متشغلش المضخة والـ Discharge Valve (صمام الخروج) مقفول! ده Dead Head (ضغط ميت) وهيسخن الميه جواها ويعمل Steam Pocket (جيب بخار) وينفجر الـ Mechanical Seal (السيل الميكانيكي)! المضخة دي بندارية (Centrifugal - طرد مركزي) وبتستخدم لدوران مية التبريد (CHW - Chilled Water) من الشيلر للـ AHUs (وحادات معالجة الهواء).",
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // مضخة برايمري 2 — Bell & Gossett e-1510 (الأكبر)
  // ═══════════════════════════════════════════════════════════════════════════
  EquipmentItem(
    id: "pump-primary-02",
    nameAr: "مضخة برايمري 2 - بيل آند جوسيت الكبيرة",
    nameEn: "Primary Pump 2 - Bell & Gossett e-1510",
    category: "مضخات برايمري",
    brand: "Bell & Gossett / Xylem (بيل آند جوسيت - أمريكية)",
    model: "e-1510 350-410",
    serialNo: "005358-01-01",
    madeIn: "الإمارات (UAE)",
    mfgDate: "—",
    location: "غرفة المضخات - خط مية الشيلد CHW",
    status: "شغال",
    icon: "💧",
    color: 0xFF448AFF,
    specs: {
      "القدرة (Power - الكيلو وات)": "132 kW (كيلو وات) ≈ 177 HP (حصان)",
      "التدفق (Flow Rate - كمية الميه)": "3000 GPM (جالون في الدقيقة) ≈ 681 m³/h",
      "الرأس (TDH - Total Dynamic Head - الرفع)": "130 FT (قدم) ≈ 39.6m",
      "سرعة الدوران (RPM - لفات في الدقيقة)": "1490 RPM",
      "أقصى ضغط (Max W.P - أقصى ضغط تشغيلي)": "1.6 MPa (ميجا باسكال) ≈ 16 بار",
      "قطر المروحة (Impeller Dia - العجلة جوا المضخة)": "14.73 بوصة",
      "أقصى قطر مروحة (Max Impeller Dia)": "16.102 بوصة",
      "الوزن (Weight)": "1575 kg (كيلوجرام) ≈ 1.6 طن!",
      "رقم الجزء (Part Number)": "DCAAPM0040463",
    },
    notes: "🔴 دي المضخة الكبيرة في المحطة! 132kW و 3000 GPM (3000 جالون في الدقيقة) - دي بتدفع ميه كتير أوي. لازم تتأكد إن الـ Strainer (الفلتر على الساكشن) نظيف كل أسبوع عشان الـ GPM العالي ده بيخلي أي حاجة جوا الـ Strainer تقف سريع. نفس التحذير: متشغلش والـ Valve مقفول!",
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // محرك المضخة الصغيرة — FELM 45kW
  // ═══════════════════════════════════════════════════════════════════════════
  EquipmentItem(
    id: "motor-01",
    nameAr: "محرك المضخة الصغيرة - في إل إم",
    nameEn: "Pump Motor 45kW - FELM",
    category: "محركات",
    brand: "FELM Srl (في إل إم - إيطالية)",
    model: "F3-225M-4 TEFC",
    serialNo: "—",
    madeIn: "إيطاليا (Italy)",
    mfgDate: "2024",
    location: "غرفة المضخات - على المضخة البرايمري الصغيرة",
    status: "شغال",
    icon: "⚡",
    color: 0xFFFFAB00,
    specs: {
      "القدرة (Power - الكيلو وات)": "45 kW (كيلو وات) ≈ 60 HP (حصان)",
      "الجهد (Voltage - الفولت)": "400V (دلتا Δ) / 690V (ستار Y)",
      "التيار (Current - الأمبير)": "80.2A (عند 400V) / 46.5A (عند 690V)",
      "التردد (Frequency - هيرتز)": "50 Hz (هيرتز)",
      "سرعة الدوران (RPM - لفات في الدقيقة)": "1475 RPM",
      "معامل القدرة (Cos φ - باور فاكتور)": "0.85",
      "الكفاءة (Efficiency - كفاءة الموتور)": "94.2% (IE3 - كفاءة عالية)",
      "درجة الحماية (IP - الحماية من الغبار والميه)": "IP55 (محمي من الرشاشات)",
      "فئة العزل (Insulation Class - العزل)": "F (يتحمل لحد 155°C)",
      "نوع التبريد (Cooling - تبريد الموتور)": "TEFC (مغلق بالكامل ومبرد بمروحة خارجية)",
      "الوزن (Weight)": "326 kg (كيلوجرام)",
      "حجم الإطار (Frame Size - حجم الموتور)": "225M",
      "عدد الأقطاب (Poles)": "4 (أربع أقطاب)",
    },
    notes: "الموتور ده IE3 (كفاءة عالية - Premium Efficiency) يعني بيوفر في الكهرباء. IP55 (آي بي 55) معناه محمي من الغبار والرشاشات المائية بس مش من الغمر في الميه. لما تقس الأمبير بـ Clamp Meter (أمبير كلامب) لازم تلاقيه حوالي 80A عند الحمل الكامل. لو لقيته أعلى من 85A يبقى في Overload (حمل زايد).",
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // محرك المضخة الكبيرة — FELM 132kW
  // ═══════════════════════════════════════════════════════════════════════════
  EquipmentItem(
    id: "motor-02",
    nameAr: "محرك المضخة الكبيرة - في إل إم",
    nameEn: "Pump Motor 132kW - FELM",
    category: "محركات",
    brand: "FELM Srl (في إل إم - إيطالية)",
    model: "F3-315M-4 TEFC",
    serialNo: "24301450110717/YR2024",
    madeIn: "إيطاليا (Italy)",
    mfgDate: "2024",
    location: "غرفة المضخات - على المضخة البرايمري الكبيرة",
    status: "شغال",
    icon: "⚡",
    color: 0xFFFFAB00,
    specs: {
      "القدرة (Power - الكيلو وات)": "132 kW (كيلو وات) ≈ 177 HP (حصان)",
      "الجهد (Voltage - الفولت)": "400V (دلتا Δ) / 690V (ستار Y)",
      "التيار (Current - الأمبير)": "223.9A (عند 400V) / 129.8A (عند 690V)",
      "التردد (Frequency - هيرتز)": "50 Hz (هيرتز)",
      "سرعة الدوران (RPM - لفات في الدقيقة)": "1480 RPM",
      "معامل القدرة (Cos φ - باور فاكتور)": "0.89",
      "الكفاءة (Efficiency - كفاءة الموتور)": "95.6% (IE3 - كفاءة عالية جداً)",
      "درجة الحماية (IP - الحماية من الغبار والميه)": "IP55 (محمي من الرشاشات)",
      "فئة العزل (Insulation Class - العزل)": "F (يتحمل لحد 155°C)",
      "نوع التبريد (Cooling - تبريد الموتور)": "TEFC (مغلق بالكامل ومبرد بمروحة خارجية)",
      "الوزن (Weight)": "1000 kg (كيلوجرام) ≈ 1 طن!",
      "حجم الإطار (Frame Size - حجم الموتور)": "315M",
      "عدد الأقطاب (Poles)": "4 (أربع أقطاب)",
      "حماية الحرارة (Thermal Protection)": "PTC (150°C للملف / 50°C للبيئة)",
    },
    notes: "الموتور ده ضخم - 132kW ووزنه طن! الكفاءة 95.6% دي ممتازة (IE3 Premium). التيار 223.9A يعني محتاج كابل سميك أوي (علي الأقل 95mm² أو 120mm²). لو حاسس إن الموتور سخن، قس الـ Surface Temperature (حرارة السطح) بـ IR Gun (مسدس حرارة) - لازم تكون أقل من 80°C في الظروف العادية.",
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // نظام التشحيم الأوتوماتيكي
  // ═══════════════════════════════════════════════════════════════════════════
  EquipmentItem(
    id: "autogrease-01",
    nameAr: "نظام تشحيم أوتوماتيكي",
    nameEn: "Automatic Regreasing System",
    category: "أنظمة تشحيم",
    brand: "—",
    model: "F3-315M-4",
    serialNo: "—",
    madeIn: "—",
    mfgDate: "—",
    location: "على المحامل بتاعة المضخة الكبيرة",
    status: "شغال",
    icon: "🔧",
    color: 0xFF76FF03,
    specs: {
      "سعة الخزان (Volume - كمية الشحم)": "45g (جرام)",
      "نوع الشحم (Grease Type)": "CALTEX SRI-2 (شحم صناعي عالي الأداء - ليثيوم كومبلكس)",
      "فترة الصيانة (Interval - كل قد إيه)": "4000 ساعة تشغيل",
      "الوظيفة": "بيضخ شحم أوتوماتيك للمحامل (Bearings) من غير تدخل يدوي",
    },
    notes: "النظام ده بيضخ شحم للمحامل كل فترة أوتوماتيك. لازم تتحقق كل 4000 ساعة (ساعة تشغيل) إن الخزان لسه فيه شحم. استخدم CALTEX SRI-2 بس أو ما يكافئه (NLGI Grade 2 - درجة قوام الشحم). لو حطيت نوع تاني ممكن يتكسر النظام!",
  ),
];

// ───────────────────────────────────────────────────────────────────────────────
// PM Schedule — جدول الصيانة الدورية
// ───────────────────────────────────────────────────────────────────────────────

class PMTask {
  final String id;
  final String equipmentId;     // إيه المعدة
  final String taskAr;          // المهمة بالعامية
  final String frequency;       // كل قد إيه
  final String frequencyEn;     // بالإنجليزي
  final String severity;        // أهمية (حرج/عادي/منخفض)
  final String lastDone;        // آخر مرة اتعملت
  final String nextDue;         // المرة الجاية
  final String notes;           // ملاحظات بالعامية
  final String icon;

  const PMTask({
    required this.id,
    required this.equipmentId,
    required this.taskAr,
    required this.frequency,
    required this.frequencyEn,
    required this.severity,
    required this.lastDone,
    required this.nextDue,
    required this.notes,
    required this.icon,
  });
}

List<PMTask> pmSchedule = [

  // ─── شيلر Trane CVHF1300 ───
  PMTask(
    id: "pm-01",
    equipmentId: "chiller-01",
    taskAr: "شيك مستوى الزيت (Oil Level) في الـ Oil Sight Glass (الزجاجة الشفافة)",
    frequency: "كل أسبوع",
    frequencyEn: "Weekly",
    severity: "critical",
    lastDone: "—",
    nextDue: "—",
    notes: "الزيت لازم يكون في المستوى الصح بين العلامتين. لو ناقص ممكن الكمبريسور يتكسر! لو الزيت أسود (محترق) لازم يتغير فوراً.",
    icon: "🛢️",
  ),
  PMTask(
    id: "pm-02",
    equipmentId: "chiller-01",
    taskAr: "شيك شاشة التحكم CH530 (Controller) وشوف مفيش Error Codes (أكواد خطأ)",
    frequency: "يومياً",
    frequencyEn: "Daily",
    severity: "critical",
    lastDone: "—",
    nextDue: "—",
    notes: "لو طلع Error Code (كود خطأ) سجله وراجع الـ Service Manual (كتيب الصيانة). م تعملش Reset (ريست) كتير من غير ما تعرف السبب!",
    icon: "🖥️",
  ),
  PMTask(
    id: "pm-03",
    equipmentId: "chiller-01",
    taskAr: "قس درجة حرارة مية الشيلد (CHW Supply/Return) واحسب الـ Delta T (الفرق بين الدخول والخروج)",
    frequency: "يومياً",
    frequencyEn: "Daily",
    severity: "warning",
    lastDone: "—",
    nextDue: "—",
    notes: "الـ Delta T (دلتا تي) لازم يكون حوالي 5°C (5 درجات). لو أقل يبقى الشيلر مش بيبرد كويس - ممكن Evaporator Tubes (أنابيب المبخر) لازجة أو فريون ناقص.",
    icon: "🌡️",
  ),
  PMTask(
    id: "pm-04",
    equipmentId: "chiller-01",
    taskAr: "نظف الـ Condenser Tubes (أنابيب المكثف) بالـ Chemical Cleaning (تنظيف كيميائي)",
    frequency: "كل 6 شهور",
    frequencyEn: "Semi-Annual",
    severity: "critical",
    lastDone: "—",
    nextDue: "—",
    notes: "الأنابيب بتتلبس (Fouling - ترسبات) وده بيقلل أداء الشيلر أوي. استخدم Chemical Cleaning Pump (مضخة تنظيف كيميائي) واتبع التعليمات بالزبط.",
    icon: "🧪",
  ),
  PMTask(
    id: "pm-05",
    equipmentId: "chiller-01",
    taskAr: "غير زيت الكمبريسور (Compressor Oil) والـ Oil Filter (فلتر الزيت)",
    frequency: "كل سنة",
    frequencyEn: "Annual",
    severity: "warning",
    lastDone: "—",
    nextDue: "—",
    notes: "الزيت لازم يكون لونه بني فاتح. لو أسود يبقى حارق ولازم يتغير فوراً. غير الـ Oil Filter (فلتر الزيت) معاه كمان.",
    icon: "🛢️",
  ),
  PMTask(
    id: "pm-06",
    equipmentId: "chiller-01",
    taskAr: "اعمل Leak Test (اختبار تسريب) على كل الـ Joints (وصلات) والـ Flanges (فلانجات)",
    frequency: "كل 3 شهور",
    frequencyEn: "Quarterly",
    severity: "warning",
    lastDone: "—",
    nextDue: "—",
    notes: "استخدم Nitrogen (نيتروجين) أو Electronic Leak Detector (جهاز كشف تسريب إلكتروني). الفريون HFO-514A ده صديق للبيئة بس ده غاز غالي أوي - أي تسريب بتكلف فلوس!",
    icon: "🔍",
  ),

  // ─── مضخات B&G ───
  PMTask(
    id: "pm-07",
    equipmentId: "pump-primary-01",
    taskAr: "نظف الـ Strainer (الفلتر) على خط الساكشن (Suction)",
    frequency: "كل أسبوع",
    frequencyEn: "Weekly",
    severity: "critical",
    lastDone: "—",
    nextDue: "—",
    notes: "الـ Strainer (الفلتر) بيمسك الأوساخ والصدأ. لو مسدود المضخة هتعمل Cavitation (كافيتيشن - فقاعات بخار) وهتتكسر. أقفل الـ Valves (الصمامات) الأول قبل ما تفتحه!",
    icon: "🧹",
  ),
  PMTask(
    id: "pm-08",
    equipmentId: "pump-primary-01",
    taskAr: "شيك الـ Mechanical Seal (السيل الميكانيكي) وشوف بيسرب ولا لأ",
    frequency: "كل شهر",
    frequencyEn: "Monthly",
    severity: "warning",
    lastDone: "—",
    nextDue: "—",
    notes: "تسريب Drop (قطره) في الدقيقة عادي. لو أكتر من كده الـ Seal (السيل) خلاص ومحتاج تغيير. متخليش المضخة بتسرب كتير - الميه ممكن توصل للموتور!",
    icon: "💧",
  ),
  PMTask(
    id: "pm-09",
    equipmentId: "pump-primary-02",
    taskAr: "نظف الـ Strainer (الفلتر) على خط الساكشن - المضخة الكبيرة",
    frequency: "كل أسبوع",
    frequencyEn: "Weekly",
    severity: "critical",
    lastDone: "—",
    nextDue: "—",
    notes: "المضخة الكبيرة بتدفع 3000 GPM (جالون في الدقيقة) يعني أي حاجة جوا الـ Strainer بتقف سريع! لازم تنضف أسبوعياً بالزبط.",
    icon: "🧹",
  ),
  PMTask(
    id: "pm-10",
    equipmentId: "pump-primary-02",
    taskAr: "قس الـ Vibration (الاهتزاز) على الـ DE و NDE Bearings (المحامل)",
    frequency: "كل شهر",
    frequencyEn: "Monthly",
    severity: "warning",
    lastDone: "—",
    nextDue: "—",
    notes: "DE (دراي إند - نهاية الدوران) و NDE (نون دراي إند - الناحية التانية). استخدم Vibration Pen (قلم اهتزاز) أو Vibration Analyzer (محلل اهتزاز). لو القراءة أعلى من 4.5 mm/s يبقى في مشكلة.",
    icon: "📊",
  ),

  // ─── محركات FELM ───
  PMTask(
    id: "pm-11",
    equipmentId: "motor-01",
    taskAr: "شحم المحامل (Bearing Greasing) - محرك 45kW",
    frequency: "كل 4000 ساعة تشغيل",
    frequencyEn: "Every 4000 Run Hours",
    severity: "critical",
    lastDone: "—",
    nextDue: "—",
    notes: "استخدم CALTEX SRI-2 بس! (شحم ليثيوم كومبلكس NLGI Grade 2). متحطش نوع تاني. عدد البمبات (Grease Nipples) عادة 2 واحد DE (نهاية الدوران) وواحد NDE (الناحية التانية). شحم كل واحد حوالي 20-30g (جرام).",
    icon: "🔧",
  ),
  PMTask(
    id: "pm-12",
    equipmentId: "motor-02",
    taskAr: "شحم المحامل (Bearing Greasing) - محرك 132kW",
    frequency: "كل 4000 ساعة تشغيل",
    frequencyEn: "Every 4000 Run Hours",
    severity: "critical",
    lastDone: "—",
    nextDue: "—",
    notes: "نفس الشحم CALTEX SRI-2. الموتور ده 132kW يعني محامل أكبر فمحتاج شحم أكتر (حوالي 40-50g لكل بيمب). متشحمش أوي! الشحم الزايد بيسخن المحامل.",
    icon: "🔧",
  ),
  PMTask(
    id: "pm-13",
    equipmentId: "motor-01",
    taskAr: "قس الـ Amps (الأمبير) بـ Clamp Meter (أمبير كلامب)",
    frequency: "كل شهر",
    frequencyEn: "Monthly",
    severity: "warning",
    lastDone: "—",
    nextDue: "—",
    notes: "التيار لازم يكون حوالي 80A عند الحمل الكامل (400V). لو أعلى من 85A يبقى في Overload (حمل زايد). قس الـ 3 Phases (الأطوار التلاتة) واتأكد إن الفرق م بينهم مش أكتر من 2%.",
    icon: "⚡",
  ),
  PMTask(
    id: "pm-14",
    equipmentId: "motor-02",
    taskAr: "قس الـ Amps (الأمبير) بـ Clamp Meter - محرك 132kW",
    frequency: "كل شهر",
    frequencyEn: "Monthly",
    severity: "warning",
    lastDone: "—",
    nextDue: "—",
    notes: "التيار لازم يكون حوالي 224A عند الحمل الكامل (400V). قس الـ 3 Phases (الأطوار التلاتة) وتأكد إن الفرق بينهم مش أكتر من 2%. لو في Phase Missing (طور ناقص) الموتور هيحترق!",
    icon: "⚡",
  ),

  // ─── نظام التشحيم الأوتوماتيكي ───
  PMTask(
    id: "pm-15",
    equipmentId: "autogrease-01",
    taskAr: "شيك مستوى الشحم في الخزان الأوتوماتيكي",
    frequency: "كل شهر",
    frequencyEn: "Monthly",
    severity: "warning",
    lastDone: "—",
    nextDue: "—",
    notes: "الخزان سعته 45g (جرام) والفترة 4000 ساعة. لو لقيت الخزان فاضي اعبيه بـ CALTEX SRI-2. متخلطش أنواع شحم!",
    icon: "🔧",
  ),
];
