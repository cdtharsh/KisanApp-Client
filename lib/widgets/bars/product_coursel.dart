import 'package:flutter/material.dart';
import 'package:kisanapp/widgets/layouts/product_card.dart';

class ProductCarousel extends StatelessWidget {
  final List<Map<String, String>> products;

  const ProductCarousel({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Featured Products',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SizedBox(
          height: 350, // You can adjust the height as needed
          child: ListView.builder(
            shrinkWrap: true, // Prevents it from taking up unnecessary space
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ProductCard(
                  imageUrl: product['image']!,
                  title: product['title']!,
                  price: product['price']!,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
