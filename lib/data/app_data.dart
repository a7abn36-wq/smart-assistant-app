// ═══════════════════════════════════════════════════════════════════════════════
// المساعد الذكي - Smart Assistant | HVAC Chiller Plant Maintenance App
// app_data.dart — Complete Equipment, Fault & Guide Data Layer
// All HVAC content in Egyptian Arabic colloquial with English technical terms
// ═══════════════════════════════════════════════════════════════════════════════

// ───────────────────────────────────────────────────────────────────────────────
// Equipment Category
// ───────────────────────────────────────────────────────────────────────────────

class EquipmentCategory {
  final String id;
  final String nameAr;
  final String nameEn;
  final String icon;
  final int color;

  const EquipmentCategory({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.icon,
    required this.color,
  });
}

const List<EquipmentCategory> categories = [
  EquipmentCategory(
    id: "chillers",
    nameAr: "شيلرات",
    nameEn: "Chillers",
    icon: "\u2744\uFE0F",
    color: 0xFF00E5FF,
  ),
  EquipmentCategory(
    id: "primaryPumps",
    nameAr: "مضخات برايمري",
    nameEn: "Primary Pumps",
    icon: "\uD83D\uDCA7",
    color: 0xFF448AFF,
  ),
  EquipmentCategory(
    id: "condenserPumps",
    nameAr: "مضخات كوندنسر",
    nameEn: "Condenser Pumps",
    icon: "\uD83C\uDF0A",
    color: 0xFF2979FF,
  ),
  EquipmentCategory(
    id: "secondaryPumps",
    nameAr: "مضخات سكندري",
    nameEn: "Secondary Pumps",
    icon: "\uD83D\uDCA0",
    color: 0xFF00B0FF,
  ),
  EquipmentCategory(
    id: "coolingTowers",
    nameAr: "أبراج التبريد",
    nameEn: "Cooling Towers",
    icon: "\uD83C\uDF21\uFE0F",
    color: 0xFF18FFFF,
  ),
  EquipmentCategory(
    id: "drives",
    nameAr: "درايفات",
    nameEn: "VFD Drives",
    icon: "\u26A1",
    color: 0xFFFFAB00,
  ),
  EquipmentCategory(
    id: "valves",
    nameAr: "صمامات",
    nameEn: "Valves",
    icon: "\uD83D\uDD27",
    color: 0xFFFF6D00,
  ),
  EquipmentCategory(
    id: "waterTreatment",
    nameAr: "معالجة مياه",
    nameEn: "Water Treatment",
    icon: "\uD83D\uDCA7",
    color: 0xFF76FF03,
  ),
  EquipmentCategory(
    id: "expansionTank",
    nameAr: "خزان التمدد",
    nameEn: "Expansion Tank",
    icon: "\uD83D\uDEE0\uFE0F",
    color: 0xFFB388FF,
  ),
];

// ───────────────────────────────────────────────────────────────────────────────
// Fault Model
// ───────────────────────────────────────────────────────────────────────────────

class Fault {
  final String id;
  final String categoryId;
  final String title;
  final String warning;
  final String cause;
  final String solution;
  final List<String> keywords;
  final String severity;

  const Fault({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.warning,
    required this.cause,
    required this.solution,
    required this.keywords,
    required this.severity,
  });
}

// ───────────────────────────────────────────────────────────────────────────────
// Guide Model
// ───────────────────────────────────────────────────────────────────────────────

class Guide {
  final String id;
  final String title;
  final String whatIs;
  final List<String> parts;
  final List<String> check;
  final List<String> commonFaults;
  final String warn;

  const Guide({
    required this.id,
    required this.title,
    required this.whatIs,
    required this.parts,
    required this.check,
    required this.commonFaults,
    required this.warn,
  });
}

// ═══════════════════════════════════════════════════════════════════════════════
// ALL FAULTS DATA — 55 Real HVAC Faults in Egyptian Arabic
// ═══════════════════════════════════════════════════════════════════════════════

