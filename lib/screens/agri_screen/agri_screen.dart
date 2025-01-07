import 'package:flutter/material.dart';
import 'package:kisanapp/screens/home_screen/poster_section.dart';

class AgriProductPage extends StatelessWidget {
  const AgriProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agri Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PosterSection(),
      ),
    );
  }
}
