import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../theme/app_theme.dart';
import 'faults_screen.dart';
import 'fault_detail_screen.dart';
import 'guides_screen.dart';
import 'reports_screen.dart';
import 'admin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  List<Fault> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults = [];
      });
    } else {
      setState(() {
        _isSearching = true;
        _searchResults = searchFaults(query);
      });
    }
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
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: AppTheme.cyanGlow),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ),
        endDrawer: _buildDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Search Field
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.cyanGlow.withOpacity(0.1),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  style: TextStyle(color: AppTheme.white, fontSize: 14),
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hintText: 'اكتب العطل بالعامية أو الإنجليزي...',
                    hintStyle: TextStyle(
                      color: AppTheme.grayText,
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppTheme.cyanGlow,
                    ),
                    suffixIcon: _isSearching
                        ? IconButton(
                            icon: const Icon(Icons.close,
                                color: AppTheme.fireRed, size: 20),
                            onPressed: () {
                              _searchController.clear();
                              _onSearchChanged('');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: AppTheme.cardBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppTheme.cyanGlow.withOpacity(0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppTheme.cyanGlow.withOpacity(0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppTheme.cyanGlow,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Content
              Expanded(
                child: _isSearching ? _buildSearchResults() : _buildCategoriesGrid(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final cat = categories[index];
        final faultCount = getFaultCount(cat.id);
        return _buildCategoryCard(cat, faultCount);
      },
    );
  }

  Widget _buildCategoryCard(EquipmentCategory cat, int faultCount) {
    final catColor = Color(cat.color);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => FaultsScreen(categoryId: cat.id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: catColor.withOpacity(0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: catColor.withOpacity(0.1),
              blurRadius: 12,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                cat.icon,
                style: const TextStyle(fontSize: 40),
              ),
              const SizedBox(height: 8),
              Text(
                cat.nameAr,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.white,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 2),
              Text(
                cat.nameEn,
                style: TextStyle(
                  fontSize: 11,
                  color: AppTheme.grayText,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: catColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: catColor.withOpacity(0.3)),
                ),
                child: Text(
                  '$faultCount عطل',
                  style: TextStyle(
                    fontSize: 11,
                    color: catColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off, size: 60, color: AppTheme.grayText),
            const SizedBox(height: 12),
            Text(
              'مفيش نتائج',
              style: TextStyle(
                fontSize: 18,
                color: AppTheme.grayText,
              ),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final fault = _searchResults[index];
        final cat = getCategoryById(fault.categoryId);
        return _buildFaultResultCard(fault, cat);
      },
    );
  }

  Widget _buildFaultResultCard(Fault fault, EquipmentCategory? cat) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => FaultDetailScreen(fault: fault),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.subtleBorder),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              if (cat != null)
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color(cat.color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(cat.icon, style: const TextStyle(fontSize: 22)),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      fault.title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.white,
                      ),
                      textDirection: TextDirection.rtl,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      fault.warning.length > 60
                          ? '${fault.warning.substring(0, 60)}...'
                          : fault.warning,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.grayText,
                      ),
                      textDirection: TextDirection.rtl,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_left, color: AppTheme.cyanGlow, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AppTheme.cardBg,
      child: SafeArea(
        child: Column(
          children: [
            // Header with logo
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.cyanGlow.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'المساعد الذكي',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.cyanGlow,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Mohamed_Bn_saber',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.greenNeon,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppTheme.subtleBorder, thickness: 1),
            // Categories list
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ...categories.map((cat) {
                    return _buildDrawerItem(
                      icon: cat.icon,
                      title: cat.nameAr,
                      subtitle: cat.nameEn,
                      color: Color(cat.color),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                FaultsScreen(categoryId: cat.id),
                          ),
                        );
                      },
                    );
                  }),
                  const Divider(color: AppTheme.subtleBorder, thickness: 1),
                  _buildDrawerItem(
                    icon: '📚',
                    title: 'الشروحات',
                    subtitle: 'Guides',
                    color: AppTheme.amber,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const GuidesScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: '📋',
                    title: 'التقارير',
                    subtitle: 'Reports',
                    color: AppTheme.cyanGlow,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ReportsScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(color: AppTheme.subtleBorder, thickness: 1),
                  _buildDrawerItem(
                    icon: '👑',
                    title: 'إضافة محتوى',
                    subtitle: 'Admin',
                    color: AppTheme.greenNeon,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const AdminScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Text(icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.white,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppTheme.grayText,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_left, color: color, size: 18),
          ],
        ),
      ),
    );
  }
}
