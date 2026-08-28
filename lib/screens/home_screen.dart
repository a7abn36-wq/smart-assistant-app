import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../theme/app_theme.dart';
import 'fault_detail_screen.dart';
import 'guides_screen.dart';
import 'reports_screen.dart';
import 'admin_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<Fault> get _searchResults {
    if (_searchQuery.isEmpty) return [];
    return searchFaults(_searchQuery);
  }

  List<Fault> get _emergencyFaults {
    return allFaults.where((f) => emergencyFaultIds.contains(f.id)).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          backgroundColor: AppTheme.darkBg,
          title: Text(
            'المساعد الذكي',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.cyanGlow,
              shadows: [Shadow(color: AppTheme.cyanGlow, blurRadius: 10)],
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: AppTheme.cyanGlow),
            onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
          ),
        ),
        endDrawer: _buildDrawer(),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            // Search Field
            Container(
              decoration: AppTheme.glowBox(AppTheme.cyanGlow, blur: 12, op: 0.25),
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v.trim()),
                style: const TextStyle(color: Colors.white),
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  hintText: 'اكتب اللي شايفه... مثال: تسريب بامب / صوت مروحة / بلي',
                  hintStyle: const TextStyle(color: AppTheme.ice, fontSize: 14),
                  prefixIcon: const Icon(Icons.search, color: AppTheme.cyanGlow),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close, color: AppTheme.fireRed, size: 20),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),

            if (_searchQuery.isEmpty) ...[
              // Welcome Message
              Container(
                padding: const EdgeInsets.all(20),
                decoration: AppTheme.glowBox(AppTheme.cyanGlow, blur: 20, op: 0.4),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('أهلاً بيك يا معلم',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                    SizedBox(height: 6),
                    Text('كل أعطال وحلول المحطة في جيبك — شغال 100% من غير نت',
                        style: TextStyle(color: AppTheme.ice)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Emergency Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.fireRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.fireRed.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.emergency, color: AppTheme.fireRed, size: 20),
                    const SizedBox(width: 8),
                    Text('أعطال الطوارئ', style: TextStyle(color: AppTheme.fireRed, fontWeight: FontWeight.bold, fontSize: 16)),
                    const Spacer(),
                    Text('${_emergencyFaults.length}', style: TextStyle(color: AppTheme.fireRed, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _emergencyFaults.length,
                  itemBuilder: (context, index) {
                    final f = _emergencyFaults[index];
                    final shortTitle = f.title.length > 25 ? '${f.title.substring(0, 25)}...' : f.title;
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FaultDetailScreen(fault: f))),
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: AppTheme.glowBox(AppTheme.fireRed, blur: 8, op: 0.2, radius: 12),
                        child: Center(
                          child: Text(shortTitle, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Categories Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final faultCount = getFaultCount(cat.id);
                  return _buildCategoryCard(cat, faultCount);
                },
              ),
              const SizedBox(height: 16),

              // Quick Action Buttons
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GuidesScreen())),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: AppTheme.glowBox(AppTheme.greenNeon, blur: 12, op: 0.25),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.menu_book, color: AppTheme.greenNeon),
                            SizedBox(width: 8),
                            Text('الشروحات', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsScreen())),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: AppTheme.glowBox(AppTheme.fireRed, blur: 12, op: 0.25),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.description, color: AppTheme.fireRed),
                            SizedBox(width: 8),
                            Text('تقرير جديد', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ] else if (_searchResults.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text('ملقيناش حاجة بالكلمة دي — جرّب كلمة أبسط',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppTheme.ice, fontSize: 16)),
              )
            else
              ..._searchResults.map((f) => _buildFaultCard(context, f)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(EquipmentCategory cat, int faultCount) {
    final catColor = Color(cat.color);
    return GestureDetector(
      onTap: () {
        final catFaults = getFaultsByCategory(cat.id);
        if (catFaults.isNotEmpty) {
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => _CategoryFaultsScreen(category: cat, faults: catFaults),
          ));
        }
      },
      child: Container(
        decoration: AppTheme.glowBox(catColor, blur: 10, op: 0.22),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: catColor.withOpacity(0.12),
              child: Text(cat.icon, style: const TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 8),
            Text(cat.nameAr, textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
            const SizedBox(height: 4),
            Text(cat.nameEn, textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11, color: AppTheme.ice)),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: catColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: catColor.withOpacity(0.3)),
              ),
              child: Text('$faultCount عطل', style: TextStyle(fontSize: 11, color: catColor, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaultCard(BuildContext ctx, Fault f) {
    final cat = getCategoryById(f.categoryId);
    final sevColor = AppTheme.severityColor(f.severity);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => FaultDetailScreen(fault: f))),
        child: Container(
          decoration: AppTheme.glowBox(sevColor, blur: 10, op: 0.2),
          child: ListTile(
            leading: Icon(AppTheme.severityIcon(f.severity), color: sevColor),
            title: Text(f.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textDirection: TextDirection.rtl),
            subtitle: Text(cat?.nameAr ?? '', style: const TextStyle(color: AppTheme.ice)),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: sevColor.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
              child: Text(AppTheme.severityLabel(f.severity), style: TextStyle(color: sevColor, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AppTheme.darkBg,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFF00E5FF), Color(0xFF0369A1)]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60, height: 60,
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(0.4), width: 2)),
                    child: ClipOval(child: Image.asset('assets/images/logo.jpg', fit: BoxFit.cover)),
                  ),
                  const SizedBox(height: 10),
                  const Text('المساعد الذكي', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                  const Text('Mohamed_Bn_saber', style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  for (final cat in categories)
                    ListTile(
                      leading: Text(cat.icon, style: const TextStyle(fontSize: 22)),
                      title: Text(cat.nameAr, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                      subtitle: Text(cat.nameEn, style: const TextStyle(color: AppTheme.ice, fontSize: 11)),
                      onTap: () {
                        Navigator.pop(context);
                        final catFaults = getFaultsByCategory(cat.id);
                        if (catFaults.isNotEmpty) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (_) => _CategoryFaultsScreen(category: cat, faults: catFaults),
                          ));
                        }
                      },
                    ),
                  const Divider(color: AppTheme.subtleBorder),
                  ListTile(
                    leading: const Icon(Icons.menu_book, color: AppTheme.greenNeon),
                    title: const Text('الشروحات', style: TextStyle(color: Colors.white)),
                    onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const GuidesScreen())); },
                  ),
                  ListTile(
                    leading: const Icon(Icons.description, color: AppTheme.cyanGlow),
                    title: const Text('التقارير', style: TextStyle(color: Colors.white)),
                    onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsScreen())); },
                  ),
                  const Divider(color: AppTheme.subtleBorder),
                  ListTile(
                    leading: const Icon(Icons.info_outline, color: AppTheme.ice),
                    title: const Text('حول التطبيق', style: TextStyle(color: Colors.white)),
                    onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen())); },
                  ),
                  ListTile(
                    leading: const Icon(Icons.lock, color: AppTheme.greenNeon),
                    title: const Text('لوحة التحكم', style: TextStyle(color: Colors.white)),
                    onTap: () { Navigator.pop(context); Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminScreen())); },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Inline category faults screen (replaces faults_screen.dart navigation)
