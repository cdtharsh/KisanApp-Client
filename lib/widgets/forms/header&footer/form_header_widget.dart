import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({super.key, required this.image, required this.title, required this.subTitle, required this.size, required this.crossAxisAlignment});

  final double size;
  final String image, title, subTitle;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Image(
          image: AssetImage(image),
          fit: BoxFit.cover,
          height: size,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}