List<Fault> allFaults = [
  // ═══════════════════════════════════════════════════════════════════════════
  // شيلرات — CHILLERS (8 faults)
  // ═══════════════════════════════════════════════════════════════════════════
  Fault(
    id: "ch-01",
    categoryId: "chillers",
    title: "الشيلر بيقف وبيطلع High Pressure Lockout (HP Lockout)",
    warning: "⚠️ لو الشيلر وقف بسبب الضغط العالي، متحاولش تعيده تشغيل على طول! الضغط العالي ممكن يسبب انفجار في الفريون أو ضرر في الكمبريسور. خليه يبرد ٥ دقايق الأول.",
    cause: "السبب الرئيسي: كوندنسر وسخ أو ميه التبريد قليلة أو فان كوندنسر واقف أو ريستريكشن في خط السائل Liquid Line. لو الفريون زايد ممكن كمان يسبب الضغط العالي.",
    solution: """١. قف الشيلر من الباور وأصلح السبب الأول
٢. افتح الفلفل على كوندنسر واتأكد إن الميه ماشية كويس
٣. اتأكد من فان الكوندنسر شغال ومحوره صح
٤. اتأكد إن درجة حرارة ميه الكوندنسر أقل من ٣٥ درجة
٥. شيك على ريستريكشن في Liquid Line أو Filter Drier مسدود
٦. بعد إصلاح السبب، انتظر ٥ دقايق وبعدين ريست الشيلر""",
    keywords: [
      "ضغط عالي", "شيلر واقف", "HP lockout", "high pressure", "high head pressure",
      "كوندنسر وسخ", "فريون زايد", "condenser dirty", "فان كوندنسر",
      "ريستريكشن", "filter drier", "liquid line", "شيلر بيقف", "lockout",
    ],
    severity: 'critical',
  ),
  Fault(
    id: "ch-02",
    categoryId: "chillers",
    title: "الشيلر بيقف وبيطلع Low Pressure Lockout (LP Lockout)",
    warning: "⚠️ الضغط الواطي معناه إن الفريون ناقص أو فيه تسريب! لو شغلته كده الكمبريسور هيحترق من قلة الزيت وعدم التبريد الكافي.",
    cause: "السبب الرئيسي: تسريب فريون من الـ Evaporator أو الـ Expansion Valve مسدودة أو Low Load على الشيلر أو الشيرفويس فالس علطول.",
    solution: """١. قف الشيلر فوراً
٢. اعمل Leak Test بـ Nitrogen على كل الـ Joints والـ Flanges
٣. لو لقيت تسريب، صلحه واعمل Evacuation بالـ Vacuum Pump
٤. شيك مستوى الفريون بال Sight Glass والـ Subcooling/Superheat
٥. اتأكد من الـ Expansion Valve مش مسدودة والـ TXV Bulb مثبت صح
٦. بعد التأكد، رجع الفريون بالوزن الصح وابدأ التشغيل""",
    keywords: [
      "ضغط واطي", "low pressure", "LP lockout", "تسريب فريون", "freon leak",
      "evaporator", "expansion valve", "TXV", "فريون ناقص", "شيلر ضغط واطي",
      "sight glass", "subcooling", "superheat", "vacuum", "نيتروجين",
    ],
    severity: 'critical',
  ),
  Fault(
    id: "ch-03",
    categoryId: "chillers",
    title: "كمبريسور الشيلر بيبقى ساخن أوي وبيطلع Motor Overload (Compressor Overheat)",
    warning: "⚠️ الكمبريسور لو سخن أوي ممكن ينفجر الزيت فيه أو يحترق الـ Motor! ده خطر جداً على حياة الفني وعمر الشيلر. قف الشيلر فوراً!",
    cause: "السبب: زيت الكمبريسور ناقص أو وسخ، أو الـ Oil Filter مسدود، أو الـ Cooling للـ Motor Head ضعيف، أو السوبرهيت Superheat عالي أوي، أو الحمل على الشيلر أكبر من الـ Design.",
    solution: """١. قف الشيلر واتأكد إن الـ Compressor Oil في المستوى الصحيح
٢. غير الـ Oil Filter لو لسه فترة طويلة
٣. شيك على الـ Oil Cooler واتأكد إنه شغال وميه تبريده ماشية
٤. قس الـ Superheat واتأكد إنه في المجال المطلوب (٤-٧ درجات لـ Screw)
٥. اتأكد إن الحمل على الشيلر مش أكبر من الـ Rated Capacity
٦. لو الزيت حارق (أسود اللون)، غير الزيت بالكامل واغسل النظام""",
    keywords: [
      "كمبريسور ساخن", "motor overload", "compressor overheat", "زيت ناقص",
      "oil filter", "oil cooler", "superheat عالي", "زيت حارق", "motor burnout",
      "كمبريسور", "compressor", "حمل زايد", "overload", "زيت أسود",
    ],
    severity: 'critical',
  ),
  Fault(
    id: "ch-04",
    categoryId: "chillers",
    title: "الشيلر مش بيبرد كويس — مية الشيلد وارمة (Low Delta T / Low Capacity)",
    warning: "⚠️ لو الشيلر مش بيبرد كويس، الأحمال على باقي الشيلرات هتزيد وده ممكن يودي لتوقف المحطة كلها. اشتغل على المشكلة بسرعة.",
    cause: "السبب: فريون ناقص، أو الـ Evaporator Tubes متلزقة Fouling، أو الـ Expansion Valve مش بتعمل Shimming كويس، أو Air في النظام، أو الـ Compressor Unloader مش شغال.",
    solution: """١. قس الـ Chilled Water Supply و Return Temperature (ΔT لازم يكون ٥ درجات تقريباً)
٢. اتأكد من مستوى الفريون بالـ Sight Glass
٣. شيك الـ Evaporator Approach Temperature (لو أعلى من Design يبقى Tubes لازجة)
٤. نظف الـ Evaporator Bundle بالـ Chemical Cleaning
٥. اتأكد من الـ Expansion Valve Stroke والـ Superheat
٦. شيك الـ Unloader واتأكد إنه بيتحرك بحرية""",
    keywords: [
      "شيلر مش بيبرد", "low delta T", "ميه وارمة", "low capacity",
      "evaporator fouling", "fouling", "expansion valve", "unloader",
      "شيلد وارم", "chilled water", "approach temperature", "ميه شيلد",
    ],
    severity: 'critical',
  ),
  Fault(
    id: "ch-05",
    categoryId: "chillers",
    title: "الشيلر بيبعز ويطلع صوت غريب — Vibration عالية (Compressor Vibration)",
    warning: "⚠️ الاهتزاز العالي ممكن يكسر الـ Bearings أو الـ Coupling أو يخلي الـ Compressor يفصل من الأساس! لو السوبرمت مابينفعش، قف الشيلر فوراً.",
    cause: "السبب: الـ Bearings تالفة، أو الـ Coupling بين الموتور والكمبريسور متآكل، أو الـ Foundation Bolts مش مشدودة، أو الـ Impeller متكسر أو فيه Unbalance، أو Cavitation في الـ Evaporator.",
    solution: """١. خد قراءة الـ Vibration بالـ Vibration Analyzer على الـ Compressor Bearings
٢. شيك الـ Coupling Alignment ولو فيه Wear غيّره
٣. شد كل الـ Foundation Bolts واتأكد من الـ Anchor Bolts
٤. لو الـ Bearings خشنة (صوت طحن)، غيرها فوراً
٥. اتأكد من الـ Oil Level والـ Oil Quality (لو فيه Water أو Metal Particles)
٦. لو المشكلة مستمرة، اتعامل مع الـ OEM لأن ده ممكن يكون Impeller Problem""",
    keywords: [
      "اهتزاز", "vibration", "صوت غريب", "coupling", "bearings تالفة",
      "كمبريسور بيعزز", "impeller", "unbalance", "foundation bolts",
      "vibration analysis", "bearing noise", "grinding noise", "اهتزاز شيلر",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "ch-06",
    categoryId: "chillers",
    title: "الشيلر بيطلع Oil Pressure Failure / Low Oil Pressure",
    warning: "⚠️ بدون زيت كافي، الكمبريسور هيتكسر خلال دقايق! ده من أخطر الأعطال. قف الشيلر فوراً وعدم تشغيله لحد ما تصلح المشكلة.",
    cause: "السبب: زيت الكمبريسور ناقص، أو الـ Oil Pump تالف، أو الـ Oil Filter مسدود، أو الـ Oil Pressure Transmitter فالس، أو فيه Freon يختلط مع الزيت (Dilution).",
    solution: """١. قف الشيلر فوراً — عدم تشغيله بدون زيت!
٢. شيك مستوى الزيت بالـ Oil Sight Glass
٣. اتأكد من الـ Oil Pressure Gauge Reading (لازم يكون 15-25 PSI أbove Suction Pressure)
٤. غير الـ Oil Filter واشيك على الـ Differential Pressure
٥. شيك الـ Oil Pump واتأكد إنه بيدور
٦. لو فيه Freon في الزيت (زيت رغوي)، شغل الشيلر على الـ Oil Heater قبل التشغيل""",
    keywords: [
      "زيت ناقص", "oil pressure failure", "low oil pressure", "oil pump",
      "oil filter", "oil level", "oil pressure", "freon dilution", "زيت رغوي",
      "oil heater", "oil sight glass", "كمبريسور زيت",
    ],
    severity: 'info',
  ),
  Fault(
    id: "ch-07",
    categoryId: "chillers",
    title: "الشيلر بيقف على Surge — Compressor Surge (تذبذب الضغط)",
    warning: "⚠️ الـ Surge ممكن يدمر الـ Impeller والـ Bearings في دقايق! لو السرج مستمر أكتر من ٣٠ ثانية، قف الشيلر فوراً واعمل تحميل وهمي.",
    cause: "السبب: الحمل على الشيلر قليل أوي (Low Load)، أو الـ Guide Vanes مش مضبوطة، أو الـ Condenser Pressure عالي، أو الـ Evaporator Pressure واطي، أو الـ Surge Setpoint غلط.",
    solution: """١. قف الـ Surge فوراً لو مستمر — افتح الـ Hot Gas Bypass لو متوفر
٢. زوّد الحمل على الشيلر (شغّل Pumps و AHUs)
٣. اتأكد من الـ Guide Vane Position (ماشية بالـ PID Output الصح)
٤. قلل الـ Condenser Pressure (نظف الكوندنسر أو زوّد مية التبريد)
٥. اتأكد من الـ Surge Setpoint في الـ Controller
٦. لو الشيلر Centrifugal، اتأكد من الـ Inlet Guide Vanes بتتحرك بسلاسة""",
    keywords: [
      "سيرج", "surge", "تذبذب", "guide vanes", "hot gas bypass",
      "low load", "impeller damage", "centrifugal chiller", "inlet guide vanes",
      "surge protection", "chiller surge", "كمبريسور سيرج", "اهتزاز كمبريسور",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "ch-08",
    categoryId: "chillers",
    title: "شاشة الشيلر بتيجي Blank أو بتقلع Error Code مش معروف",
    warning: "⚠️ خطأ في الـ Controller معناه إن الشيلر مش مضمون! ممكن يشتغل غلط أو يقف في أي وقت. متتجاهلش الخطأ ده.",
    cause: "السبب: الـ Microprocessor Board فيها Problem، أو الـ Power Supply للـ Controller ضعيف، أو الـ Sensors فالسة (Temperature/Pressure Sensors)، أو الـ EEPROM Data اتمسحت.",
    solution: """١. ريست الشيلر من الـ Main Power (Off/on كامل)
٢. شيك الـ 24VDC Power Supply للـ Controller Board
٣. اتأكد من الـ Sensor Readings وإنها منطقية (مفيش قيم غريبة)
٤. لو Error Code معروف، راجع الـ Service Manual بتاع الشيلر
٥. اتأكد من الـ Grounding وإن مفيش Electrical Noise
٦. لو المشكلة مستمرة، اتصل بالـ OEM Support وابعت لهم الـ Error Log""",
    keywords: [
      "error code", "شاشة فاضية", "controller fault", "microprocessor",
      "sensor فالس", "power supply", "EEPROM", "chiller error",
      "error log", "service manual", "شيلر خطأ", "شيلر error",
    ],
    severity: 'info',
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // مضخات برايمري — PRIMARY PUMPS (6 faults)
  // ═══════════════════════════════════════════════════════════════════════════
  Fault(
    id: "pp-01",
    categoryId: "primaryPumps",
    title: "المضخة البرايمري مش بتشرب ميه — No Flow / Dead Head (Cavitation)",
    warning: "⚠️ المضخة لو شغالة ومش بتدفع ميه (Dead Head)، ده ممكن يسخن الميه جواها ويعمل Steam Pocket وينفجر الـ Mechanical Seal! قفها فوراً!",
    cause: "السبب: الـ Suction Line مسدودة أو الـ Strainer على الساكشن وسخ، أو الـ Foot Valve (لو يوجد) مقفول، أو مستوى الميه في الـ Expansion Tank واطي، أو الـ NPSH Available أقل من الـ Required.",
    solution: """١. قف المضخة وافتح الـ Isolation Valves على الـ Suction والـ Discharge
٢. نظف الـ Strainer على خط الساكشن
٣. اتأكد من مستوى الميه في خزان التمدد
٤. افتح الـ Air Vent على أعلى المضخة (Bleed Air)
٥. شيك الـ NPSH — لو المضخة فوق الـ Tank كتير، المشكلة من الـ Suction Head
٦. اعمل Priming واتأكد إن الميه واصلة للمضخة قبل ما تشغلها""",
    keywords: [
      "مضخة مش بتشرب", "no flow", "dead head", "cavitation", "suction",
      "strainer", "foot valve", "NPSH", "priming", "مضخة هواء",
      "bleed air", "air vent", "مضخة برايمري", "primary pump",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "pp-02",
    categoryId: "primaryPumps",
    title: "المضخة البرايمري بتسرب ميه من الـ Mechanical Seal (Seal Leakage)",
    warning: "⚠️ التسريب من الـ Seal لو مش بسيط (أكتر من Drop/minute) ممكن يدخل ميه للموتور ويحرقونه! وقف المضخة لو التسريب كتير.",
    cause: "السبب: الـ Mechanical Seal تالفة من الـ Wear، أو الـ Shaft متآكل أو فيه Score Marks، أو الميه وسخة وفيها Abrasive Particles، أو الـ Pump مش Centrifugally Aligned، أو الـ Dry Running (شغلتها ومش فيها ميه).",
    solution: """١. قف المضخة وافصل الباور
٢. افتح الـ Seal Chamber وشوف حالة الـ Seal Faces
٣. لو الـ Seal Faces خشنة أو محروقة، غيّر الـ Seal Assembly بالكامل
٤. شيك الـ Shaft Runout (ماش يكون أكتر من 0.002 بوصة)
٥. اتأكد من الـ Alignment بين الموتور والمضخة (Dial Indicator)
٦. نظف الـ Strainer واتأكد إن الميه نظيفة عشان مايحصلش تآكل تاني""",
    keywords: [
      "تسريب ميه", "seal leakage", "mechanical seal", "seal تالف",
      "shaft wear", "dry running", "pump alignment", "seal faces",
      "مضخة بتسرب", "seal replacement", "shaft runout", "مضخة برايمري",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "pp-03",
    categoryId: "primaryPumps",
    title: "موتور المضخة البرايمري بيسخن وبيطلع Overload Trip (Motor Overheating)",
    warning: "⚠️ الموتور لو سخن كتير ممكن يحترق! كل ما يشتغل سخن أكتر، عمره بيقل. لو الـ Trip بيحصل كل شوية، في مشكلة حقيقية محتاجة إصلاح.",
    cause: "السبب: الحمل على المضخة أكبر من الـ Rated (Valve نصف مقفول أو System Head عالي)، أو الـ Motor Bearings تالفة، أو الـ Voltage واطي أو Phase Missing، أو الـ Impeller فيه Blockage.",
    solution: """١. قس الـ Amps بـ Clamp Meter واعرضها على الـ Nameplate (لو أعلى = overload)
٢. شيك الـ 3 Phases واتأكد إن الـ Voltage متوازنة (مش أكتر من ٢% فرق)
٣. افتح الـ Discharge Valve بالكامل (متشغلش المضخة والـ Valve مقفول)
٤. شيك الـ Motor Bearings — دور الـ Shaft باليد لو مابيشتغلش بسهولة، غيّر الـ Bearings
٥. اتأكد من الـ Impeller مش مسدود
٦. لو الحمل فعلاً عالي، ممكن تحتاج تقلل الـ Impeller Diameter أو تغيّر الموتور""",
    keywords: [
      "موتور ساخن", "motor overload", "overheating", "ampere عالي",
      "phase missing", "motor bearings", "impeller blockage", "مضخة تريب",
      "trip", "voltage unbalanced", "clamp meter", "موتور بيسخن",
    ],
    severity: 'critical',
  ),
  Fault(
    id: "pp-04",
    categoryId: "primaryPumps",
    title: "المضخة البرايمري بتعمل Vibration عالي وصراخ (Pump Noise/Vibration)",
    warning: "⚠️ الاهتزاز العالي ويا الصراخ معناه إن في Bearings تالفة أو Misalignment أو Cavitation. الاستمرار في التشغيل هيخلي المضخة تتعطل بالكامل.",
    cause: "السبب: الـ Bearings تالفة أو ناقصة زيت، أو الـ Alignment بين الموتور والمضخة مش كويس (Coupling wear)، أو الـ Foundation Loose، أو Cavitation من الساكشن.",
    solution: """١. خد قراءة Vibration بالـ Analyzer على الـ DE و NDE Bearings
٢. فك الـ Coupling Guard وشيك الـ Coupling Rubber/Spider (لو متآكل غيّره)
٣. اعمل Alignment بـ Dial Indicator (التسامح: 0.002 بوصة offset, 0.001 in/in angular)
٤. شيك الـ Foundation Bolts وشدها
٥. لو الـ Bearings خشنة، غيّرها واتأكد من الـ Lubrication
٦. لو فيه Cavitation، راجع Fault PP-01""",
    keywords: [
      "صوت مضخة", "pump noise", "vibration", "bearings", "alignment",
      "coupling", "foundation bolts", "cavitation", "مضخة صراخ",
      "pump bearing", "misalignment", "dial indicator",
    ],
    severity: 'critical',
  ),
  Fault(
    id: "pp-05",
    categoryId: "primaryPumps",
    title: "المضخة البرايمري بتعمل Pressure واطي (Low Discharge Pressure)",
    warning: "⚠️ الضغط الواطي معناه إن الميه مش بتوصل للشيلر كويس، وده هيأثر على أداء التبريد كلو. مشكلة الضغط الواطي ممكن تكون من سلسلة.",
    cause: "السبب: الـ Impeller متآكل أو فيه Erosion، أو الـ Wear Rings خلاصت (زيادة الـ Clearance)، أو الـ Suction Pressure واطي أصلاً، أو الـ System Resistance زادت (Valves مقفولة أو Fouling في الـ Piping).",
    solution: """١. قس الـ Suction Pressure والـ Discharge Pressure واحسب الـ Differential
٢. قارن الـ Reading بالـ Pump Curve (لو تحت الـ Curve = مشكلة)
٣. لو الـ Wear Rings فيه Clearance أكبر من Specification، غيّرها
٤. افتح كل الـ Isolation Valves واتأكد إن مفيش Restriction
٥. لو الـ Impeller متآكل، غيّره أو اعمل Refurbishment
٦. شيك الـ Differential Pressure Switch واتأكد إنه معاير صح""",
    keywords: [
      "ضغط واطي", "low pressure", "pump curve", "wear rings", "impeller",
      "discharge pressure", "system resistance", "isolation valve",
      "مضخة ضغط واطي", "pump performance", "differential pressure",
    ],
    severity: 'critical',
  ),
  Fault(
    id: "pp-06",
    categoryId: "primaryPumps",
    title: "المضخة البرايمري الدرايف بتاعها بيطلع Error (VFD Fault on Pump)",
    warning: "⚠️ الدرايف لو طلع Error المضخة هتقف فجأة وده ممكن يأثر على باقي المحطة. متعملش Reset كتير من غير ما تعرف السبب!",
    cause: "السبب: الـ VFD بيطلع Error من Overcurrent (الحمل زايد)، أو Overvoltage/Undervoltage، أو Overheat في الـ VFD نفسه، أو الـ Motor Phase Loss، أو الـ Parameter Settings اتغيرت.",
    solution: """١. اقرأ الـ Fault Code من الشاشة واعرف نوع الخطأ
٢. لو Overcurrent: شيك الحمل على المضخة والـ Amps
٣. لو Overheat: نظف الفلاتر بتاعة الدرايف واتأكد من الـ Ventilation
٤. لو Phase Loss: شيك الـ Input Power والـ Output Cables
٥. راجع الـ Motor Parameters (Voltage, Current, Frequency) في الـ VFD
٦. بعد إصلاح السبب، اعمل Reset من الـ VFD Panel""",
    keywords: [
      "درايف error", "VFD fault", "overcurrent", "overheat", "phase loss",
      "VFD error", "drive fault", "مضخة درايف", "VFD reset",
      "motor parameters", "undervoltage",
    ],
    severity: 'warning',
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // مضخات كوندنسر — CONDENSER PUMPS (6 faults)
  // ═══════════════════════════════════════════════════════════════════════════
  Fault(
    id: "cp-01",
    categoryId: "condenserPumps",
    title: "مضخة الكوندنسر مش بتدفع Flow كافي لأبراج التبريد (Low Condenser Flow)",
    warning: "⚠️ لو مية الكوندنسر قليلة، الشيلر هيقف على High Pressure! ده مباشرة هيأثر على كل المحطة.",
    cause: "السبب: الـ Strainer على المضخة وسخ، أو الـ Air في النظام (مش مخرجش كويس)، أو الـ Impeller تالف أو الـ Wear Rings خلاصت، أو الـ Valve على الـ Discharge مقفول جزئياً.",
    solution: """١. قس الـ Flow Meter Reading وقارنها بالـ Design Flow
٢. نظف الـ Strainer على الساكشن
٣. Bleed الهواء من أعلى المضخة ومن الـ Condenser
٤. اتأكد من إن الـ Discharge Valve مفتوح بالكامل
٥. لو الـ Impeller أو Wear Rings تالفة، اعمل Overhaul
٦. شيك الـ Differential Pressure Across Condenser (لو عالي = Condenser Tubes لازجة)""",
    keywords: [
      "مضخة كوندنسر", "condenser flow", "low flow", "strainer", "air lock",
      "cooling tower flow", "condenser water flow", "ميه كوندنسر",
      "flow meter", "differential pressure", "wear rings",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "cp-02",
    categoryId: "condenserPumps",
    title: "مضخة الكوندنسر بتسرب من الـ Packing Gland (Packing Leakage)",
    warning: "⚠️ التسريب من الـ Packing عادي يكون Drop بالدقيقة. لو التسريب أكتر من كده، يعني الـ Packing خلاصة ومحتاجة تغيير. لو خليتيها بتسرب كتير، الميه تدخل للموتور.",
    cause: "السبب: الـ Packing Rings خلاصت عمرها (Worn Out)، أو الـ Lantern Ring مش في المكان الصح، أو الـ Shaft فيه Wear/Groove من الـ Packing.",
    solution: """١. خلي المضخة شغالة والـ Packing بتسرب شوية عشان التبريد (Drop/sec)
٢. لو التسريب كتير: قف المضخة وافك الـ Gland Follower
٣. أضف ٢-٣ حلقات Packing جديدة (تأكد من الـ Joint Staggered 90°)
٤. اتأكد من إن الـ Lantern Ring على خط الـ Seal Water
٥. شد الـ Gland Nuts بالتساوي (متشدهمش أوي عشان ماتحرقش الـ Shaft)
٦. لو الـ Shaft فيه Groove عميق، اعمل Shaft Repair أو غيّر الـ Shaft""",
    keywords: [
      "packing leakage", "gland packing", "packing gland", "lantern ring",
      "shaft wear", "مضخة بتسرب", "seal water", "packing rings",
      "gland follower", "مضخة كوندنسر", "shaft groove",
    ],
    severity: 'info',
  ),
  Fault(
    id: "cp-03",
    categoryId: "condenserPumps",
    title: "مضخة الكوندنسر بتعمل Vibration وبيسمع منها Noise بعد الـ Overhaul",
    warning: "⚠️ بعد الـ Overhaul، المضخة لازم تشغل هادي. لو فيها Noise أو Vibration، يعني في حاجة غلط في التركيب! متخليهاش تشغل كده.",
    cause: "السبب: الـ Alignment مش كويس بعد فك وتركيب، أو الـ Coupling فيه Problem، أو الـ Bearings جديدة ومحتاجة Run-in، أو الـ Impeller محطوط بـ Reverse Rotation، أو الـ Foundation Bolts مش شدت.",
    solution: """١. وقف المضخة وتأكد من اتجاه الدوران (Rotation Arrow على الـ Casing)
٢. اعمل Alignment جديد بالـ Dial Indicator (Soft Foot Check كمان)
٣. شيك الـ Coupling Gap والـ Offset
٤. لو الـ Bearings جديدة، شغلها ٢ ساعة على No-Load واختبر تاني
٥. شد كل الـ Foundation Bolts بالـ Torque الصح
٦. خد قراءة Vibration وراجع الـ Spectrum Analysis""",
    keywords: [
      "after overhaul", "vibration", "noise", "alignment", "coupling",
      "reverse rotation", "soft foot", "foundation bolts", "bearings run-in",
      "spectrum analysis", "مضخة كوندنسر", "بعد الصيانة",
    ],
    severity: 'critical',
  ),
  Fault(
    id: "cp-04",
    categoryId: "condenserPumps",
    title: "مضخة الكوندنسر بتعمل Priming مش كويس — Vortex في الساكشن",
    warning: "⚠️ الهواء في الساكشن بيخلي المضخة تفقد الـ Prime وده ممكن يسبب Cavitation شديد ويضر المضخة والـ Seal.",
    cause: "السبب: خط الساكشن فيه نقطة عالية (High Point) ومش فيها Air Vent، أو الـ Cooling Tower Basin مستواه واطي، أو الـ Suction Pipe حجمه صغير أوي (High Velocity)، أو الـ Eccentric Reducer محطوط بالمقلوب.",
    solution: """١. اتأكد من مستوى الميه في الـ Cooling Tower Basin
٢. شيك الـ Eccentric Reducer على الساكشن (الـ Flat Side لازم يكون فوق)
٣. ركب Air Vent على كل High Point في خط الساكشن
٤. Bleed الهواء من المضخة كويس قبل التشغيل
٥. لو الـ Suction Pipe صغير، ممكن تحتاج تكبره
٦. اتأكد من الـ Foot Valve أو الـ Non-Return Valve شغالين كويس""",
    keywords: [
      "priming", "vortex", "air vent", "suction pipe", "eccentric reducer",
      "cooling tower basin", "foot valve", "non-return valve", "air lock",
      "مضخة كوندنسر", "ساكشن هواء", "high point",
    ],
    severity: 'critical',
  ),
  Fault(
    id: "cp-05",
    categoryId: "condenserPumps",
    title: "مضخة الكوندنسر الموتور بتاعها بتعمل Phase Reversal / Reverse Rotation",
    warning: "⚠️ لو المضخة بتدور بالمقلوب (Reverse)، ده ممكن يكسر الـ Impeller أو يخلي الـ Coupling ينخلع! قفها فوراً لو لاحظت إن الاتجاه غلط.",
    cause: "السبب: بعد صيانة أو تغيير كابلات، الـ 3 Phases اتقلبت. أو بعد تغيير الموتور أو الدرايف، الاتجاه اتغير.",
    solution: """١. وقف المضخة فوراً لو شفت الاتجاه غلط
٢. اتأكد من الـ Rotation Arrow المرسومة على الـ Pump Casing
٣. في الـ DOL Starter: بدّل أي Phase اتنين في الـ Contactor (R مع S مثلاً)
٤. في الـ VFD: غيّر الـ Parameter للـ Rotation Direction (FWD/REV)
٥. شغل المضخة تاني وتأكد من الاتجاه (شوف الـ Coupling)
٦. قس الـ Discharge Pressure واتأكد إنه في المجال الصح""",
    keywords: [
      "phase reversal", "reverse rotation", "اتجاه غلط", "3 phases",
      "contactor", "VFD rotation", "rotation direction", "مضخة بالمقلوب",
      "DOL starter", "coupling", "impeller",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "cp-06",
    categoryId: "condenserPumps",
    title: "مضخة الكوندنسر بتعمل Short Cycling — بتقف وبتشتغل بسرعة",
    warning: "⚠️ الـ Short Cycling بيسخن الموتور وبيكسر الـ Contactors وبيقلل عمر المضخة. كل Start = صدمة كهربائية وميكانيكية.",
    cause: "السبب: الـ Pressure Switch (DPS) معاير غلط أو الـ Setpoint قريبة أوي، أو الـ Auto/Manual في وضع غلط، أو الـ Controller بيدي أوامر Stop/Start بسرعة، أو Air في النظام بيخلي الـ Pressure يتذبذب.",
    solution: """١. شيك الـ Differential Pressure Switch Settings (المجال لازم يكون ١-٢ بار مثلاً)
٢. اتأكد من الـ Dead Band (الفرق بين Start و Stop Pressure)
٣. أخرج الهواء من النظام كويس
٤. شيك الـ BMS/Controller Signal واتأكد إنه مش بيتبعد بسرعة
٥. اتأكد من الـ Auto/Manual Switch في الوضع الصح
٦. لو فيه VFD، تأكد إنه مش في الـ PID Mode وهو فيه Oscillation""",
    keywords: [
      "short cycling", "pressure switch", "DPS", "dead band", "BMS",
      "PID oscillation", "auto manual", "مضخة بتقف وبتشتغل",
      "differential pressure switch", "setpoint", "مضخة كوندنسر",
    ],
    severity: 'warning',
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // مضخات سكندري — SECONDARY PUMPS (6 faults)
  // ═══════════════════════════════════════════════════════════════════════════
  Fault(
    id: "sp-01",
    categoryId: "secondaryPumps",
    title: "مضخة السكندري مش بتوصل ميه كافية للـ AHUs (Low CHW Supply)",
    warning: "⚠️ لو مية التبريد مش واصلة للـ AHUs، المبنى كله هيسخن! العملاء هيشكوا فوراً وده ممكن يكون أزمة.",
    cause: "السبب: الـ Differential Pressure Sensor (DP Sensor) فالس وبيدي قراءة غلط للـ VFD، أو الـ 2-Way Valves على الـ AHUs كلها مقفولة، أو الـ Balance Valve على الـ Index Run مش مضبوط، أو الـ Pump Impeller متآكل.",
    solution: """١. قس الـ CHW Supply Pressure عند أقصى نقطة (Farthest AHU)
٢. شيك الـ DP Sensor واعمل Calibration
٣. اتأكد من إن الـ 2-Way Valves بتفتح لما الـ BMS يطلب تبريد
٤. شيك الـ Balance Valve Settings على كل Branch
٥. اتأكد من إن الـ VFD بيتحكم بالـ PID من الـ DP Sensor الصح
٦. لو الـ Impeller تالف، خذه للـ Machine Shop أو غيّره""",
    keywords: [
      "مضخة سكندري", "secondary pump", "low CHW supply", "AHU",
      "differential pressure sensor", "DP sensor", "2-way valve",
      "balance valve", "VFD PID", "ميه تبريد", "CHW pressure",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "sp-02",
    categoryId: "secondaryPumps",
    title: "مضخة السكندري الدرايف (VFD) بيشغل المضخة على 60Hz دايماً (No Speed Control)",
    warning: "⚠️ لو المضخة شغالة على السرعة القصوى دايماً، ده مفيش توفير طاقة وده بيزيد الاستهلاك والـ Wear على المضخة والموتور.",
    cause: "السبب: الـ VFD في الـ Manual Mode أو الـ Bypass Active، أو الـ PID Feedback Signal فالسة (الـ DP Sensor خربان)، أو الـ 4-20mA Signal من الـ BMS مقطوعة، أو الـ VFD Parameters اتـ Reset.",
    solution: """١. اتأكد من إن الـ VFD في الـ Auto/Remote Mode
٢. اتأكد من إن الـ Bypass Switch في وضع VFD (مش Bypass)
٣. قس الـ 4-20mA Signal من الـ DP Sensor بالـ Multimeter
٤. لو الـ Signal صفر، شيك السايكل والـ Sensor
٥. راجع الـ PID Parameters (P, I, D) في الـ VFD
٦. شغل المضخة وشوف الـ Frequency بيتغير مع الحمل ولا لأ""",
    keywords: [
      "VFD 60Hz", "no speed control", "PID", "4-20mA", "BMS signal",
      "bypass active", "VFD parameters", "manual mode", "مضخة سرعة ثابتة",
      "secondary pump VFD", "DP sensor", "remote mode",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "sp-03",
    categoryId: "secondaryPumps",
    title: "مضخة السكندري Seal بيحتاج تغيير كل فترة قصيرة (Frequent Seal Failure)",
    warning: "⚠️ لو الـ Seal بيتغير كل شهر أو أقل، في مشكلة أساسية مش مجرد Seal عادي! لازم تلاقي السبب الجذري.",
    cause: "السبب: الـ Shaft متآكل وفيه Groove، أو الـ Alignment مش كويس (Coupling misalignment)، أو الـ Pump Running Dry أحياناً، أو مية معالجة غلط (Chemicals قوية أوي)، أو الـ Shaft Runout عالي.",
    solution: """١. افحص الـ Shaft تحت الـ Seal — لو فيه Groove، اعمل Shaft Repair أو غيّر Shaft
٢. اعمل Laser Alignment بين الموتور والمضخة
٣. ركب Low Pressure Switch على الساكشن يوقف المضخة لو مفيش ميه
٤. شيك الـ Chemical Treatment واتأكد إن الـ Concentration في المجال الصح
٥. قس الـ Shaft Runout (ماش يكون أكتر من 0.002\")
٦. تأكد من إن الـ Seal Type مناسب للـ Application (Temperature, Pressure)""",
    keywords: [
      "seal failure", "frequent seal", "shaft groove", "alignment",
      "dry running", "chemical treatment", "shaft runout", "laser alignment",
      "مضخة سكندري", "seal type", "low pressure switch",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "sp-04",
    categoryId: "secondaryPumps",
    title: "النظام السكندري كله Pressure عالي (High Differential Pressure)",
    warning: "⚠️ الضغط العالي في الـ CHW System ممكن يفجر الـ AHU Coils أو يخلي الـ Valves ما تقدرش تفتح! خطير على المعدات.",
    cause: "السبب: الـ DP Sensor مكسور وبيدي قراءة واطية فالـ VFD بيزود السرعة، أو الـ Balancing Valve على الـ Return Line مقفول جزئياً، أو الـ 2-Way Valves كلها مقفولة (No Demand)، أو الـ BMS Setpoint غلط.",
    solution: """١. قس الـ Actual DP بـ Manual Gauge وقارنها بالـ Sensor Reading
٢. لو الـ Sensor فالس، Calibrate أو غيّره
٣. افتح الـ Balancing Valve على الـ Return (اتأكد إنه مش مقفول)
٤. اتأكد من إن الـ AHU Valals بتستجيب لأوامر الـ BMS
٥. راجع الـ DP Setpoint في الـ VFD أو الـ BMS (عادة ١-١.٥ بار)
٦. لو فيه 3-Way Bypass Valve، اتأكد إنها شغالة صح""",
    keywords: [
      "pressure عالي", "high DP", "AHU coil", "balancing valve",
      "DP sensor fault", "BMS setpoint", "3-way bypass valve",
      "مضخة سكندري", "high pressure", "CHW system",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "sp-05",
    categoryId: "secondaryPumps",
    title: "مضخة السكندري فيها Air وبتعمل Noise (Air in System / Air Binding)",
    warning: "⚠️ الهواء في نظام مية التبريد بيقلل كفاءة التبادل الحراري وبيسبب Noise وVibration. ممكن كمان يسبب Cavitation.",
    cause: "السبب: خزان التمدد (Expansion Tank) مستواه واطي أو فيه Air مش كافي، أو الـ Air Separator مش شغال، أو فيه Leak على الساكشن بيدخل هواء، أو بعد Fill/Refill النظام ماات_bleed_ش.",
    solution: """١. اتأكد من مستوى الميه والضغط في خزان التمدد
٢. Bleed الهواء من كل Air Vent في أعلى النظام
٣. شيك الـ Air Separator واتأكد إنه شغال والـ Air Eliminator مفصول بـ Automatic Air Vent
٤. ابحث عن أي Leak على خطوط الساكشن (أخصلح التسريبات)
٥. اتأكد من إن الـ Pre-Charge Pressure في الـ Expansion Tank صح
٦. بعد Bleeding، شغل المضخة وراقب لمدة ساعة""",
    keywords: [
      "هواء في النظام", "air binding", "air separator", "air vent",
      "expansion tank", "pre-charge", "bleed air", "مضخة سكندري",
      "air eliminator", "leak suction", "CHW system air",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "sp-06",
    categoryId: "secondaryPumps",
    title: "مضخة السكندري الموتور بيتحرق باستمرار (Repeated Motor Burnout)",
    warning: "⚠️ تكرار احتراق الموتور معناه إن في مشكلة خطيرة في النظام! محتاج تحليل شامل قبل ما تغيّر موتور تاني وتتكرر المشكلة.",
    cause: "السبب: الـ VFD Output مش نظيف (Harmonics عالية)، أو الـ Motor Size صغير على الحمل، أو الـ Insulation ضعيف من الرطوبة، أو الـ Single Phasing من الـ Contactor، أو الـ Ambient Temperature عالية.",
    solution: """١. قس الـ Output Voltage والـ Current من الـ VFD (اتأكد متوازنين)
٢. شيك الـ Motor Nameplate وقارنه بالـ Actual Load (لو أقل من 80% أو أكتر من 100% في مشكلة)
٣. ركب Protection Relay (Overload + Single Phase + Phase Reversal)
٤. اتأكد من الـ Motor Enclosure مناسب للـ Environment (IP55 على الأقل)
٥. شيك الـ Cable Size (لو صغير هيحترق من الـ Voltage Drop)
٦. لو الـ VFD فيه Harmonics، ركب Output Filter/Reactors""",
    keywords: [
      "motor burnout", "موتور بيتحرق", "harmonics", "VFD output",
      "single phasing", "overload relay", "motor insulation", "cable size",
      "voltage drop", "motor protection", "مضخة سكندري",
    ],
    severity: 'warning',
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // أبراج التبريد — COOLING TOWERS (6 faults)
  // ═══════════════════════════════════════════════════════════════════════════
  Fault(
    id: "ct-01",
    categoryId: "coolingTowers",
    title: "برج التبريد ميه الحوض بتنزل تحت (Low Basin Water Level)",
    warning: "⚠️ لو مستوى الحوض نزل تحت الـ Make-up Level، المضخات هتاخد هواء وده هيوقف الشيلرات كلها! مشكلة خطيرة.",
    cause: "السبب: الـ Make-up Valve مش بيفتح أو الـ Float Valve عالق، أو فيه تسريب كبير في الحوض، أو الـ Blowdown Valve مفتوح أوي، أو الـ Evaporation Rate أعلى من الـ Make-up Rate.",
    solution: """١. اتأكد من إن الـ Make-up Water Supply مفتوح والـ Pressure كافي
٢. شيك الـ Float Valve أو الـ Solenoid Valve — نظفها لو عالقة
٣. اتأكد من إن الـ Blowdown Valve مقفولة (لو فيه Automated System شيك الـ Controller)
٤. ابحث عن أي Leak في الحوض أو الـ Piping
٥. شيك الـ Level Controller واتأكد من الـ Setpoint
٦. لو النظام فيه Water Meter، قارن الـ Consumption بالـ Expected""",
    keywords: [
      "مستوى واطي", "low basin level", "make-up water", "float valve",
      "blowdown", "cooling tower basin", "evaporation", "water level",
      "برج تبريد حوض", "make-up valve", "solenoid valve",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "ct-02",
    categoryId: "coolingTowers",
    title: "فان برج التبريد بيسخن الموتور أو بيطلع Overload (Fan Motor Overload)",
    warning: "⚠️ لو فان البرج وقف، مية الكوندنسر هتسخن والشيلر هيقف على High Pressure! فان البرج هو قلب نظام التبريد.",
    cause: "السبب: الـ Fan Blades فيها Cracking أو Breakage وده بيزود الحمل، أو الـ Bearings تالفة وزيتها ناقص، أو الـ Fan Beltslack/slip (لو belt driven)، أو الـ VFD بتاع الفان فيه Problem، أو الـ Guide/Vanes مقفولة.",
    solution: """١. قف الفان وافحص الـ Blades (اتأكد مفيش Crack أو Break)
٢. شيك الـ Bearings — أضف Grease لو ناقصة أو غيّرها لو خشنة
٣. لو Belt Driven: شد الـ Belts واتأكد من الـ Tension (Deflection ½\" per foot)
٤. اتأكد من إن الـ VFD بيدي الـ Frequency الصح
٥. قس الـ Amps وقارنها بالـ Nameplate
٦. شيك الـ Air Flow — لو فيه Obstruction أمامه، أزله""",
    keywords: [
      "فان ساخن", "fan overload", "fan blades", "bearings", "belt slack",
      "VFD", "fan motor", "cooling tower fan", "overload",
      "برج تبريد فان", "fan belt", "air flow",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "ct-03",
    categoryId: "coolingTowers",
    title: "ميه برج التبريد بتبقى ساخنة أوي (High Approach Temperature)",
    warning: "⚠️ لو مية البرج نازلة ساخنة، الشيلر هيشتغل على Condenser Pressure عالي وده بيقلل الكفاءة وبيزود الاستهلاك.",
    cause: "السبب: الـ Fill Media (Packing) متلزقة أو متكسرة، أو الـ Water Distribution System مش متوزعة كويس (Nozzles مسدودة)، أو الـ Air Flow ضعيف (فان واقف أو بطيء)، أو الـ Wet Bulb Temperature عالية (جو حار أوي).",
    solution: """١. قس الـ Wet Bulb Temperature ودرجة حرارة ميه الدخول والخروج
٢. احسب الـ Approach (فرق بين مية الخروج والـ Wet Bulb — لازم يكون ٣-٥ درجات)
٣. لو الـ Approach عالي: نظف الـ Fill Media بالـ Chemical Cleaning
٤. نظف الـ Nozzles واتأكد من الـ Distribution Even
٥. اتأكد من إن الـ Fan يعمل الـ RPM الصح
٦. لو الـ Fill Media متكسرة، غيّر الجزء التالف""",
    keywords: [
      "ميه ساخنة", "high approach", "fill media", "nozzles",
      "wet bulb", "cooling tower performance", "water distribution",
      "برج تبريد ساخن", "approach temperature", "fill packing",
    ],
    severity: 'critical',
  ),
  Fault(
    id: "ct-04",
    categoryId: "coolingTowers",
    title: "برج التبريد بيبعت Mist/Drift على المباني اللي حواليه (Excessive Drift)",
    warning: "⚠️ الـ Drift معناها إن ميه بتطير من البرج وده بيأذي المباني المجاورة وبيضيع ميه. ممكن يكون مخالف للبيئة.",
    cause: "السبب: الـ Drift Eliminators متكسرة أو مفقودة، أو الـ Air Velocity عالية أوي داخل البرج، أو الـ Water Level في الحوض أعلى من المطلوب، أو الـ Nozzles بترش ميه كتير فوق.",
    solution: """١. فحص الـ Drift Eliminators واتأكد إنها سليمة ومركبة صح
٢. لو فيها كسور، غيّر الأجزاء التالفة
٣. قلل سرعة الفان لو الـ Air Velocity عالية
٤. خلي مستوى الحوض في المستوى الصحيح
٥. اتأكد من إن الـ Nozzles ما بترشش فوق الـ Drift Eliminators
٦. لو البرج قريب من مباني، ركب Drift Eliminators إضافية""",
    keywords: [
      "drift", "mist", "drift eliminator", "air velocity", "water level",
      "cooling tower drift", "nozzles spray", "برج تبريد رذاذ",
      "environmental", "eliminators",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "ct-05",
    categoryId: "coolingTowers",
    title: "برج التبريد بيبقى فيه Scale و Biofouling (Scaling / Legionella Risk)",
    warning: "⚠️ الـ Scale بيقلل التبادل الحراري بنسبة كبيرة! والـ Biofouling وخاصة الـ Legionella خطر صحي على الناس. المتابعة الدورية ضرورية!",
    cause: "السبب: الـ Water Treatment مش كويس (Chemicals ناقصة)، أو الـ Cycles of Concentration عالية أوي، أو الـ Blowdown مش كافي، أو الـ Fill Media وسخة من الـ Biological Growth.",
    solution: """١. خد عينة ميه وابعتها للـ Lab ( hardness, alkalinity, TDS, bacteria)
٢. اتأكد من الـ Chemical Dosing System (Biocide + Scale Inhibitor)
٣. شيك الـ Conductivity Controller واتأكد إن الـ Blowdown شغال
٤. لو فيه Scale على الـ Fill: اعمل Descaling بالـ Acid Cleaning
٥. لو فيه Biofouling: رش Biocide واعمل Shock Treatment
٦. نظف الحوض من الـ Sludge والـ Dirt""",
    keywords: [
      "scale", "biofouling", "legionella", "water treatment", "blowdown",
      "cycles of concentration", "chemical dosing", "descale", "biocide",
      "برج تبريد وسخ", "conductivity", "acid cleaning",
    ],
    severity: 'critical',
  ),
  Fault(
    id: "ct-06",
    categoryId: "coolingTowers",
    title: "برج التبريد هيكله بيهتز أو بيعمل Vibration (Structural Vibration)",
    warning: "⚠️ اهتزاز هيكل البرج ممكن يسبب Cracks في الـ Concrete أو الـ Steel Structure! ده خطر هيكولوجي.",
    cause: "السبب: الـ Fan Blade Imbalance، أو الـ Fan Motor Vibration بتنتقل للهيكل، أو الـ Structural Members تالفة أو الـ Bolts ناقصة، أو الـ Resonance مع الـ Fan RPM.",
    solution: """١. قف الفان وخد قراءة Vibration على الـ Fan Shaft والـ Motor
٢. اعمل Dynamic Balancing للـ Fan Blades
٣. شيك كل الـ Structural Bolts وشدها
٤. اتأكد من إن الـ Fan Speed مش بتسبب Resonance مع الهيكل
٥. لو فيه Cracks في الخرسانة أو الـ Steel، اعمل إصلاح هيكلي
٦. ركب Vibration Isolators تحت الـ Fan Motor لو مش موجودة""",
    keywords: [
      "structural vibration", "fan imbalance", "dynamic balancing",
      "resonance", "cooling tower structure", "fan blade", "cracks",
      "برج تبريد اهتزاز", "vibration isolator", "structural bolts",
    ],
    severity: 'info',
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // درايفات — VFD DRIVES (6 faults)
  // ═══════════════════════════════════════════════════════════════════════════
  Fault(
    id: "vd-01",
    categoryId: "drives",
    title: "الدرايف بيطلع Overcurrent Fault (OC / Overcurrent Trip)",
    warning: "⚠️ الـ Overcurrent معناه إن الحمل على الموتور زايد أو في Short Circuit! متعملش Reset من غير ما تعرف السبب، ممكن تحرق الدرايف!",
    cause: "السبب: الحمل على الموتور أكبر من الـ Rated (Mechanical Jam أو Blockage)، أو الـ Motor Cable فيه Short، أو الـ Motor نفسه تالف (Winding Short)، أو الـ Acceleration Time قصير أوي.",
    solution: """١. اقرأ الـ Fault Code وحدد إنه Overcurrent Instantaneous أو Overload
٢. افصل الموتور من الدرايف وقس الـ Insulation Resistance (Megger Test)
٣. لو الموتور سليم: شيك الحمل الميكانيكي (دور الـ Shaft باليد)
٤. زوّد الـ Acceleration Time في الـ VFD Parameters
٥. شيك الـ Current Limit Setting (عادة 110-150% من FLA)
٦. لو كل حاجة سليمة وش المشكلة مستمرة، ممكن يكون الـ IGBT Board فيه Problem""",
    keywords: [
      "overcurrent", "OC fault", "VFD trip", "short circuit", "IGBT",
      "acceleration time", "megger test", "motor winding", "current limit",
      "درايف تريب", "VFD error", "motor cable",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "vd-02",
    categoryId: "drives",
    title: "الدرايف بيسخن وبيطلع Overtemperature Fault (OH / Overheat)",
    warning: "⚠️ الدرايف لو سخن كتير ممكن تحرق الـ Power Electronics! وده إصلاح غالي جداً. اشتغل على التبريد فوراً.",
    cause: "السبب: فلاتر الهواء (Air Filters) وسخة ومسدودة، أو الـ Cooling Fan جوان الدرايف واقف، أو الـ Ambient Temperature عالية (أكتر من 40°C)، أو الـ Loading Cycle قاسي (Heavy Duty بدل Light Duty)، أو الـ Heatsink وسخ.",
    solution: """١. نظف فلاتر الهواء ولو محتاج غيرها
٢. شيك الـ Internal Cooling Fan — لو واقف غيّره
٣. اتأكد من إن الـ Ambient Temperature أقل من 40°C
٤. نظف الـ Heatsink بالهواء المضغوط (Compressed Air)
٥. شيك الـ Derating — لو الدرايف مش مصمم للـ Heavy Duty، اعتبر Upgrade
٦. لو الدرايف في Cabinet مغلق، ركب Exhaust Fan أو AC للـ Cabinet""",
    keywords: [
      "overheat", "VFD overheat", "OH fault", "air filter", "cooling fan",
      "heatsink", "ambient temperature", "IGBT cooling", "درايف سخن",
      "VFD temperature", "cabinet cooling",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "vd-03",
    categoryId: "drives",
    title: "الدرايف شغال والموتور بيدور بس سرعته ثابتة (No Speed Regulation)",
    warning: "⚠️ لو الدرايف مش بيغير السرعة، مفيش توفير طاقة والـ Control System كله مش بيشتغل زي المطلوب.",
    cause: "السبب: الـ Analog Input Signal (4-20mA) مفيش أو مقطوعة، أو الـ PID Settings غلط، أو الـ VFD في الـ Fixed Frequency Mode، أو الـ Feedback Signal فالسة، أو الـ Min/Max Frequency Parameters غلط.",
    solution: """١. قس الـ 4-20mA Input Signal بـ Multimeter (لو صفر = مشكلة في السايكل)
٢. شيك الـ Source Selector — اتأكد إنه في Terminal/Remote مش Keypad
٣. راجع الـ PID Parameters (P Gain, I Time, D Time)
٤. اتأكد من إن الـ Min Frequency مش = Max Frequency
٥. شيك الـ Feedback Signal (0-10V أو 4-20mA من الـ Sensor)
٦. جرب Manual Speed Control من الـ Keypad عشان تتأكد إن الدرايف نفسه شغال""",
    keywords: [
      "no speed control", "4-20mA", "PID settings", "analog input",
      "VFD parameters", "feedback signal", "fixed frequency",
      "درايف سرعة ثابتة", "terminal mode", "keypad mode",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "vd-04",
    categoryId: "drives",
    title: "الدرايف بيطلع DC Bus Undervoltage (UV / DC Bus Low)",
    warning: "⚠️ الـ Undervoltage ممكن يكون من مشكلة في الـ Power Supply. لو الشبكة فيها Problem، الدرايف ممكن يتضرر.",
    cause: "السبب: الـ Input Voltage واطي من الـ Minimum (عادة أقل من 380V لـ 400V Class)، أو الـ Main Contactor أو الـ MCCB فيه Problem، أو الـ DC Bus Capacitors ضعيفة، أو الـ Power Cable رفيع أو طويل أوي (Voltage Drop).",
    solution: """١. قس الـ Input Voltage على الـ L1, L2, L3 واتأكد متوازنين ومفيش Phase Missing
٢. شيك الـ Main Contactor Contacts والـ MCCB
٣. لو الـ Cable طويل أو رفيع، اعتبر كبر الـ Cable Size
٤. شيك الـ DC Bus Voltage على الشاشة (لازم تكون ~1.35 × AC Input)
٥. لو الـ Capacitors انتفخت أو سالت، الدرايف محتاج Board Repair
٦. ركب Voltage Stabilizer أو UPS لو الشبكة غير مستقرة""",
    keywords: [
      "undervoltage", "DC bus", "UV fault", "input voltage", "contactor",
      "MCCB", "capacitor", "voltage drop", "power supply",
      "درايف فولت واطي", "phase missing", "DC bus voltage",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "vd-05",
    categoryId: "drives",
    title: "الدرايف بيطلع Ground Fault / Earth Fault (GF)",
    warning: "⚠️ الـ Ground Fault معناه إن فيه كهرباء بتروح للأرض! ده خطر على حياة الناس اللي شغالين على المعدات.",
    cause: "السبب: كابل الموتور فيه Insulation ضعيف وسايبه للأرض، أو الموتور نفسه فيه Winding إلى Ground، أو ميه دخلت في الـ Conduit أو الـ Junction Box، أو الـ Drive Output فيه Problem.",
    solution: """١. افصل كابل الموتور من الدرايف
٢. اعمل Megger Test على كابل الموتور (لازم يكون أكتر من 1MΩ)
٣. لو الكابل سليم: اعمل Megger على الموتور نفسه
٤. افتح الـ Junction Box واتأكد مفيش ميه أو رطوبة
٥. لو لقيت المشكلة في الكابل: غيّر الجزء التالف
٦. لو الموتور فيه Ground Fault، محتاج Rewinding أو Change""",
    keywords: [
      "ground fault", "earth fault", "GF", "megger test", "insulation",
      "motor winding", "junction box", "cable insulation", "moisture",
      "درايف أرضي", "ground leakage", "rewinding",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "vd-06",
    categoryId: "drives",
    title: "الدرايف بيطلع Communication Fault مع الـ BMS (Comm Loss)",
    warning: "⚠️ لو الدرايف فقد الاتصال بالـ BMS، المحطة كلها ممكن تضل تعمل أو تقف! الـ Control System هيشتغل على الـ Last Known State.",
    cause: "السبب: كابل الـ Communication (RS485 / Modbus / BACnet) مقطوع أو مفصول، أو الـ Termination Resistors مفقودة، أو الـ Baud Rate / Address غلط، أو الـ Communication Card في الدرايف عطلت، أو الـ EMF Interference من كابلات الطاقة.",
    solution: """١. شيك كابل الـ Communication واتأكد إنه موصول كويس (RS485: A, B, GND)
٢. اتأكد من الـ Termination Resistors (120Ω) في أول وآخر الكابل
٣. تأكد من الـ Baud Rate والـ Protocol متطابقين بين الدرايف والـ BMS
٤. شيك الـ Device Address — مايكونش مكرر
٥. ابعد كابل الـ Communication عن كابلات الطاقة (لو ممكن)
٦. لو فيه Error في الـ Comm Card، غيّرها""",
    keywords: [
      "communication fault", "RS485", "Modbus", "BACnet", "BMS",
      "baud rate", "termination resistor", "comm loss", "EMF interference",
      "درايف اتصال", "communication card", "device address",
    ],
    severity: 'warning',
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // صمامات — VALVES (6 faults)
  // ═══════════════════════════════════════════════════════════════════════════
  Fault(
    id: "vl-01",
    categoryId: "valves",
    title: "الـ 2-Way Control Valve على الـ AHU مش بتتحرك (Valve Stuck)",
    warning: "⚠️ لو الـ Valve مش بتتحرك، الـ AHU مش هيبرد أو هيبرد أوي! ده بيأثر على درجة حرارة المكان كله.",
    cause: "السبب: الـ Actuator تالف أو الـ Power وصلش له، أو الـ Valve Stem عالق من الـ Scale/Debris، أو الـ 0-10V أو 4-20mA Signal من الـ Controller مش واصلة، أو الـ Spring Return ضعيفة.",
    solution: """١. قس الـ Control Signal (0-10V أو 4-20mA) على الـ Actuator
٢. شيك الـ Power Supply للـ Actuator (24VAC عادة)
٣. حاول تحرك الـ Valve Manual Lever — لو مش بتتحرك: Stem عالق
٤. لو Stem عالق: افك الـ Valve وClean الـ Stem والـ Packing
٥. لو Actuator ميت: أصلحه أو غيّره (تأكد من الـ Torque Rating)
٦. بعد الإصلاح، اتأكد من الـ Full Stroke (0% إلى 100%)""",
    keywords: [
      "valve stuck", "2-way valve", "actuator", "control valve",
      "0-10V", "4-20mA", "AHU valve", "valve stem", "spring return",
      "صمام عالق", "actuator تالف", "valve stroke",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "vl-02",
    categoryId: "valves",
    title: "صمام الـ Pressure Independent Control Valve (PICV) مش بيحافظ على الـ Flow",
    warning: "⚠️ الـ PICV لو مش شغال كويس، الـ Flow بيروح لبعض الـ AHUs ويقل عن غيرهم وده بيخلي التبريد غير متوازن.",
    cause: "السبب: الـ PICV الداخلي فيه Blockage (Debris/Scale)، أو الـ Differential Pressure أقل من الـ Minimum المطلوب (عادة 15-30 kPa)، أو الـ Actuator مش مضبوط كويس، أو الـ Valve Size كبير أوي على الـ Design Flow.",
    solution: """١. قس الـ Flow Meter وقارن بـ Design Flow
٢. اتأكد من إن الـ DP Across Valve أكبر من الـ Minimum المطلوب
٣. لو فيه Blockage: نظف الـ PICV أو غيّر الـ Cartridge
٤. شيك الـ Actuator Stroke واتأكد من الـ Calibration
٥. لو الـ Valve Size كبير أوي، ممكن تحتاج تصغرها
٦. ركب Strainer upstream للـ PICV عشان تمنع الـ Debris""",
    keywords: [
      "PICV", "pressure independent", "flow control", "AHU flow",
      "valve blockage", "differential pressure", "actuator calibration",
      "صمام PICV", "flow meter", "cartridge", "strainer",
    ],
    severity: 'info',
  ),
  Fault(
    id: "vl-03",
    categoryId: "valves",
    title: "صمام الـ 3-Way Bypass Valve مش بتشتغل (Bypass Valve Stuck)",
    warning: "⚠️ الـ Bypass Valve لو مش شغالة، ضغط الـ CHW ممكن يوصل لحد خطير لما كل الـ AHU Valves تقفل!",
    cause: "السبب: الـ Actuator تالف أو الـ Signal مش واصلة، أو الـ Valve Body فيها Debris وتالعق الـ Ball/Plug، أو الـ BMS مش بيرسل أمر Bypass لما كل الـ Valves تقفل.",
    solution: """١. قس الـ Signal على الـ Actuator (0-10V أو 4-20mA)
٢. شيك الـ BMS Logic — لازم يفتح الـ Bypass لما الـ DP عالي
٣. حاول تحرك الـ Valve Manual (لو مش بتتحرك = Mechanical Problem)
٤. نظف الـ Valve Body من الـ Debris/Scale
٥. لو Actuator ميت: غيّره (تأكد من الـ Fail Position: NC أو NO)
٦. اعمل Functional Test: قفل كل الـ AHU Valves وشوف الـ Bypass بتفتح ولا لأ""",
    keywords: [
      "3-way valve", "bypass valve", "valve stuck", "actuator",
      "BMS logic", "fail position", "NC valve", "NO valve",
      "صمام بايباس", "bypass logic", "DP control",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "vl-04",
    categoryId: "valves",
    title: "صمام الـ Butterfly Valve على خط الـ CHW مش بتقفل تمام (Passing Valve)",
    warning: "⚠️ الصمام لو بيخرج ميه وهو مقفول (Passing)، ده بيخلّي الـ Flow مايتحكمش بيها وده بيأثر على الـ Balancing.",
    cause: "السبب: الـ Disc مش بيكمل إغلاق من الـ Scale أو الـ Debris، أو الـ Seat/Wafer تالف، أو الـ Handle/Gear Operator فيه Wear، أو الـ Valve مااتـ Lapped_ش كويس.",
    solution: """١. افتح الـ Valve ونظف الـ Disc والـ Seat كويس
٢. شيك الـ Seat — لو فيه Tear أو Cut، غيّر الـ Seat Ring
٣. اتأكد من إن الـ Handle بيكمل الـ Close Position (Locked)
٤. لو Gear Operator: شيك الـ Gearbox والـ Stem Connection
٥. لو مش مقدر تصلحها: غيّر الـ Valve بالكامل
٦. اعمل Pressure Test بعد الإصلاح (لازم يكون Zero Leakage عند Close)""",
    keywords: [
      "passing valve", "butterfly valve", "valve leaking", "disc",
      "seat ring", "gear operator", "valve lapping", "pressure test",
      "صمام بيخرج", "butterfly passing", "zero leakage",
    ],
    severity: 'info',
  ),
  Fault(
    id: "vl-05",
    categoryId: "valves",
    title: "صمام الـ Balancing Valve في مشكلة — Flow مش متوازن (System Unbalanced)",
    warning: "⚠️ النظام لو مش متوازن، بعض الأماكن هتكون باردة أوي وبعضها مش مبردة خالص! ده أكبر شكوى من العملاء.",
    cause: "السبب: الـ Balancing Valves اتضبطت مرة واحدة واتحركت بعدين ( vandalism أو بالغلط)، أو الـ System Design اتغير (إضافة AHU جديدة)، أو الـ Differential Pressure متغير، أو الـ Valve Tape/Memory gauge متآكل.",
    solution: """١. اعمل Pressure Independent Measurement لكل Branch بالـ Flow Meter
٢. ابدأ من الـ Index Run (أبعد نقطة) واتوازن لفوق
٣. أعد ضبط كل الـ Balancing Valves حسب الـ Design Flow
٤. لو فيه AHU جديدة: اعمل Re-balancing للنظام كله
٥. ركب Readout Valves بدل الـ Manual لو الميزانية تسمح
٦. وثّق كل الـ Settings وخليها في ملف الصيانة""",
    keywords: [
      "balancing valve", "system unbalanced", "flow balancing", "index run",
      "design flow", "readout valve", "CHW balancing", "AHU balancing",
      "صمام توازن", "flow meter", "re-balancing",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "vl-06",
    categoryId: "valves",
    title: "صمام Check Valve (Non-Return) بيخرج ميه في الاتجاه العكسي (Reverse Flow)",
    warning: "⚠️ الـ Check Valve لو مش شغالة، ممكن المضخة تلف ومش تقدر تبدا Priming، أو الـ Flow يرجع بالعكس في النظام.",
    cause: "السبب: الـ Disc/Swing مش بيرجع لـ Seat، أو فيه Debris بين الـ Seat والـ Disc، أو الـ Spring ضعيفة (لو Spring Loaded)، أو الـ Internal Parts تالفة من الـ Water Hammer.",
    solution: """١. قف النظام وافحص الـ Check Valve من جوه
٢. نظف الـ Seat والـ Disc من أي Debris
٣. لو الـ Spring ضعيفة: غيّر الـ Spring
٤. لو الـ Disc مكسور أو متآكل: غيّر الـ Check Valve
٥. اتأكد من إن مفيش Water Hammer في النظام (ركب Surge Arrester لو لازمة)
٦. جرب تهبط الميه واتأكد إن الـ Valve بتنزلق وتقفل كويس""",
    keywords: [
      "check valve", "non-return valve", "reverse flow", "water hammer",
      "disc", "spring loaded", "surge arrester", "صمام نون ريتورن",
      "check valve leaking", "backflow", "swing check",
    ],
    severity: 'warning',
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // معالجة مياه — WATER TREATMENT (6 faults)
  // ═══════════════════════════════════════════════════════════════════════════
  Fault(
    id: "wt-01",
    categoryId: "waterTreatment",
    title: "ماء الشيلد (CHW) فيها Corrosion والـ Pipes بتتآكل (Corrosion Problem)",
    warning: "⚠️ الـ Corrosion بيأكل الـ Pipes والـ Coils من جوه وده ممكن يسبب Flood في المبنى! لو شفت صدأ في الـ Draining Water، المشكلة خطيرة.",
    cause: "السبب: الـ pH واطي (أقل من 8)، أو مفيش Inhibitor كافي، أو الـ Dissolved Oxygen عالي (نظام مفتوح أو Air Leak)، أو الـ Galvanic Corrosion من مواد مختلفة في النظام، أو الـ Velocity واطية أو عالية.",
    solution: """١. خد عينة ميه وابعتها للـ Lab (pH, TDS, Iron, Copper, Oxygen)
٢. عدّل الـ pH بـ Sodium Hydroxide لحد 8.5-9.5
٣. زوّد جرعة الـ Corrosion Inhibitor (Zinc/Phosphate أو Molybdate)
٤. اتأكد من إن النظام مقفول ومفيش Air Entry
٥. ابحث عن أي Dissimilar Metals Contact (Dielectric Union)
٦. ركب Corrosion Coupons وراقب الـ Corrosion Rate شهرياً""",
    keywords: [
      "corrosion", "صدأ", "pH", "inhibitor", "dissolved oxygen",
      "galvanic corrosion", "corrosion coupon", "CHW corrosion",
      "معالجة ميه", "sodium hydroxide", "molybdate", "dielectric",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "wt-02",
    categoryId: "waterTreatment",
    title: "ماء الكوندنسر فيها Scale وبتسد الـ Tubes (Scaling / Hardness Problem)",
    warning: "⚠️ الـ Scale بيزود الـ Thermal Resistance وبيقلل كفاءة التبادل الحراري بنسبة 30-50%! ده معناه فاتورة كهرباء أعلى وأداء أقل.",
    cause: "السبب: الـ Hardness (Calcium/Magnesium) عالية، ودرجة الحرارة عالية بتسبّب Precipitation، أو الـ Cycles of Concentration عالية أوي (Blowdown مش كافي)، أو الـ pH عالي.",
    solution: """١. خد عينة ميه واقيس الـ Hardness (ppm CaCO₃) والـ TDS
٢. اتأكد من إن الـ Cycles of Concentration 3-5 (مش أكتر)
٣. شيك الـ Blowdown Controller واعمل Calibration
٤. زوّد جرعة الـ Scale Inhibitor (Phosphonate أو Polymer)
٥. لو فيه Scale فعلاً: اعمل Acid Cleaning للـ Condenser Tubes
٦. ركب Water Softener لو الـ Make-up Water hardness عالية""",
    keywords: [
      "scale", "hardness", "calcium", "blowdown", "cycles of concentration",
      "scale inhibitor", "acid cleaning", "water softener", "condenser scale",
      "معالجة ميه", "TDS", "precipitation", "phosphonate",
    ],
    severity: 'critical',
  ),
  Fault(
    id: "wt-03",
    categoryId: "waterTreatment",
    title: "الـ Dosing Pump مش بتضخ الـ Chemical كويس (Chemical Dosing Problem)",
    warning: "⚠️ لو الـ Chemical مش بيتضخ، النظام كله بيكون بدون حماية! الـ Scale والـ Corrosion والـ Biological Growth هتحصل.",
    cause: "السبب: الـ Dosing Pump Diaphragm تالفة، أو الـ Suction Line مسدودة (Chemical crystallized)، أو الـ Relief Valve مفتوح، أو الـ Pump Stroke Length صفر، أو الـ Chemical Tank فاضي.",
    solution: """١. اتأكد من إن الـ Chemical Tank فيه Chemical كافي
٢. شيك الـ Stroke Length Setting على الـ Pump (في المجال الصح)
٣. افتح الـ Suction Line ونظفها من أي Crystal/Blockage
٤. شيك الـ Diaphragm — لو ممزقة غيّر الـ Pump Head
٥. تأكد من إن الـ Injection Point مفتوح ومفيش Blockage
٦. اتأكد من إن الـ Pump Rate متوافق مع الـ Make-up Water Flow""",
    keywords: [
      "dosing pump", "chemical dosing", "diaphragm", "stroke length",
      "chemical pump", "injection point", "crystallization",
      "معالجة ميه", "dosing problem", "chemical tank",
    ],
    severity: 'info',
  ),
  Fault(
    id: "wt-04",
    categoryId: "waterTreatment",
    title: "النظام فيه Biological Growth و Algae — ميه خضرا (Biofouling)",
    warning: "⚠️ الـ Biological Growth مش بس بتقلل الكفاءة — الـ Legionella البكتيريا ممكن تسبب مرض خطير (Legionnaires' Disease)! خطر صحي.",
    cause: "السبب: الـ Biocide جرعة مش كافية أو الـ Dosing System واقفة، أو الـ Dead Legs في النظام (أماكن ميه راكدة)، أو الـ UV System واقفة (لو موجودة)، أو الـ Temperature مناسبة للبكتيريا (25-45°C).",
    solution: """١. خد عينة وابعتها للـ Lab للـ Bacteria Count (Heterotrophic + Legionella)
٢. لو موجودة بكتيريا: اعمل Shock Dosing بالـ Chlorine أو Oxidizing Biocide
٣. نظف الـ Cooling Tower Basin وكل الـ Dead Legs
٤. اتأكد من إن الـ Routine Biocide Dosing شغالة كل يوم
٥. لو فيه UV System: غيّر الـ UV Lamp (كل 9000 ساعة)
٦. نظف الـ Strainers والـ Filters في النظام""",
    keywords: [
      "biofouling", "algae", "legionella", "biocide", "bacteria",
      "shock dosing", "UV system", "dead legs", "chlorine",
      "معالجة ميه", "biological growth", "heterotrophic",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "wt-05",
    categoryId: "waterTreatment",
    title: "الـ Conductivity Controller مش بيcontrolled Blowdown كويس (Blowdown Problem)",
    warning: "⚠️ لو الـ Blowdown مش شغال، الـ TDS هتزيد والـ Scale هيتكون بسرعة! ولو الـ Blowdown كتير أوي، ده إهدار للميه والـ Chemicals.",
    cause: "السبب: الـ Conductivity Sensor وسخ أو متآكل، أو الـ Blowdown Valve عالقة (مفتوحة أو مقفولة)، أو الـ Setpoint غلط (عالي أو واطي)، أو الـ Controller نفسه عطلان.",
    solution: """١. شيك الـ Conductivity Sensor ونظفه (Calibrate بالـ Standard Solution)
٢. قس الـ Conductivity بـ Manual Meter وقارن بالـ Controller Reading
٣. شيك الـ Blowdown Solenoid Valve — افكها ونظفها
٤. اتأكد من الـ Setpoint (عادة 3000-4000 µS/cm لـ Cooling Tower)
٥. لو الـ Controller عطلان: أصلحه أو غيّره
٦. راقب الـ Make-up Water Consumption بعد الإصلاح""",
    keywords: [
      "conductivity", "blowdown", "TDS", "conductivity controller",
      "solenoid valve", "make-up water", "sensor calibration",
      "معالجة ميه", "µS/cm", "blowdown valve",
    ],
    severity: 'info',
  ),
  Fault(
    id: "wt-06",
    categoryId: "waterTreatment",
    title: "ماء النظام فيها Foam / Bubbles كتير (Foaming Problem)",
    warning: "⚠️ الـ Foaming معناه إن فيه Contamination في النظام! ممكن يكون Oil أو Soap أو Chemical زايد. ده بيأثر على التبادل الحراري.",
    cause: "السبب: Oil من الـ Compressor Leak ووصل للميه، أو الـ Chemical Dosing زايدة أوي (أخصلح Overdosing)، أو الـ Water ملوثة بـ Organic Matter، أو الـ System فيه Air كتير.",
    solution: """١. خد عينة ميه وشوف اللون والرائحة (لو فيها Oil = مشكلة شيلر)
٢. اتأكد من إن مفيش Oil Leak من الـ Chiller Evaporator
٣. قلل جرعة الـ Chemical (خصوصاً الـ Polymers)
٤. أضف Anti-Foam Chemical لو المشكلة مستمرة
٥. Bleed الهواء من النظام كويس
٦. لو الميه ملوثة: اعمل Partial Drain و Refill بـ Clean Water""",
    keywords: [
      "foaming", "foam", "oil leak", "overdosing", "anti-foam",
      "contamination", "organic matter", "water treatment",
      "معالجة ميه", "foam problem", "chiller oil leak",
    ],
    severity: 'warning',
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // خزان التمدد — EXPANSION TANK (5 faults)
  // ═══════════════════════════════════════════════════════════════════════════
  Fault(
    id: "et-01",
    categoryId: "expansionTank",
    title: "خزان التمدد الضغط بتاعه واطي أو صفر (Lost Pre-charge)",
    warning: "⚠️ لو الـ Pre-charge ضاعت، الخزان ممكن يبقى مليان ميه ومفيش Air Cushion! وده معناه إن النظام مش هي absorb الـ Expansion والـ Pressure هيطلع لحد خطير.",
    cause: "السبب: الـ Air Valve (Schrader) على الخزان بتسرب Air، أو الـ Bladder/Diaphragm ممزقة، أو محدش فحص الـ Pre-charge من فترة طويلة، أو الـ System Pressure أعلى من الـ Tank Rating.",
    solution: """١. قف النظام واتأكد من إن الـ System Pressure صفر
٢. فحص الـ Pre-charge بالـ Tire Gauge على الـ Schrader Valve
٣. لو الـ Pre-charge واطية: أضف Nitrogen (مش Air عادي!) للحد المطلوب
٤. الـ Pre-charge لازم = System Static Head + 3-5 PSI
٥. لو مفيش استجابة = الـ Bladder ممزقة، غيّر الخزان
٦. فحص الـ Pre-charge كل ٦ أشهر على الأقل""",
    keywords: [
      "pre-charge", "expansion tank", "nitrogen", "schrader valve",
      "bladder", "diaphragm", "system pressure", "static head",
      "خزان تمدد", "air cushion", "tank pressure",
    ],
    severity: 'critical',
  ),
  Fault(
    id: "et-02",
    categoryId: "expansionTank",
    title: "خزان التمدد مليان ميه بالكامل — مفيش Air Cushion (Waterlogged Tank)",
    warning: "⚠️ الخزان لو مليان ميه ومفيش Air، ده معناه إن الـ Pressure Relief Valve على النظام هيطلع كل شوية! وده بيضيع ميه وبيقلل مستوى النظام.",
    cause: "السبب: الـ Bladder انفجرت أو تمزقت، أو الـ Pre-charge ضاعت مع الوقت، أو الـ Tank Size صغير على حجم النظام، أو الـ Air Vent على الخزان مش شغالة.",
    solution: """١. قس الـ System Pressure عند Cold (Static Condition)
٢. لو الضغط على الساخن بيعمل يتغير كتير = الخزان مش شغال
٣. فحص الـ Pre-charge — لو صفر = Bladder ممزقة
٤. لو Bladder ممزقة: غيّر الخزان بالكامل (مفيش إصلاح للـ Bladder عادة)
٥. لو الخزان صغير: احسب الـ Tank Size المطلوب وحط واحد أكبر
٦. بعد التركيب: اتأكد من الـ System Pressure في Cold والـ Hot Condition""",
    keywords: [
      "waterlogged", "expansion tank full", "no air cushion", "bladder burst",
      "pressure relief valve", "tank size", "system pressure",
      "خزان تمدد مليان", "PRV", "tank replacement",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "et-03",
    categoryId: "expansionTank",
    title: "النظام Pressure عالي ومبيش مع خزان التمدد (High System Pressure)",
    warning: "⚠️ الضغط العالي ممكن يفجر الـ AHU Coils أو الـ Heat Exchangers! لو الـ PRV بتنزل ميه باستمرار، في مشكلة حقيقية.",
    cause: "السبب: خزان التمدد صغير أو عطلان، أو الـ Fill Pressure عالي أوي (الـ Pressure Reducing Valve مش مضبوط)، أو الـ Check Valve بين الخزان والنظام مسدودة، أو الـ Temperature في النظام أعلى من التصميم.",
    solution: """١. اتأكد من إن الـ Expansion Tank مش Waterlogged ( Fault ET-02)
٢. شيك الـ PRV (Pressure Reducing Valve) على خط الـ Fill — عدّلها
٣. اتأكد من إن الـ Isolation Valve بين الخزان والنظام مفتوحة
٤. قس الـ System Pressure في الـ Cold Condition (لازم = Static Head + Pre-charge)
٥. لو الخزان صغير: احسب الحجم المطلوب وركب واحد تاني بالتوازي
٦. شيك كل الـ PRVs (Safety Valves) واتأكد إنها شغالة""",
    keywords: [
      "high pressure", "system pressure", "PRV", "safety valve",
      "fill pressure", "pressure reducing valve", "expansion tank",
      "خزان تمدد", "system overpressure", "isolation valve",
    ],
    severity: 'critical',
  ),
  Fault(
    id: "et-04",
    categoryId: "expansionTank",
    title: "الـ Air Separator مش بيشتغل كويس — هواء في النظام (Air Eliminator Problem)",
    warning: "⚠️ الهواء في النظام بيسبب Noise في المضخات وبيقلل التبادل الحراري وبيسبب Corrosion! نظام مية التبريد لازم يكون Air-Free.",
    cause: "السبب: الـ Air Separator الداخلي وسخ أو مسدود، أو الـ Automatic Air Vent على فوقه واقفة، أو الـ Flow Velocity أقل من الـ Design (الـ Separator مش بيشتغل كويس)، أو مفيش Air Separator أصلاً في التصميم.",
    solution: """١. شيك الـ Automatic Air Vent — لو مش بتنزل ميه/هواء، نظفها أو غيّرها
٢. افتح الـ Air Separator وشيك الـ Internal Baffles (نظفها لو وسخة)
٣. اتأكد من إن الـ Flow Rate أكبر من الـ Minimum المطلوب للـ Separator
٤. Bleed الهواء من كل High Points في النظام يدوياً
٥. لو مفيش Air Separator: ركب واحد في الـ Return Line قريب الـ Expansion Tank
٦. راقب النظام لأسبوع واتأكد من إن الهواء اتصرف""",
    keywords: [
      "air separator", "air eliminator", "automatic air vent", "high point",
      "air in system", "baffles", "return line", "expansion tank",
      "خزان تمدد", "هواء في النظام", "air bleeding",
    ],
    severity: 'warning',
  ),
  Fault(
    id: "et-05",
    categoryId: "expansionTank",
    title: "خزان التمدد بيتكلم — بيسبب Water Hammer في النظام (Water Hammer)",
    warning: "⚠️ الـ Water Hammer ضغطه ممكن يوصل ١٠ أضعاف الضغط العادي! ده ممكن يفجر الـ Pipes والـ Valves. خطر حقيقي!",
    cause: "السبب: الـ Check Valves بتقفل بقوة (No Cushioning)، أو الـ Pump Stop مفاجئ (بدون Ramp-Down)، أو مفيش Expansion Tank أو حجمها صغير، أو الـ Air Chambers/Tank مش موجودة عند الـ Quick Closing Valves.",
    solution: """١. ركب الـ Non-Slam Check Valves بدل الـ Standard (Spring Loaded أو Dual Plate)
٢. لو فيه VFD على المضخات: زوّد الـ Deceleration Time
٣. اتأكد من إن خزان التمدد حجمه كافي
٤. ركب Surge Arrester أو Air Chamber عند كل الـ Quick Closing Valves
٥. شد كل الـ Pipe Supports و Clamps (مفيش Movement في الـ Pipes)
٦. لو فيه Water Hammer مستمر: اعمل Surge Analysis واعرف السبب الدقيق""",
    keywords: [
      "water hammer", "surge", "non-slam check valve", "air chamber",
      "surge arrester", "VFD deceleration", "pipe support", "quick closing",
      "خزان تمدد", "water hammer noise", "surge analysis",
    ],
    severity: 'critical',
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // أعطال مخصصة لمحطة ترين CVHF1300 — TRANE CENTRAVAC SPECIFIC FAULTS
  // ═══════════════════════════════════════════════════════════════════════════

  Fault(
    id: "ch-09",
    categoryId: "chillers",
    title: "الشيلر بيعمل Surge (سيرج - تذبذب الضغط) على الحمل الواطي",
    warning: "⚠️ السيرج (Surge) ده تذبذب في الضغط بيعمل صوت زززز وده ممكن يدمر الـ Impeller (العجلة) والـ Bearings (المحامل) في دقايق! لو السيرج مستمر أكتر من 30 ثانية قف الشيلر فوراً!",
    cause: "السبب: الحمل على الشيلر قليل أوي (Low Load - حمل واطي) والـ Guide Vanes (ريش المدخل) مش بتتحكم كويس، أو الـ Condenser Pressure (ضغط المكثف) عالي، أو الـ Hot Gas Bypass (صمام التحويل) مش شغال.",
    solution: """١. قف السيرج فوراً — افتح الـ Hot Gas Bypass (صمام تحويل الغاز الساخن) لو موجود
٢. زوّد الحمل على الشيلر (شغّل Pumps مضخات و AHUs وحادات هواء)
٣. اتأكد من الـ Guide Vane Position (وضع ريش المدخل) ماشي بالـ PID Output
٤. قلل الـ Condenser Pressure (ضغط المكثف) بنظف الكوندنسر أو زوّد مية التبريد
٥. اتأكد من الـ Surge Setpoint (نقطة السيرج) في الـ CH530 Controller
٦. لو السيرج مستمر اتعامل مع الـ OEM (الشركة الأم) لأن ده ممكن Impeller Problem""",
    keywords: ["سيرج", "surge", "تذبذب", "guide vanes", "hot gas bypass", "low load", "impeller", "centrifugal", "CH530", "سنترا فاك", "CenTraVac"],
    severity: 'critical',
  ),

  Fault(
    id: "ch-10",
    categoryId: "chillers",
    title: "شاشة CH530 Controller (التحكم) بتطلع Error Code (كود خطأ) مش معروف",
    warning: "⚠️ الـ Error Code (كود الخطأ) في الـ CH530 معناه إن في مشكلة حقيقية! متعملش Reset (ريست) كتير من غير ما تعرف السبب — ده ممكن يخفي المشكلة الحقيقية.",
    cause: "السبب: الـ Microprocessor Board (لوحة المعالج) فيها Problem، أو الـ Sensors (الحساسات) فالسة، أو الـ 24VDC Power Supply (مصدر الطاقة) ضعيف، أو الـ EEPROM Data (بيانات الذاكرة) اتمسحت.",
    solution: """١. سجل الـ Error Code (الكود) بالزبط من الشاشة
٢. راجع الـ Trane Service Manual (كتيب صيانة ترين) وابحث عن الكود
٣. لو الكود مش موجود، اتصل بـ Trane OEM Support (دعم ترين)
٤. شيك الـ 24VDC Power Supply للـ Controller Board (لوحة التحكم)
٥. اتأكد من الـ Sensor Readings (قراءات الحساسات) وإنها منطقية
٦. ريست من الـ Main Power (الباور الرئيسي) بس مرة واحدة بس""",
    keywords: ["CH530", "error code", "كود خطأ", "controller", "ترين", "Trane", "sensor", "EEPROM", "microprocessor"],
    severity: 'warning',
  ),

  Fault(
    id: "ch-11",
    categoryId: "chillers",
    title: "الفريون HFO-514A ناقص — Low Refrigerant Charge (شحن الفريون قليل)",
    warning: "⚠️ الفريون ناقص معناه في تسريب! غاز HFO-514A ده غالي أوي وممنوع يتسرب. كمان الشيلر مش هيبرد كويس والكمبريسور ممكن يحترق!",
    cause: "السبب: تسريب من الـ Evaporator Tubes (أنابيب المبخر) أو الـ Flanges (الفلانجات) أو الـ Schrader Valves (صمامات الشحن) أو الـ Relief Valve (صمام الأمان) بيفتح.",
    solution: """١. قف الشيلر واعمل Leak Test (اختبار تسريب) بـ Nitrogen (نيتروجين)
٢. استخدم Electronic Leak Detector (كاشف تسريب إلكتروني) على كل الـ Joints
٣. لو لقيت تسريب صلحه واعمل Evacuation (تفريغ) بالـ Vacuum Pump (مضخة تفريغ)
٤. شحن الفريون HFO-514A بالوزن الصح — 1500 lbs (680 kg) شحن المصنع
٥. قس الـ Subcooling (تحت التبريد) والـ Superheat (فوق التبريد) واتأكد صح
٦. سجل كمية الفريون اللي اتحطت و历史的 التسريب""",
    keywords: ["فريون ناقص", "HFO-514A", "leak test", "تسريب", "refrigerant", "evacuation", "vacuum", "subcooling", "superheat", "شحن فريون"],
    severity: 'critical',
  ),

  Fault(
    id: "ch-12",
    categoryId: "chillers",
    title: "سخان الزيت (Oil Heater) مش شغال — الزيت بيلزق والموتور بيسخن",
    warning: "⚠️ سخان الزيت (Oil Heater) لازم يشتغل 24 ساعة قبل تشغيل الشيلر! لو الزيت بارد وفيه فريون مختلط (Dilution - تخفيف) الكمبريسور هيتكسر!",
    cause: "السبب: الـ Oil Heater (سخان الزيت) 115V/750W احترق، أو الـ Contactor (الكونتاكتور) مش بيوصل التيار، أو الـ Thermostat (الترموستات) فالس.",
    solution: """١. قس الـ Voltage (الفولت) على الـ Oil Heater طرفين — لازم يكون 115V
٢. لو مفيش فولت: شيك الـ Contactor والـ Thermostat
٣. لو فيه فولت بس مش بيسخن: الـ Heater احترق — غيره
٤. قبل تشغيل الشيلر: خلي الـ Oil Heater يشتغل 24 ساعة
٥. اتأكد إن الزيت رجع للونه الطبيعي (مش رغوي — Foam يعني فيه فريون)
٦. سجل تاريخ تغيير الـ Oil Heater في سجل الصيانة""",
    keywords: ["سخان زيت", "oil heater", "زيت بارد", "dilution", "تخفيف", "contactor", "thermostat", "زيت رغوي"],
    severity: 'warning',
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // أعطال مخصصة لمضخات B&G — BELL & GOSSETT SPECIFIC FAULTS
  // ═══════════════════════════════════════════════════════════════════════════

  Fault(
    id: "pp-07",
    categoryId: "primaryPumps",
    title: "المضخة B&G بتسرب من الـ Mechanical Seal (السيل الميكانيكي) — تسريب مستمر",
    warning: "⚠️ التسريب أكتر من Drop/minute (قطره في الدقيقة) معناه الـ Seal (السيل) خلاص! لو خليت المضخة بتسرب كتير الميه توصل للموتور وتحرق.",
    cause: "السبب: الـ Seal Faces (وجوه السيل) اتآكلت من الـ Wear (التآكل)، أو الـ Shaft (العمود) فيه Groove (خدش)، أو المضخة اتشغلت Dry (من غير ميه) — ده بيحرق السيل في ثواني!",
    solution: """١. قف المضخة وافصل الباور فوراً
٢. افتح الـ Seal Chamber (غرفة السيل) وشوف وجوه السيل
٣. لو الـ Seal Faces خشنة أو محروقة — غيّر الـ Seal Assembly (طقم السيل) كله
٤. شيك الـ Shaft Runout (تمايل العمود) — لازم أقل من 0.002 بوصة
٥. اتأكد من الـ Alignment (المحاذاة) بين الموتور والمضخة
٦. بعد التركيب شغل المضخة وشوف التسريب — Drop/minute بس المقبول""",
    keywords: ["تسريب سيل", "mechanical seal", "B&G", "seal leakage", "seal faces", "dry running", "shaft runout", "بيل آند جوسيت"],
    severity: 'warning',
  ),

  Fault(
    id: "pp-08",
    categoryId: "primaryPumps",
    title: "المضخة B&G الكبيرة (3000 GPM) بتتعمل Cavitation (كافيتيشن — فقاعات بخار)",
    warning: "⚠️ الكافيتيشن (Cavitation) بيعمل صوت زي الحصى بيضرب جوا المضخة! ده بيكسر الـ Impeller (العجلة) والـ Seal (السيل) في وقت قصير. قف المضخة فوراً!",
    cause: "السبب: الـ NPSH Available (الضغط على الساكشن) أقل من الـ NPSH Required (الضغط المطلوب)، أو الـ Strainer (الفلتر) مسدود، أو الـ Suction Valve (صمام الساكشن) مقفول جزئياً.",
    solution: """١. قف المضخة فوراً لما تسمع صوت الكافيتيشن
٢. نظف الـ Strainer (الفلتر) على خط الساكشن بالكامل
٣. افتح الـ Suction Valve (صمام الساكشن) بالكامل
٤. اتأكد من مستوى الميه في الـ Expansion Tank (خزان التمدد)
٥. Bleed (نزع) الهواء من أعلى المضخة ومن الـ High Points (النقاط العالية)
٦. لو المشكلة مستمرة: شيك الـ NPSH وقارنه بالـ Pump Curve (منحنى المضخة)""",
    keywords: ["كافيتيشن", "cavitation", "NPSH", "strainer", "suction", "فقاعات", "صوت حصى", "B&G", "3000 GPM"],
    severity: 'critical',
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // أعطال مخصصة لمحركات FELM — FELM MOTOR SPECIFIC FAULTS
  // ═══════════════════════════════════════════════════════════════════════════

  Fault(
    id: "dr-07",
    categoryId: "drives",
    title: "محرك FELM بيسخن أوي والـ Surface Temperature (حرارة السطح) أعلى من 80°C",
    warning: "⚠️ الموتور لو سخن أكتر من 80°C على السطح يبقى في مشكلة! الـ Insulation Class F (فئة العزل) بيتحمل لحد 155°C جوا بس السطح لازم يكون أقل. لو سخن أكتر ممكن يحترق!",
    cause: "السبب: الحمل زايد (Overload)، أو الـ Bearings (المحامل) ناقصة شحم، أو الـ Ventilation (التهوية) مش كويس — الفان (المروحة) بتاعة التبريد واقفة، أو الـ Voltage (الفولت) واطي.",
    solution: """١. قس الـ Surface Temperature بـ IR Gun (مسدس حرارة بالأشعة تحت الحمراء)
٢. قس الـ Amps بـ Clamp Meter — لازم تكون أقل من الـ Nameplate Current
٣. شيك الـ Cooling Fan (مروحة التبريد) — لازم تدور وتدفع هواء
٤. شيك الـ Grease Nipples (بمبات الشحم) — ممكن محامل ناقصة شحم
٥. اتأكد من الـ Voltage (الفولت) — لو أقل من 380V يبقى في مشكلة في الشبكة
٦. لو الحرارة على الـ Bearings أعلى من 90°C — غيّر الـ Bearings فوراً""",
    keywords: ["موتور ساخن", "FELM", "overheat", "IR gun", "bearing temperature", "cooling fan", "surface temperature", "محرك بيسخن"],
    severity: 'critical',
  ),

  Fault(
    id: "dr-08",
    categoryId: "drives",
    title: "محرك FELM بيطلع Phase Imbalance (عدم توازن الأطوار) — تيار مش متساوي",
    warning: "⚠️ عدم توازن الأطوار (Phase Imbalance) بيسخن الموتور من جوا وبيقلل عمره أوي! لو الفرق أكتر من 2% لازم تصلح المشكلة فوراً.",
    cause: "السبب: الحمل على Phase (طور) واحد أكتر من التاني، أو الـ Connections (التوصيلات) فيها مشكلة، أو الـ Contactor (الكونتاكتور) نقاطه متآكلة، أو الـ Supply Voltage (جهد الشبكة) مش متوازن.",
    solution: """١. قس الـ Amps على الـ 3 Phases بـ Clamp Meter (أمبير كلامب)
٢. احسب الـ Phase Imbalance % = (أعلى تيار - المتوسط) / المتوسط × 100
٣. لو أكتر من 2%: شيك الـ Contactor Points (نقاط الكونتاكتور)
٤. قس الـ Phase Voltages (فولت كل طور) — لازم الفرق أقل من 2%
٥. شيك الـ Cable Connections (توصيلات الكابل) واتأكد إنها مش محترقة
٦. لو المشكلة من الـ Supply (الشبكة) — بلّغ الـ Electrical Dept (قسم الكهرباء)""",
    keywords: ["phase imbalance", "عدم توازن", "3 phases", "أطوار", "contactor", "FELM", "voltage imbalance", "تيار مش متساوي"],
    severity: 'warning',
  ),

  Fault(
    id: "dr-09",
    categoryId: "drives",
    title: "محامل الموتور FELM بتعمل صوت طحن — Bearings Failing (المحامل خربانة)",
    warning: "⚠️ صوت الطحن (Grinding Noise) من المحامل معناه خربانة ومحتاجة تتغير فوراً! لو خليتها الموتور هيقف ويمكن يحترق.",
    cause: "السبب: الـ Bearings (المحامل) اتآكلت من قلة الشحم أو كترته، أو دخلت ميه أو أوساخ جواها، أو الـ Misalignment (عدم محاذاة) بين الموتور والمضخة.",
    solution: """١. قف الموتور فوراً — متشغلوش تاني لحد ما تغير المحامل
٢. خد قراءة Vibration (اهتزاز) على الـ DE و NDE Bearings
٣. فك الموتور وابعت المحامل للـ Machine Shop (ورشة خراطة)
٤. ركب محامل جديدة من نفس النوع والـ Size (الحجم)
⑤. اعمل Alignment (محاذاة) جديد بين الموتور والمضخة
٦. شحم المحامل الجديدة بالشحم الصح CALTEX SRI-2""",
    keywords: ["محامل", "bearings", "صوت طحن", "grinding", "FELM", "misalignment", "vibration", "bearing failure"],
    severity: 'critical',
  ),

  // ═══════════════════════════════════════════════════════════════════════════
  // أعطال مخصصة لمعدات المحطة الحقيقية — STATION-SPECIFIC FAULTS
  // Trane CenTraVac CVHF1300 | B&G GLC & e-1510 | FELM Motors
  // ═══════════════════════════════════════════════════════════════════════════

  // ─── Trane CenTraVac CVHF1300 — أعطال الشيلر المخصصة ───
  Fault(
    id: "ch-13",
    categoryId: "chillers",
    title: "الشيلر بيعمل Surge (سيرج - تذبذب) — Trane CVHF1300",
    warning: "⚠️ السيرج (Surge) في الشيلر السنتروبيفوجل ده خطير جداً! بيحصل لما الحمل قل عن 30% من السعة. الكمبريسور بيلف من غير ما يقدر يدفع الفريون — ده بيسبب اهتزاز عالي وتلف في الـ Impeller (الريشة) والـ Bearings (المحامل). لو السيرج استمر أكتر من 30 ثانية قف الشيلر!",
    cause: "السبب: الحمل على الشيلر قل عن الـ Minimum Load (أقل حمل) وده بيحصل لما الـ CHW Return Temperature (حرارة رجوع الميه) قريبة من الـ Supply (الخروج)، أو الـ Inlet Guide Vanes (ريش المدخل) مقفولة أكتر من اللازم، أو الـ Hot Gas Bypass (صمام تحويل الغاز الساخن) مش شغال.",
    solution: """١. لو السيرج بيبقى شغال عادي — بس لو استمر أكتر من 30 ثانية قف الشيلر
٢. اتأكد إن الـ Hot Gas Bypass Valve شغال وبيفتح لما الحمل يقل
٣. شيك الـ Inlet Guide Vanes على شاشة CH530 — لازم تفتح تدريجياً
٤. لو الحمل قل أوي، شغل الشيلر على Low Load Mode من الـ CH530
٥. قس الـ CHW Delta T — لو أقل من 2°C يبقى الحمل قليل أوي
٦. راجع الـ Surge Line على الـ Compressor Map في الـ Service Manual""",
    keywords: ["سيرج", "surge", "تذبذب", "CVHF1300", "Trane", "سنترا فاك", "حمل قليل", "low load", "guide vanes", "hot gas bypass", "CH530"],
    severity: 'critical',
  ),
  Fault(
    id: "ch-14",
    categoryId: "chillers",
    title: "شاشة التحكم CH530 طلعت Error Code (كود خطأ) — Trane CVHF1300",
    warning: "⚠️ كل Error Code ليه معنى مختلف! متعملش Reset (ريست) كتير من غير ما تعرف السبب — ده ممكن يخفي مشكلة حقيقية ويخلي الشيلر يتكسر.",
    cause: "السبب: الأكواد الشايعة في الـ CH530 هي: E-01 (High Pressure - ضغط عالي)، E-02 (Low Pressure - ضغط واطي)، E-03 (Oil Pressure - ضغط زيت واطي)، E-04 (Motor Overload - حمل زايد)، E-05 (Surge - سيرج)، E-06 (Freeze Protection - حماية تجمد). كل كود ليه سبب مختلف.",
    solution: """١. سجل الـ Error Code بالزبط من شاشة CH530
٢. صورت الشاشة قبل أي حاجة — عشان ترجعها بعدين
٣. راجع الـ Error Code في الـ Service Manual (كتيب الصيانة) بتاع Trane
٤. E-01: شيك ميه الكوندنسر والـ Fans (ممكن وسخة)
٥. E-02: اعمل Leak Test — فريون ناقص
٦. E-03: شيك مستوى الزيت والـ Oil Filter
٧. E-04: قس الأمبير — ممكن حمل زايد
٨. E-05: ده سيرج — راجع عطل ch-13
٩. E-06: شيك الـ CHW Flow — ممكن Flow Switch بايظ
١٠. بعد إصلاح السبب، اعمل Reset واحد بس وشوف""",
    keywords: ["CH530", "error code", "كود خطأ", "Trane", "CVHF1300", "شاشة تحكم", "ريست", "reset", "E-01", "E-02", "E-03", "E-04", "E-05", "E-06"],
    severity: 'critical',
  ),
  Fault(
    id: "ch-15",
    categoryId: "chillers",
    title: "زيت الشيلر متخفف (Oil Dilution) — الفريون HFO-514A اختلط بالزيت",
    warning: "⚠️ Dilution (تخفيف الزيت) بيحصل لما الفريون HFO-514A بيمتزج مع الزيت وبيقلل لزوجته — ده بيخلي الزيت مش قادر يشحم الكمبريسور كويس والمحامل تتكسر! لازم تشيك مستوى الزيت كل أسبوع.",
    cause: "السبب: الـ Oil Heater (سخان الزيت) واقف أو بايظ، أو الشيلر وقف فترة طويلة من غير ما الـ Heater يشتغل، أو السوبرهيت Superheat واطي أوي فبيسمح لسائل الفريون يدخل الكمبريسور.",
    solution: """١. اتأكد إن الـ Oil Heater شغال لما الشيلر واقف — لازم يفضل شغل 4-8 ساعات قبل التشغيل
٢. قس لزوجة الزيت (Oil Viscosity) — لو أقل من الطبيعي يبقى فيه Dilution
٣. لو الزيت متخفف أوي: غير الزيت بالكامل واعمل Oil Flush (غسيل)
٤. غير الـ Oil Filter كمان — الفريون المختلط ممكن يكون لسه فيه
٥. شيك الـ Superheat — لازم يكون 4-7°C لضمان إن مفيش سائل بيدخل الكمبريسور
٦. راجع الـ Oil Analysis (تحليل الزيت) كل 6 شهور""",
    keywords: ["زيت متخفف", "oil dilution", "HFO-514A", "فريون", "زيت كمبريسور", "oil heater", "سخان زيت", "superheat", "سوبرهيت", "CVHF1300", "Trane"],
    severity: 'warning',
  ),
  Fault(
    id: "ch-16",
    categoryId: "chillers",
    title: "الشيلر مش بيبرد كويس و الـ Delta T (دلتا تي) أقل من 5°C — Trane CVHF1300",
    warning: "⚠️ الـ Delta T (الفرق بين حرارة دخول وخروج مية الشيلد) لازم يكون حوالي 5°C. لو أقل يبقى الشيلر مش بيبرد كويس — ده بيخلي المحطة كلها مش بتبرود والـ AHUs مش بتبرد الأماكن.",
    cause: "السبب: الـ Evaporator Tubes (أنابيب المبخر) لازجة من الـ Fouling (ترسبات)، أو فريون HFO-514A ناقص، أو الـ Guide Vanes مش بتفتح بالكامل، أو الحمل على الشيلر أقل من الـ Design.",
    solution: """١. قس الـ CHW Supply و Return Temperature وشوف الـ Delta T
٢. لو Delta T أقل من 4°C: اعمل Chemical Cleaning (تنظيف كيميائي) للـ Evaporator
٣. شيك مستوى الفريون بالـ Sight Glass والـ Subcooling/Superheat
٤. اتأكد من الـ Guide Vanes Position على شاشة CH530
٥. قس الـ Approach Temperature — لو أعلى من 3°C يبقى الأنابيب لازجة
٦. لو كل حاجة أوكي بس الـ Delta T لسه واطي: شيك الـ Flow Rate (التدفق) — ممكن المضخات مش بتدفع كويس""",
    keywords: ["دلتا تي", "delta T", "مش ببرد", "low delta T", "evaporator", "مبخر", "fouling", "ترسبات", "approach", "CVHF1300", "guide vanes", "CH530"],
    severity: 'warning',
  ),

  // ─── B&G GLC 200-320 — أعطال المضخة الصغيرة المخصصة ───
  Fault(
    id: "pp-09",
    categoryId: "primaryPumps",
    title: "المضخة B&G GLC بتعمل Cavitation (كاويتيشن) وصوت كتكوتة — 1800 GPM",
    warning: "⚠️ الكاويتيشن (فقاعات بخار جوا المضخة) بيكسر الـ Impeller (الريشة) والـ Mechanical Seal (السيل)! الصوت زي حصا بتتكسر. لو سمعته قف المضخة فوراً!",
    cause: "السبب: الـ NPSHa (ضغط الساكشن المتاح) أقل من الـ NPSHr (المطلوب) — وده بيحصل لما الـ Strainer مسدود، أو الـ Suction Valve مقفول جزئياً، أو مستوى مية الـ Expansion Tank ناقص، أو مية الشيلد سخنة أوي.",
    solution: """١. قف المضخة فوراً لو سمعت صوت كاويتيشن
٢. نظف الـ Strainer (الفلتر) على خط الساكشن
٣. اتأكد إن الـ Suction Valve مفتوح بالكامل
٤. شيك مستوى الميه في الـ Expansion Tank — لازم الضغط يكون 2 بار
٥. قس الـ Suction Pressure — لازم يكون أعلى من الـ NPSHr (شوف الـ Pump Curve)
٦. لو الـ NPSHa لسه واطي: زود ارتفاع الـ Expansion Tank أو قلل التدفق""",
    keywords: ["كاويتيشن", "cavitation", "صوت كتكتكة", "B&G", "GLC", "NPSH", "سترينر", "strainer", "ساكشن", "ضغط واطي", "1800 GPM"],
    severity: 'critical',
  ),
  Fault(
    id: "pp-10",
    categoryId: "primaryPumps",
    title: "أمبير المضخة B&G GLC أعلى من 80A — محرك FELM 45kW فوق الحمل",
    warning: "⚠️ محرك FELM 45kW التيار المقنن بتاعه 80.2A عند 400V. لو الأمبير أعلى من 85A يبقى في Overload (حمل زايد) والموتور ممكن يحترق! قف المضخة وقس الأسباب.",
    cause: "السبب: الـ Impeller (الريشة) اتآكلت وكبرت، أو الـ Mechanical Seal مسدود، أو الـ Discharge Pressure أعلى من الـ Design، أو الـ Three-Phase Voltage مش متساوي (Phase Imbalance — عدم توازن الأطوار).",
    solution: """١. قس الأمبير على الأطوار التلاتة بالـ Clamp Meter
٢. لو الفرق بين أي طور والتاني أكتر من 2%: شيك الكابل والـ Contactor
٣. قس الـ Discharge Pressure وقارنه بالـ Pump Curve
٤. لو الضغط أعلى من الـ Design: قلل الـ Valve Opening
٥. شيك الـ Impeller — لو متآكل أو مكسور لازم يتغير
٦. قس الـ Vibration — لو عالي يبقى في Misalignment""",
    keywords: ["أمبير عالي", "overload", "حمل زايد", "FELM", "45kW", "80A", "GLC", "B&G", "phase imbalance", "عدم توازن", "محرك"],
    severity: 'critical',
  ),

  // ─── B&G e-1510 350-410 — أعطال المضخة الكبيرة المخصصة ───
  Fault(
    id: "pp-11",
    categoryId: "primaryPumps",
    title: "المضخة الكبيرة B&G e-1510 بتهتز أوي — Vibration عالي على الـ DE Bearing",
    warning: "⚠️ الاهتزاز (Vibration) على محمل نهاية الدوران (DE Bearing) لازم يكون أقل من 4.5 mm/s. لو أعلى من 7 mm/s قف المضخة فوراً! الاهتزاز العالي بيكسر المحامل والـ Seal وبيسبب تسريب.",
    cause: "السبب: الـ Misalignment (عدم محاذاة) بين الموتور FELM 132kW والمضخة، أو الـ Impeller Unbalance (عدم توازن الريشة)، أو المحامل خربانة، أو الـ Foundation Bolts (مسامير القاعدة) فكهة، أو الـ Resonance (رنين).",
    solution: """١. قس الـ Vibration على الـ DE و NDE Bearings بالـ Vibration Pen أو Analyzer
٢. لو القراءة أعلى من 4.5 mm/s: اعمل Laser Alignment (محاذاة بالليزر)
٣. شيك الـ Foundation Bolts — شد كل المسامير
٤. لو الاهتزاز لسه عالي: اعمل Impeller Balance (توازن الريشة)
٥. شيك حالة المحامل — لو خربانة غيرها
٦. بعد كل إصلاح: قس الـ Vibration تاني واتأكد إنه تحت 2.5 mm/s""",
    keywords: ["اهتزاز", "vibration", "e-1510", "B&G", "132kW", "DE bearing", "محمل", "misalignment", "محاذاة", "توازن", "impeller", "foundation"],
    severity: 'critical',
  ),
  Fault(
    id: "pp-12",
    categoryId: "primaryPumps",
    title: "المضخة الكبيرة B&G e-1510 بتسرب من الـ Mechanical Seal — 3000 GPM",
    warning: "⚠️ تسريب من الـ Mechanical Seal (السيل الميكانيكي) في المضخة دي خطير — دي بتدفع 3000 GPM يعني ضغط عالي! التسريب ممكن يوصل للموتور FELM 132kW ويحرق الملفات.",
    cause: "السبب: الـ Mechanical Seal اتآكل من الكاويتيشن أو التشغيل الجاف، أو الـ O-Rings (حلقات مطاطية) خربانة، أو الـ Seal Face (وجه السيل) خدش، أو الـ Misalignment بين الـ Shaft Sleeve والـ Seal Housing.",
    solution: """١. قف المضخة وأقفل الـ Suction و Discharge Valves
٢. قيم كمية التسريب — لو أكتر من Drop/min (قطره في الدقيقة) يبقى السيل خربان
٣. فك الـ Seal Housing واشوف الـ Seal Faces — لو خدشه لازم يتغير
٤. ركب Mechanical Seal جديد من نفس الـ Part Number
٥. قبل التشغيل: افتح الـ Suction Valve الأول واتأكد إن الميه ماشية
٦. بعد التشغيل: شيك التسريب تاني — لازم يكون Zero أو Drop بس""",
    keywords: ["تسريب", "ميكانيكال سيل", "mechanical seal", "e-1510", "B&G", "3000 GPM", "O-ring", "سيل خربان", "seal leak", "132kW"],
    severity: 'critical',
  ),

  // ─── FELM F3-225M-4 — أعطال المحرك الصغير المخصصة ───
  Fault(
    id: "dr-10",
    categoryId: "drives",
    title: "محرك FELM 45kW سخن أوي ودرجة حرارة السطح فوق 80°C",
    warning: "⚠️ محرك FELM F3-225M-4TEFC حرارة السطح الطبيعية تحت 70°C. لو فوق 80°C يبقى الموتور في خطر! العزل من فئة F (يتحمل لحد 155°C) بس ده درجة الملفات مش السطح. لو السطح 80°C يبقى الملفات ممكن تكون 120°C+!",
    cause: "السبب: Overload (حمل زايد)، أو الـ TEFC Cooling (تبريد الموتور) مش كافي لأن المروحة الخارجية بايظة، أو الـ Ambient Temperature (حرارة الغرفة) عالية أوي، أو الـ IP55 مش بيخلي الهوا تدخل تبرد كويس في البيئات الحارة.",
    solution: """١. قس حرارة السطح بـ IR Gun (مسدس حرارة) — سجل القراءة
٢. قس الأمبير بالـ Clamp Meter — لازم يكون تحت 80A
٣. شيك مروحة التبريد الخارجية — لازم تلف والمفات نظيفة
٤. لو حرارة الغرفة فوق 40°C: حسّن التهوية في غرفة المضخات
٥. لو الأمبير عالي: شيك الحمل على المضخة (ممكن Impeller كبر)
٦. في الصيف: ممكن تحتاج Exhaust Fan (مروحة شفط) في الغرفة""",
    keywords: ["سخن", "حرارة", "overheat", "FELM", "45kW", "225M", "TEFC", "IP55", "IR gun", "مسدس حرارة", "مروحة تبريد", "ambient"],
    severity: 'warning',
  ),
  Fault(
    id: "dr-11",
    categoryId: "drives",
    title: "محرك FELM 45kW بيسمع صوت طنين (Electrical Hum) مختلف عن الطبيعي",
    warning: "⚠️ صوت الطنين (Hum) لو اختلف عن الطبيعي ممكن يكون Phase Imbalance (عدم توازن الأطوار) أو Single Phasing (طور ناقص)! ده خطير جداً — الموتور ممكن يحترق في دقايق.",
    cause: "السبب: Phase Imbalance (فرق بين الأطوار التلاتة أكتر من 2%)، أو Single Phasing (كابل أو فيوز في طور واحد قطع)، أو الـ Contactor Contacts (نقاط الكنتاكتور) متآكلة في طور واحد، أو الـ VFD (الدرايف) مش بيدي تيار متساوي.",
    solution: """١. قس الأمبير على كل طور بالـ Clamp Meter — الفرق لازم يكون أقل من 2%
٢. قس الفولت على كل طور — لازم يكون 380V ± 5%
٣. لو في طور ناقص (صفر أمبير): قف الموتور فوراً!
٤. شيك الـ Contactor — النقاط لازم تكون نظيفة ومقفولة كويس
٥. شيك الـ Fuses/Circuit Breaker على كل طور
٦. لو الـ VFD موجود: شيك الـ Output Current من شاشة الـ Drive""",
    keywords: ["طنين", "hum", "phase imbalance", "طور ناقص", "single phasing", "FELM", "45kW", "كنتاكتور", "contactor", "فيوز", "أطوار"],
    severity: 'critical',
  ),

  // ─── FELM F3-315M-4 — أعطال المحرك الكبير المخصصة ───
  Fault(
    id: "dr-12",
    categoryId: "drives",
    title: "محرك FELM 132kW بيفصل على الـ Thermal Protection (PTC) — الحرارة 150°C",
    warning: "⚠️ محرك FELM F3-315M-4 فيه PTC Thermistor (حساس حرارة) بيعمل Trip (فصل) لما الملفات توصل 150°C. ده حماية أخيرة! لو بيفصل كتير يبقى الموتور مش شغال تحت الظروف الصح — لازم تكتشف السبب مش بس تعمل Reset!",
    cause: "السبب: الحمل على الموتور أعلى من الـ Rated (132kW)، أو الـ Cooling مش كافي، أو الـ Ambient Temperature عالي (أكتر من 50°C اللي هو الـ Max Ambient)، أو الـ PTC Controller (متحكم الحماية) مش مظبوط، أو تيار البدء (Inrush) عالي أوي.",
    solution: """١. لما الموتور يفصل: استنى يبرد لحد ما حرارة السطح تحت 50°C
٢. قس الأمبير عند الحمل الكامل — لازم يكون حوالي 224A
٣. لو الأمبير أعلى من 230A: الحمل زايد — شيك المضخة
٤. اتأكد من الـ PTC Controller Settings — لازم يفصل عند 150°C بس
٥. حسّن التهوية في غرفة المضخات — لو الحرارة فوق 40°C
٦. لو المشكلة بتتكرر: ممكن الموتور محتاج يترقي لـ 160kW""",
    keywords: ["PTC", "thermal protection", "حماية حرارة", "FELM", "132kW", "315M", "150°C", "trip", "فصل", "overload", "حمل زايد"],
    severity: 'critical',
  ),
  Fault(
    id: "dr-13",
    categoryId: "drives",
    title: "محرك FELM 132kW بيسحب تيار بدء (Inrush) عالي أوي — 1233A LRA",
    warning: "⚠️ تيار البدء (LRA - Locked Rotor Amps) بتاع الموتور ده 1233A! ده تيار عالي أوي — لازم الـ Soft Starter أو الـ VFD يكون شغال عشان يقلل التيار ده. لو ببدأ Direct On Line (DOL) التيار ده ممكن يفصل الـ Main Breaker!",
    cause: "السبب: الموتور بيبدأ DOL (مباشر من غير Soft Starter)، أو الـ Soft Starter بايظ وبيبدأ DOL بداله، أو الـ VFD مش شغال والموتور بيبدأ عبر الـ Bypass Contactor، أو الحمل على المضخة عالي أثناء البدء (الـ Discharge Valve مفتوح).",
    solution: """١. اتأكد إن الـ Soft Starter أو الـ VFD هو اللي بيبدأ الموتور — مش DOL
٢. لو الـ Soft Starter بايظ: صلحه أو استبدله — م تبدأش DOL!
٣. قبل البدء: أقفل الـ Discharge Valve عشان تقلل الحمل
٤. بعد ما الموتور يبدأ ويستقر: افتح الـ Valve تدريجياً
٥. قس تيار البدء — لازم يكون تحت 400A لو Soft Starter شغال
٦. لو ببدأ عبر VFD Bypass: ده خطر — صلح الـ VFD الأول""",
    keywords: ["تيار بدء", "inrush", "LRA", "1233A", "soft starter", "DOL", "FELM", "132kW", "315M", "VFD", "باس باس", "bypass"],
    severity: 'critical',
  ),
];

// ═══════════════════════════════════════════════════════════════════════════════
// ALL GUIDES DATA — 20 Rich Component & Procedure Guides
// ═══════════════════════════════════════════════════════════════════════════════

List<Guide> allGuides = [
  Guide(
    id: "g-01",
    title: "قراءة شاشة الشيلر Trane",
    whatIs: "الشاشة الرئيسية بتاعت الشيلر — لو قريتها صح هتعرف الطبيعي من البايظ في ثواني.",
    parts: ["حالة التشغيل (Running / Stop)", "حرارات دخول وخروج المبخر", "حرارات دخول وخروج المكثف", "فرق ضغط الزيت (Oil dP)", "نسبة أمبير الموتور من المقنن (RLA%)"],
    check: ["قارن حرارة المياه الخارجة من المبخر بالسيت بوينت (4.5 درجة)", "فرق المكثف الطبيعي 1.5-3 درجات", "فرق ضغط الزيت فوق 69 كيلو باسكال", "الأمبير تحت 90% من المقنن"],
    commonFaults: ["حرارة خارجة أعلى من السيت = حمل عالي أو سعة قليلة", "فرق مكثف عالي = المكثف وسخ يحتاج تنظيف", "فرق زيت واطي = فلتر زيت أو مستوى", "أمبير عالي = حمل زايد أو اتساخ"],
    warn: "أي قراءة خارج الطبيعي: سجلها وصور الشاشة فوراً.",
  ),
  Guide(
    id: "g-02",
    title: "خطوات تشغيل المحطة من الصفر بعد انقطاع كهرباء",
    whatIs: "إجراء تشغيل المحطة بالكامل من حالة التوقف الكامل بعد انقطاع كهرباء أو صيانة شاملة.",
    parts: ["اللوحة الرئيسية MCC", "مضخات البرايمري", "مضخات الكوندنسر", "أبراج التبريد", "الشيلرات", "مضخات السكندري", "نظام BMS"],
    check: ["تأكد من إن الـ Main Power رجع ومستقر", "شيك كل الـ MCCBs والـ Isolators — خليهم ON", "شغل الـ Primary Pumps الأولى وانتظر الـ Pressure يستقر", "شغل الـ Condenser Pumps وتأكد من الـ Flow", "تأكد من مستوى الحوض في أبراج التبريد", "شغل فانات أبراج التبريد", "افتح الـ Chiller Isolation Valves", "فعّل الـ Oil Heater للشيلر وانتظر 4-8 ساعات لو كان واقف طويل", "اضغط Start على الشيلر وراقب الـ Startup Sequence", "رافق الـ Parameters لمدة 15 دقيقة", "بعد استقرار الشيلر الأول شغل التاني لو محتاج", "شغل الـ Secondary Pumps", "فعّل الـ BMS واتأكد من إشارات الكنترول"],
    commonFaults: ["مضخة مش بتشغل = هوا محبوس أو فلتش مقلوب", "شيلر بيعطي Lockout = راجع الإنذار على الشاشة", "أمبير عالي = حمل زيادة أو سحب مفقود", "برج مياه قليلة = صمام تعويض واقف"],
    warn: "لا تشغل أكتر من شيلر واحد في نفس الوقت! انتظر كل واحد يستقر. لو فيه Alarm أثناء Startup قف فوراً.",
  ),
  Guide(
    id: "g-03",
    title: "عدسة البيان (السايت جلاس - Sight Glass)",
    whatIs: "عدسة صغيرة على خط الشيلر بتوريك شحن الفريون ومستوى الزيت بعينك.",
    parts: ["عدسة الفريون على خط السائل", "عدسة الزيت على الفاصل أو الكارتير"],
    check: ["فريون صافي من غير فقاعات = شحن تمام", "فقاعات = شحن ناقص أو تسريب", "الزيت في نص العدسة = مستوى سليم"],
    commonFaults: ["فقاعات مستمرة = دور على تسريب وقيس الضغوط", "زيت بينزل = بيسرب مع الفريون", "لون متغير = رطوبة تحتاج فلتر دراير"],
    warn: "فقاعات مع حمل عالي: قيس الضغوط قبل أي قرار.",
  ),
  Guide(
    id: "g-04",
    title: "جهاز المعالجة MicroVision",
    whatIs: "عقل معالجة المياه: بيقيس التوصيلية ويتحكم في الحقن والتفوير أوتوماتيك.",
    parts: ["شاشة قراءة التوصيلية", "صمام تفوير (Bleed) كهربائي", "مضخات حقن (Feed / Biocide A / B)", "أطراف توصيل الحساسات"],
    check: ["التوصيلية الطبيعية 1300-1500 مايكروسيمنز", "لمبة Feed ولادة = بيحقن", "التوصيلية عالية = الـ Bleed يفتح", "مستوى تنكات الكيماوي كفاية"],
    commonFaults: ["توصيلية عالية = صمام Bleed عالق أو مش بيفتح", "توصيلية واطية = Bleed عالق مفتوح (بيضيع مياه وكيماوي)", "مفيش حقن = مضخة فيها هوا أو بلف قدم بايظ"],
    warn: "متغيرش الضبط من غير مسؤول المعالجة.",
  ),
  Guide(
    id: "g-05",
    title: "إنفرتر Schneider ATV630",
    whatIs: "جهاز بيتحكم في سرعة موتور المضخة بتغيير التردد — بيوفر كهربا ويحمي الشبكة.",
    parts: ["شاشة عرض وأزرار", "مروحة تبريد داخلية", "أطراف تغذية وموتور", "لمبات حالة (STATUS / NET)"],
    check: ["RUN + تردد على الشاشة = شغال", "أمبير حوالي 26-27 عندكم طبيعي", "المروحة بتلف ومنافذ التهوية نظيفة"],
    commonFaults: ["OCF تيار عالي = موتور أو كابلات", "OHF سخونية = تهوية مسدودة بالتراب", "SCF شورت = كابلات الموتور", "مفيش شاشة = راجع التغذية"],
    warn: "متعملش Reset أكتر من مرتين ورا بعض — دور على السبب.",
  ),
  Guide(
    id: "g-06",
    title: "إنفرتر Danfoss VLT",
    whatIs: "نفس شغل الشيدر: موحد بيتحول للمستمر وعاكس بيطول تردد متغير للموتور.",
    parts: ["الموحد (Rectifier)", "دائرة DC Link بمكثفاتها", "العاكس (IGBTs)", "لوحة التحكم المحلية LCP", "مروحة التبريد"],
    check: ["اقرا التردد والأمبير من اللوحة", "المروحة بتلف حر", "مفيش تراب متراكم على المشتت"],
    commonFaults: ["AL4 فقد فاز = فيوزات وتغذية", "AL7 حمل زايد = قلل الحمل", "AL13 تيار عالي = كابلات", "مفيش عرض = تغذية"],
    warn: "افصل واستنى 10 دقايق قبل فتح الغطاء — المكثفات بتفضل شاحنة!",
  ),
  Guide(
    id: "g-07",
    title: "المشغل الكهربائي (Actuator MF200 / MF700)",
    whatIs: "موتور كهربائي بيفتح ويقفل محبس مياه الكوندنسر/البرايمري أوتوماتيك بإشارة من الـ BMS.",
    parts: ["موتور كهربائي 230 فولت", "جير تخفيض", "عجلة يدوية للطوارئ", "مؤشر وضع مفتوح/مقفول"],
    check: ["كهرباء 230 واصلة", "المؤشر بيوري الوضع", "جرب العجلة والكهربا مفصولة"],
    commonFaults: ["مش بيتحرك كهرباء = موتور محروق أو إشارة كنترول", "بيتحرك والمحبس واقف = جسم المحبس", "المؤشر غلط = معايرة"],
    warn: "افصل الكهربا قبل لمس العجلة اليدوية.",
  ),
  Guide(
    id: "g-08",
    title: "صمام الثلاث وظائف (Triple Duty Valve)",
    whatIs: "صمام واحد جامع 3 وظائف، مركب على طرد كل مضخة عندكم.",
    parts: ["محبس إيقاف لعزل المضخة", "قرص عدم رجوع بيمنع رجوع المياه", "محبس موازنة بظبط التدفق وعليه % OPEN", "مصفاة داخلية بتتنضف"],
    check: ["بص على مؤشر الفتح", "قارن صوت المضخة قبل وبعد", "دور على رشح حوالين الجلدة"],
    commonFaults: ["برشح من العمود = تتغير جلدة العمود", "مبيقفلش تمام = جسم غريب على المقعد", "التدفق مش مظبوط = ظبط % OPEN"],
    warn: "متقفلوش نهائي والمضخة شغالة.",
  ),
  Guide(
    id: "g-09",
    title: "مشتت السحب (Suction Diffuser)",
    whatIs: "مصفاة ومشتت دوامات مركب على سحب المضخة — بيحمي الريشة.",
    parts: ["جسم بغطاء", "مصفاة داخلية", "ريش تشتيت الدوامات", "سدادة تصريف"],
    check: ["نضفه بعد أي شغل مواسير", "فرق الضغط قبله وبعده مش كبير", "حالة الجلدة قبل القفل"],
    commonFaults: ["مسدود = كاويتيشن وخبط بالمضخة", "برشح من الغطاء = غير الجلدة"],
    warn: "اقفل محبس السحب قبل فتح الغطاء.",
  ),
  Guide(
    id: "g-10",
    title: "مفتاح تدفق المياه (الفلوسويتش - Flow Switch)",
    whatIs: "حماية بتأكد سريان المياه: لو السريان وقف بيفصل الشيلر ويحمي المبخر.",
    parts: ["ريشة (باديل) داخل الماسورة", "ذراع ميكانيكي", "نقطة تلامس كهربائية", "سكينة معايرة"],
    check: ["مضخة واقفة = التلامس مفتوح", "مضخة شغالة = التلامس مقفول", "الريشة مش مكسورة أو متكلسة"],
    commonFaults: ["شيلر بيفصل على تدفق = ريشة عاقة أو مكسورة", "مفيش إشارة = توصيلات أو تلامس"],
    warn: "ممنوع توصيله جامد (باي باس) — المبخر ممكن يتجمد ويتفجر!",
  ),
  Guide(
    id: "g-11",
    title: "حساس الضغط والمانومتر (Pressure Sensor & Manometer)",
    whatIs: "الحساس بيحول الضغط لإشارة 4-20 ملي أمبير للكنترول؛ المانومتر بيوريه ميكانيكي على الماسورة.",
    parts: ["حساس Schneider مدى 0-16 بار", "مانومتر ميكانيكي", "محبس عزل تحت الحساس"],
    check: ["قارن قراءته بالمانومتر", "فرق كبير = معايرة أو تغيير", "المحبس تحت الحساس مفتوح"],
    commonFaults: ["قراءة صفر = توصيلات أو حساس", "قراءة ثابتة = مجرى مسدود"],
    warn: "غيّر الحساس والدايرة منزّلة الضغط.",
  ),
  Guide(
    id: "g-12",
    title: "مضخات B&G — المكونات الداخلية",
    whatIs: "مضخة طرد مركزي إنلاين رأسية: موتور فوق وريشة تحت على نفس العمود.",
    parts: ["موتور كهربائي", "عمود وكوبلنج", "ريشة وموجهات", "مانع تسريب ميكانيكي", "رمان بلي"],
    check: ["دوري: صوت وحرارة واهتزاز", "تشحيم البلي في ميعاده", "اتزان بعد أي تغيير موتور"],
    commonFaults: ["خبط = كاويتيشن أو بلي", "تسريب تحت الموتور = ميكانيكال سيل", "أمبير عالي = ريشة مسدودة أو متآكلة"],
    warn: "متشغلهاش من غير مياه ولا ثانية.",
  ),
  Guide(
    id: "g-13",
    title: "فحص وتبديل الميكانيكال سيل",
    whatIs: "الجزء اللي بيمنع تسريب المياه على العمود — وش فحم ووش سيراميك بنابض.",
    parts: ["وش ثابت", "وش دوّار", "نابض", "جلد مطاط"],
    check: ["بص تحت المضخة: نقط بطيء = طبيعي أول العمر", "سريان مستمر = بايظ", "لون المياه: صدأ؟"],
    commonFaults: ["تسريب كتير = تغيير فوري", "تسريب بعد وقف طويل = وشوك لازقين ممكن يفك مع التشغيل"],
    warn: "التسريب على الكابلات أو الموتور = افصل فوراً.",
  ),
  Guide(
    id: "g-14",
    title: "فلتر الرملة Puroflux",
    whatIs: "فلتر جانبي بياخد جزء من مياه الكوندنسر ويصفيها ويرجعها نظيفة.",
    parts: ["جسم الفلتر برمل", "مضخة 10 حصان", "لوحة كنترول بسويتشات", "محابس عزل"],
    check: ["شغال يومياً حسب البرنامج", "غسيل عكسي لحد ما الصرف يصفي", "مفيش تسريب فلنجات"],
    commonFaults: ["فرق ضغط عالي = محتاج غسيل عكسي", "مياه معكرة بعد الغسيل = رمل معمل قنوات"],
    warn: "بدّل المحابس والمضخة واقفة.",
  ),
  Guide(
    id: "g-15",
    title: "تنظيف حوض برج التبريد",
    whatIs: "الحوض بيجمع المياه المبردة؛ الترسيب فيه بيسد الفيل وياكل النظام.",
    parts: ["الحوض", "حشو التبريد (الفيل)", "مانعات التطاير", "محابس تفوير وتصريف"],
    check: ["مياه صافية مش معكرة", "مفيش طين بقاع الحوض", "الفيل مش مسدود"],
    commonFaults: ["مياه معكرة = ظبط جرعات وتفوير", "طين = نظف واغسل"],
    warn: "متدخلش الحوض والمياه بتدور — افصل المضخات الأول.",
  ),
  Guide(
    id: "g-16",
    title: "العزل الكهربائي (Lockout/Tagout)",
    whatIs: "إجراء بيضمن إن مفيش كهرباء واصلة للمعدة قبل الشغل — قاعدة حياة.",
    parts: ["القاطع الرئيسي", "قفل شخصي", "لافتة تحذير", "جهاز قياس"],
    check: ["افصل القاطع", "اقفل وعلّق لافتة", "اختبر بنفسك بالقياس", "فضّي المكثفات"],
    commonFaults: ["تخطي أي خطوة = حادثة"],
    warn: "ممنوع الشغل من غير عزل مهما الاستعجال.",
  ),
  Guide(
    id: "g-17",
    title: "خزان التمدد Reflex",
    whatIs: "خزان بغشاء مطاطي ونيتروجين بيتمدد مع مياه النظام ويحافظ على الضغط ثابت.",
    parts: ["جسم صلب", "غشاء مطاطي (ممبرين)", "بلف شحن نيتروجين فوق", "وصلة مياه تحت"],
    check: ["ضغط النيتروجين 2 بار (والنظام واقف ومفضي)", "مفيش مياه طالعة من بلف النيتروجين (الغشاء سليم)"],
    commonFaults: ["ضغط صفر = الغشاء مخروم", "ضغط بيقع كتير = تسريب بطيء بالبلف"],
    warn: "متشحنش نيتروجين والخزان مليان مياه.",
  ),
  Guide(
    id: "g-18",
    title: "مضخة التعويض Wilo",
    whatIs: "مضخة رأسية متعددة المراحل بتعوض أي نقص مياه وتحافظ على ضغط النظام.",
    parts: ["مضخة Wilo رأسية", "لوحة كنترول بشاشة لمس", "صمام عدم رجوع على الطرد", "محابس عزل"],
    check: ["أوتو = PID بيحافظ على الضغط", "مفيش صوت غير طبيعي", "مفيش تسريب بالوصلات"],
    commonFaults: ["مش بتضبط ضغط = هوا محبوس أو صمام عدم رجوع عالق", "بتفصل وتشتغل كتير = ضبط أو خزان ضغط"],
    warn: "متشغلهاش ناشفة.",
  ),
  Guide(
    id: "g-19",
    title: "كيفية عمل Leak Test وملء الفريون",
    whatIs: "إجراء اختبار تسريب وملء الفريون بعد إصلاح أي تسريب أو صيانة.",
    parts: ["اسطوانة نيتروجين مع ريجيليتور", "صابون اختبار تسريب", "جهاز كشف تسريب إلكتروني", "مضخة تفريغ (Vacuum Pump)", "ميزان وزن الفريون"],
    check: ["قف الشيلر وافصل الباور", "اضغط نيتروجين 300 PSI", "استخدم صابون على كل الجوينات والفلنجات", "لو مفيش فقاعات: انتظر 30 دقيقة وشوف الـ Pressure Drop", "لو مفيش Drop: ابدأ التفريغ (Vacuum)", "اشحن الفريون بالوزن المكتوب على الـ Nameplate"],
    commonFaults: ["فقاعات = فيه تسريب! علّم المكان", "Vacuum ما بيثبتش = فيه تسريب صغير", "بعد الشحن: سوبرهيت عالي = شحن ناقص", "بعد الشحن: سبكولينج واطي = شحن زايد"],
    warn: "ممنوع لحام والشيلر شغال أو فيه ضغط — نزّله الأول! لبس PPE إلزامي.",
  ),
  Guide(
    id: "g-20",
    title: "كيفية قراءة منحنى المضخة (Pump Curve)",
    whatIs: "المنحنى بيبين العلاقة بين التدفق والضغط للمضخة — مهم لفهم أداء المضخة.",
    parts: ["محور أفقي: التدفق (Flow Rate) م³/ساعة أو GPM", "محور عمودي: الرأس (Head) متر أو قدم", "منحنيات الأقطار المختلفة", "منحنى الكفاءة (Efficiency)", "منحنى القدرة (Power)"],
    check: ["اجلب الـ Pump Curve من الكتالوج", "حدد الـ Impeller Diameter المركب", "قس الـ Actual Flow والـ Actual Pressure", "ارسم نقطة التقاطع على الـ Curve", "لو النقطة على الـ Curve = المضخة شغالة كويس", "لو النقطة يمين = Resistance أقل (أكتر Flow)", "لو النقطة شمال = Resistance أكتر (أقل Flow)"],
    commonFaults: ["بعيد عن BEP = كفاءة واطية وتآكل", "النقطة على الحد الأحمر = خطر على المضخة", "Impeller كبير أوي = أمبير عالي وقدرة زيادة"],
    warn: "لا تشغل المضخة خارج المدى الآمن للمنحنى — ده بيسبب اهتزاز وتآكل.",
  ),
];

// ═══════════════════════════════════════════════════════════════════════════════
// EMERGENCY FAULTS — Critical faults needing immediate action
// ═══════════════════════════════════════════════════════════════════════════════

const List<String> emergencyFaultIds = [
  'ch-01', 'ch-03', 'ch-04', 'ch-13', 'ch-14',
  'pp-03', 'pp-04', 'pp-05', 'pp-09', 'pp-10', 'pp-11', 'pp-12',
  'ct-03', 'ct-05',
  'dv-01', 'dv-02', 'dr-11', 'dr-12', 'dr-13',
  'wt-02',
  'et-01', 'et-03', 'et-05',
];

// ═══════════════════════════════════════════════════════════════════════════════
// COLLOQUIAL TERMS DICTIONARY — Technical terms in Egyptian Arabic
// ═══════════════════════════════════════════════════════════════════════════════

const Map<String, String> colloquialTerms = {
  'Pump': 'مضخة (بامب/بومبة)',
  'Chiller': 'شيلر (وحدة تبريد مركزية)',
  'Compressor': 'كمبروسر (ضاغط)',
  'Bearing': 'رمان بلي (بيرنج/كرة)',
  'Seal': 'سيل (مانع تسريب)',
  'Mechanical Seal': 'ميكانيكال سيل (مانع تسريب ميكانيكي)',
  'Strainer': 'مصفاة (سترينر)',
  'Filter': 'فلتر (منقي)',
  'Valve': 'صمام/محبس (فالف)',
  'Actuator': 'مشغل (أكتواتور)',
  'Drive': 'درايف/إنفرتر (محول تردد)',
  'VFD': 'درايف/إنفرتر (محول تردد)',
  'Inverter': 'إنفرتر/درايف (محول تردد)',
  'Cooling Tower': 'برج تبريد (كولينج تاور)',
  'Evaporator': 'مبخر (إيفابوريتر)',
  'Condenser': 'مكثف (كوندنسر)',
  'Expansion Tank': 'خزان تمدد (إكسبانشن تنك)',
  'Flow Switch': 'فلوسويتش (مفتاح تدفق)',
  'Sight Glass': 'عدسة بيان/سايت جلاس',
  'Gauge': 'ميزان/جيج',
  'Thermostat': 'ترموستات (منظم حرارة)',
  'Pressure Relief Valve': 'صمام أمان (PRV)',
  'Triple Duty Valve': 'صمام ثلاث وظائف',
  'Suction Diffuser': 'مشتت سحب',
  'Coupling': 'كوبلنج (وصلة مرنة)',
  'Impeller': 'ريشة (إمبرلر)',
  'Freon': 'فريون (غاز تبريد/ريفرجيرانت)',
  'Refrigerant': 'فريون (غاز تبريد)',
  'Surge': 'سيرج (تذبذب الضغط في الشيلر)',
  'Cavitation': 'تكهف (كاويتيشن - دخول هواء)',
  'Lockout': 'لوك أوت (قفل حماية)',
  'Alarm': 'إنذار (تنبيه)',
  'BMS': 'نظام إدارة المبنى',
  'PLC': 'بلس/كونترولر (متحكم منطقي)',
  'Contactor': 'كنتاكتور (مفتاح تحكم مغناطيسي)',
  'Overload': 'أوفرلود (حمل زايد)',
  'Short Circuit': 'شورت (قصر كهربي)',
  'Phase': 'فاز/فيز (طور)',
  'Ampere': 'أمبير (تيار كهربي)',
  'Voltage': 'فولت (جهد كهربي)',
  'Capacitor': 'كاباسيتور/مكثف',
  'Relay': 'ريلاي (وحدة تحكم)',
  'Fuse': 'فيوز (مصهر)',
  'Isolator': 'أيزوليتور (قاطع عزل)',
  'Gasket': 'جوان/جلدة (حلقة مانعة للتسريب)',
  'Flange': 'فلنجة (وصلة ماسورة)',
  'Welding': 'لحام',
  'Nitrogen': 'نيتروجين (غاز اختبار ضغط)',
  'Vacuum': 'فاكيوم (تفريغ)',
  'Superheat': 'سوبرهيت (فرط تسخين)',
  'Subcooling': 'سبكولينج (تبريد زائد)',
  'Head Pressure': 'ضغط عالي (هد بريسير)',
  'Suction Pressure': 'ضغط سحب (سكشن بريسير)',
  'Oil Pressure': 'ضغط زيت',
  'Conductivity': 'توصيلية (كونداكتفيتي)',
  'Bleed': 'تفوير/تصريف (بليد)',
  'Biocide': 'بايوسيد (مضاد بكتيريا/طحالب)',
  'Flow Rate': 'تدفق (فلو ريت)',
  'Head': 'رأس (ضغط المضخة بالمتر)',
  'Efficiency': 'كفاءة (إفشنسي)',
  'Motor': 'موتور (محرك كهربي)',
  'Fan': 'فان/مروحة',
  'Gearbox': 'جيربوكس/علبة تروس',
  'Fill': 'فيل/حشو (تعبئة برج التبريد)',
  'Drift Eliminator': 'مانع تطاير',
  'Basin': 'حوض (قاعدة البرج)',
  'Bladder': 'غشاء/ممبرين (في خزان التمدد)',
  'Pre-charge': 'شحن أولي (ضغط النيتروجين)',
  'Water Hammer': 'طرق مائية (ووتر هامر)',
  'Air Eliminator': 'منزع هواء',
  'Scale': 'ترسيب/كلس (سكيل)',
  'Corrosion': 'تآكل (كوروجن)',
  'Flush': 'فلوش/غسيل',
  'Torque': 'عزم (شد بمفتاح عزم)',
  'Endoscope': 'إندوسكوب (كاميرا داخلية)',
  'Nameplate': 'لوحة بيانات (نيم بليت)',
  'AHU': 'وحدة معالجة هواء (AHU)',
  'FCU': 'وحدة فن كويل (FCU)',
  'Chilled Water': 'مياه مبردة (تشيلد ووتر)',
  'Condenser Water': 'مياه كوندنسر',
  'Reset': 'ريست (إعادة تعيين)',
  'Lockout/Tagout': 'عزل كهربائي (لوك أوت/تاج أوت)',
  'HFO-514A': 'فريون إتش إف أو 514 إيه (غاز تبريد صديق للبيئة)',
  'CenTraVac': 'سنترا فاك (سلسلة شيلرات ترين)',
  'CVHF1300': 'سي في إتش إف 1300 (موديل الشيلر)',
  'CH530': 'سي إتش 530 (شاشة تحكم ترين)',
  'Guide Vanes': 'ريش مدخل (بتتحكم في تدفق الفريون)',
  'Hot Gas Bypass': 'صمام تحويل الغاز الساخن (بيمنع السيرج)',
  'GPM': 'جالون في الدقيقة (وحدة قياس التدفق)',
  'TDH': 'تي دي إتش - الرأس الديناميكي الكلي (ارتفاع الميه)',
  'TEFC': 'تي إف سي - مغلق بالكامل ومبرد بمروحة (نوع الموتور)',
  'IE3': 'آي إي 3 - كفاءة عالية (Premium Efficiency)',
  'IP55': 'آي بي 55 - محمي من الغبار والرشاشات',
  'NLGI Grade 2': 'إن إل جي آي 2 - درجة قوام الشحم',
  'CALTEX SRI-2': 'كالتكس إس آر آي 2 (شحم صناعي عالي الأداء)',
  'DE Bearing': 'محمل نهاية الدوران (Drive End)',
  'NDE Bearing': 'محمل الناحية التانية (Non-Drive End)',
  'Oil Heater': 'سخان الزيت (بيسخن الزيت قبل تشغيل الشيلر)',
  'Dilution': 'تخفيف (فريون مختلط مع الزيت)',
  'Dead Head': 'ضغط ميت (المضخة شغالة والصمام مقفول)',
  'Phase Imbalance': 'عدم توازن الأطوار (تيار مش متساوي)',
  'IR Gun': 'مسدس حرارة بالأشعة تحت الحمراء',
  'Clamp Meter': 'أمبير كلامب (جهاز قياس التيار)',
};

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER FUNCTIONS — Search, Filter, Lookup
// ═══════════════════════════════════════════════════════════════════════════════

/// Search faults by query (Arabic + English keywords + title)
List<Fault> searchFaults(String query) {
  if (query.isEmpty) return [];
  final q = query.toLowerCase();
  return allFaults.where((f) {
    if (f.title.toLowerCase().contains(q)) return true;
    if (f.cause.toLowerCase().contains(q)) return true;
    for (final kw in f.keywords) {
      if (kw.toLowerCase().contains(q)) return true;
    }
    // Also search colloquial terms
    for (final entry in colloquialTerms.entries) {
      if (entry.key.toLowerCase().contains(q) || entry.value.contains(q)) {
        if (f.title.contains(entry.key) || f.title.contains(entry.value) ||
            f.cause.contains(entry.key) || f.cause.contains(entry.value)) {
          return true;
        }
      }
    }
    return false;
  }).toList();
}

/// Get fault count for a category
int getFaultCount(String categoryId) {
  return allFaults.where((f) => f.categoryId == categoryId).length;
}

/// Get all faults for a category
List<Fault> getFaultsByCategory(String categoryId) {
  return allFaults.where((f) => f.categoryId == categoryId).toList();
}

/// Get category by ID
EquipmentCategory? getCategoryById(String id) {
  try {
    return categories.firstWhere((c) => c.id == id);
  } catch (_) {
    return null;
  }
}
