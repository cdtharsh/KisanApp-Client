import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/poster_model.dart';
import '../../services/api/posters/poster_api_service.dart';
import '../../utils/constants/colors.dart';

class PosterSection extends StatefulWidget {
  const PosterSection({super.key});

  @override
  PosterSectionState createState() => PosterSectionState();
}

class PosterSectionState extends State<PosterSection> {
  List<Poster> posters = [];
  bool isLoading = true;
  final double maxWidth = 400.0; // Maximum width for each poster

  @override
  void initState() {
    super.initState();
    _fetchPosters();
  }

  Future<void> _fetchPosters() async {
    final apiService = PosterApiService();
    try {
      final response = await apiService.getPosters();
      final List<dynamic> postersData = response['data'];
      setState(() {
        posters = postersData.map((poster) {
          return Poster(
            title: poster['posterName'],
            imageUrl: poster['imageUrl'] == "no_url"
                ? "https://via.placeholder.com/150"
                : poster['imageUrl'],
          );
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 200,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: posters.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                    width: screenWidth * 0.5 > maxWidth
                        ? maxWidth
                        : screenWidth * 0.5,
                    decoration: BoxDecoration(
                      color: randomPosterBgColors[
                          index % randomPosterBgColors.length],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Ensures content is spread across the available space
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                posters[index].title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis),
                                maxLines: 2,
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                child: const Text(
                                  "Get Now",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: AspectRatio(
                                aspectRatio: 1, // Square aspect ratio
                                child: Image.network(
                                  posters[index].imageUrl,
                                  fit: BoxFit.fitWidth,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: progress.expectedTotalBytes !=
                                                null
                                            ? progress.cumulativeBytesLoaded /
                                                progress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error,
                                        color: Colors.red);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
