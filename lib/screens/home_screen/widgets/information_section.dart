import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../widgets/layouts/grid_layout.dart';

class InformationSectionCard extends StatelessWidget {
  const InformationSectionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade100, Colors.blue.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double gridItemHeight = (constraints.maxHeight - 30) / 2;
            final double gridItemWidth = (constraints.maxWidth - 24) / 2;
            final double aspectRatio = gridItemWidth / gridItemHeight;

            return GridView.builder(
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: aspectRatio,
              ),
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final items = [
                  {
                    'title': 'Crop Information',
                    'icon': Icons.info,
                    'color': Colors.green.shade300,
                    'background': Colors.green.shade100
                  },
                  {
                    'title': 'Pest and Diseases',
                    'icon': Icons.bug_report,
                    'color': Colors.red.shade300,
                    'background': Colors.red.shade100
                  },
                  {
                    'title': 'Soil Testing',
                    'icon': Icons.medical_information,
                    'color': kDarkColor,
                    'background': Colors.orange.shade100
                  },
                  {
                    'title': 'Alerts',
                    'icon': Icons.error,
                    'color': Colors.pink.shade300,
                    'background': Colors.pink.shade100
                  },
                ];

                final item = items[index];
                return GridCard(
                  title: item['title'] as String,
                  icon: item['icon'] as IconData,
                  iconColor: item['color'] as Color,
                  backgroundColor: item['background'] as Color,
                  height: gridItemHeight,
                  onTap: () {},
                );
              },
            );
          },
        ),
      ),
    );
  }
}
