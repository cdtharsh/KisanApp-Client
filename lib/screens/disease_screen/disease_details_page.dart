import 'dart:io';
import 'package:flutter/material.dart';

class DiseaseDetailsPage extends StatelessWidget {
  final String imagePath;
  final Map<String, dynamic> predictionData;

  const DiseaseDetailsPage({
    super.key,
    required this.imagePath,
    required this.predictionData,
  });

  // === Helper Methods ===

  String _formatDynamicContent(dynamic content) {
    if (content is List) return content.join(', ');
    return content.toString();
  }

  List<String> _convertToList(dynamic content) {
    if (content is List) return content.map((e) => e.toString()).toList();
    return [content.toString()];
  }

  // === UI Widgets ===

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String title, dynamic value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      shadowColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _formatDynamicContent(value),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageReferences(List<dynamic> urls) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: urls.length,
            itemBuilder: (context, index) {
              final url = urls[index].toString();
              return Container(
                width: 160,
                margin: EdgeInsets.only(right: 12, left: index == 0 ? 4 : 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (context, error, stack) => Container(
                      color: Colors.grey[100],
                      child: const Center(
                        child: Icon(Icons.broken_image,
                            color: Colors.grey, size: 40),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTreatment(Map<String, dynamic>? treatmentData) {
    if (treatmentData == null) return const SizedBox.shrink();

    Widget buildCard(
      String title,
      Map<String, dynamic> data,
      Color bg,
      Color label,
      IconData icon,
    ) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: bg,
        shadowColor: label.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title with icon
              Row(
                children: [
                  Icon(icon, color: label, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: label,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Description
              if (data['description'] != null)
                Text(
                  _formatDynamicContent(data['description']),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[800],
                    height: 1.4,
                  ),
                ),

              // Chemicals (no constraints, fill full row)
              if (data['chemicals'] != null) ...[
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _convertToList(data['chemicals']).map((chem) {
                        return Chip(
                          label: Text(
                            chem,
                            style: TextStyle(
                              color: label,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          backgroundColor: label.withOpacity(0.15),
                          shape: StadiumBorder(
                            side: BorderSide(color: label.withOpacity(0.4)),
                          ),
                          elevation: 2,
                          shadowColor: label.withOpacity(0.2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],

              // Notes
              if (data['notes'] != null) ...[
                const SizedBox(height: 16),
                Divider(color: label.withOpacity(0.3)),
                const SizedBox(height: 6),
                Text(
                  "Note: ${_formatDynamicContent(data['notes'])}",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    final chemical = treatmentData['chemical'];
    final organic = treatmentData['organic'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Treatment Options"),
        const SizedBox(height: 20),
        if (chemical != null)
          buildCard(
            'Chemical Treatment',
            Map<String, dynamic>.from(chemical),
            Colors.blue.shade50,
            Colors.blue.shade900,
            Icons.science,
          ),
        if (chemical != null && organic != null) const SizedBox(height: 20),
        if (organic != null)
          buildCard(
            'Organic Treatment',
            Map<String, dynamic>.from(organic),
            Colors.green.shade50,
            Colors.green.shade900,
            Icons.eco,
          ),
      ],
    );
  }

  Widget _buildPreventiveMeasures(Map<String, dynamic> data) {
    Widget buildItem(String title, dynamic content, IconData icon) {
      final items = _convertToList(content);
      if (items.isEmpty) return const SizedBox.shrink();

      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(icon, color: Colors.green[700]),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold))
            ]),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Icon(Icons.circle, size: 6)),
                        const SizedBox(width: 6),
                        Expanded(
                            child: Text(item,
                                style: const TextStyle(fontSize: 14))),
                      ]),
                )),
          ],
        ),
      );
    }

    if (data.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Preventive Measures"),
        if (data['cultural_practices'] != null)
          buildItem(
              'Cultural Practices', data['cultural_practices'], Icons.eco),
        if (data['field_monitoring'] != null)
          buildItem(
              'Field Monitoring', data['field_monitoring'], Icons.visibility),
      ],
    );
  }

  Widget _buildIdentification(Map<String, dynamic> data) {
    Widget buildItem(String title, dynamic content, IconData icon) {
      final items = _convertToList(content);
      if (items.isEmpty) return const SizedBox.shrink();

      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(icon, color: Colors.green[700]),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold))
            ]),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Icon(Icons.circle, size: 6)),
                        const SizedBox(width: 6),
                        Expanded(
                            child: Text(item,
                                style: const TextStyle(fontSize: 14))),
                      ]),
                )),
          ],
        ),
      );
    }

    if (data.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Identification"),
        if (data['visual_symptoms'] != null)
          buildItem(
              'Visual Symptoms', data['visual_symptoms'], Icons.visibility),
        if (data['progression'] != null)
          buildItem('Progression', data['progression'], Icons.timeline),
        if (data['differential_diagnosis'] != null)
          buildItem('Differential Diagnosis', data['differential_diagnosis'],
              Icons.compare_arrows),
      ],
    );
  }
  // === Build Method ===

  @override
  Widget build(BuildContext context) {
    final cropHealth =
        _formatDynamicContent(predictionData['crop_health'] ?? 'Unknown');
    final isHealthy = cropHealth.toLowerCase() == 'healthy';
    final diagnoses =
        predictionData['predicted_diagnoses'] as List<dynamic>? ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease Diagnosis',
            style: TextStyle(color: Colors.black, fontSize: 20)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
        actions: [IconButton(icon: const Icon(Icons.share), onPressed: () {})],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(imagePath),
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: isHealthy
                              ? [Colors.green, Colors.green.shade400]
                              : [Colors.orange.shade700, Colors.red]),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2), blurRadius: 6)
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(isHealthy ? Icons.check_circle : Icons.warning,
                            color: Colors.white, size: 16),
                        const SizedBox(width: 6),
                        Text(cropHealth.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (diagnoses.isEmpty)
              Center(
                child: Column(
                  children: [
                    Icon(Icons.check_circle_outline,
                        size: 48, color: Colors.green[400]),
                    const SizedBox(height: 8),
                    const Text("No diseases detected",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text("Your plant appears to be healthy",
                        style:
                            TextStyle(fontSize: 14, color: Colors.grey[600])),
                  ],
                ),
              ),
            ...diagnoses.map((disease) {
              final diag = Map<String, dynamic>.from(disease);
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      '${diag['common_name'] ?? 'Unknown Disease'} (${predictionData['predicted_confidence']?.toString() ?? '0'}%)',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    if (diag['scientific_name'] != null)
                      Text(
                          predictionData['crops'] != null
                              ? 'Crops: ${_formatDynamicContent(predictionData['crops'])}'
                              : 'Crops: Not specified',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black54)),
                    Text('Scientific Name: ${diag['scientific_name']}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54)),
                    const SizedBox(height: 8),

                    // Diagnosis likelihood + pathogen class cards row
                    Row(
                      children: [
                        if (diag['hosts'] != null)
                          Expanded(child: _infoCard('Hosts', diag['hosts'])),
                        if (diag['pathogen_class'] != null)
                          Expanded(
                              child: _infoCard(
                                  'Pathogen Class', diag['pathogen_class'])),
                      ],
                    ),

                    const SizedBox(height: 12),

                    if (diag['triggers'] != null) ...[
                      _sectionTitle("Triggers"),
                      Text(
                        _formatDynamicContent(diag['triggers']),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],

                    if (diag['images'] != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: _buildImageReferences(diag['images']),
                      ),

                    const SizedBox(height: 16),

                    if (diag['treatment'] != null)
                      _buildTreatment(
                          Map<String, dynamic>.from(diag['treatment'])),

                    const SizedBox(height: 16),

                    if (diag['preventive_measures'] != null)
                      _buildPreventiveMeasures(Map<String, dynamic>.from(
                          diag['preventive_measures'])),

                    const SizedBox(height: 16),

                    if (diag['identification'] != null)
                      _buildIdentification(
                          Map<String, dynamic>.from(diag['identification'])),
                  ]);
            }).toList(),
          ]),
        ),
      ),
    );
  }
}