class _CategoryFaultsScreen extends StatelessWidget {
  final EquipmentCategory category;
  final List<Fault> faults;

  const _CategoryFaultsScreen({super.key, required this.category, required this.faults});

  @override
  Widget build(BuildContext context) {
    final catColor = Color(category.color);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          backgroundColor: AppTheme.darkBg,
          title: Text(category.nameAr, style: TextStyle(color: catColor, fontWeight: FontWeight.bold, shadows: [Shadow(color: catColor, blurRadius: 8)])),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppTheme.cyanGlow),
        ),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: AppTheme.glowBox(catColor, blur: 14, op: 0.3),
              child: Row(
                children: [
                  CircleAvatar(backgroundColor: catColor.withOpacity(0.12), child: Text(category.icon, style: const TextStyle(fontSize: 24))),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(category.nameAr, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                        Text(category.nameEn, style: const TextStyle(color: AppTheme.ice)),
                      ],
                    ),
                  ),
                  Text('${faults.length} عطل', style: TextStyle(color: catColor, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ...faults.map((f) {
              final sevColor = AppTheme.severityColor(f.severity);
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FaultDetailScreen(fault: f))),
                  child: Container(
                    decoration: AppTheme.glowBox(sevColor, blur: 8, op: 0.2),
                    child: ListTile(
                      leading: Icon(AppTheme.severityIcon(f.severity), color: sevColor),
                      title: Text(f.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textDirection: TextDirection.rtl, maxLines: 2, overflow: TextOverflow.ellipsis),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: sevColor.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                        child: Text(AppTheme.severityLabel(f.severity), style: TextStyle(color: sevColor, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
