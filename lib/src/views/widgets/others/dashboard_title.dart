import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.bold),
    );
  }
}
