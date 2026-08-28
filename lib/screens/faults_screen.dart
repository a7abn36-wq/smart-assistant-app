import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../theme/app_theme.dart';
import 'fault_detail_screen.dart';

class FaultsScreen extends StatelessWidget {
  final String categoryId;

  const FaultsScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final category = getCategoryById(categoryId);
    final faults = getFaultsByCategory(categoryId);
    final catColor = category != null ? Color(category.color) : AppTheme.cyanGlow;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          backgroundColor: AppTheme.darkBg,
          title: Text(
            category?.nameAr ?? '',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: catColor,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppTheme.cyanGlow),
        ),
        body: faults.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 60, color: AppTheme.grayText),
                    const SizedBox(height: 12),
                    Text(
                      'مفيش أعطال مسجلة',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppTheme.grayText,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: faults.length,
                itemBuilder: (context, index) {
                  return _buildFaultCard(context, faults[index], catColor);
                },
              ),
      ),
    );
  }

  Widget _buildFaultCard(BuildContext context, Fault fault, Color catColor) {
    String shortWarning = fault.warning.length > 50
        ? '${fault.warning.substring(0, 50)}...'
        : fault.warning;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => FaultDetailScreen(fault: fault),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.subtleBorder),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border(
              right: BorderSide(color: AppTheme.fireRed, width: 4),
            ),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                    child: Text(
                      fault.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.white,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_left,
                      color: AppTheme.cyanGlow, size: 20),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  const Icon(Icons.warning_amber,
                      color: AppTheme.fireRed, size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      shortWarning,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.grayText,
                      ),
                      textDirection: TextDirection.rtl,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
