import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../theme/app_theme.dart';
import 'guide_detail_screen.dart';

class GuidesScreen extends StatelessWidget {
  const GuidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          backgroundColor: AppTheme.darkBg,
          title: Text(
            '📚 الشروحات',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.cyanGlow,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppTheme.cyanGlow),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: allGuides.length,
          itemBuilder: (context, index) {
            final guide = allGuides[index];
            return _buildGuideCard(context, guide);
          },
        ),
      ),
    );
  }

  Widget _buildGuideCard(BuildContext context, Guide guide) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => GuideDetailScreen(guide: guide),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.cyanGlow.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: AppTheme.cyanGlow.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              // Left side: step count + image indicator
              Column(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppTheme.cyanGlow.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${guide.steps.length}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.cyanGlow,
                      ),
                    ),
                  ),
                  if (guide.hasImage) ...[
                    const SizedBox(height: 4),
                    Text(
                      '📸',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ],
              ),
              const SizedBox(width: 14),
              // Right side: title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      guide.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.white,
                      ),
                      textDirection: TextDirection.rtl,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${guide.steps.length} خطوة${guide.hasImage ? ' • 📸 صورة توضيحية' : ''}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.grayText,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_left,
                  color: AppTheme.cyanGlow, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
