import 'package:flutter/material.dart';

import '../home_screen/poster_section.dart';

class DripProductPage extends StatelessWidget {
  const DripProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drip Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PosterSection(posterType: 'Drip'), // Filter posters by 'Agri'
      ),
    );
  }
}
