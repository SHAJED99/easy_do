import 'package:easy_do/components.dart';
import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon(this.icon, {super.key, this.size, this.color, this.padding});
  final IconData? icon;
  final double? size;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size ?? defaultPadding,
      color: color ?? Theme.of(context).colorScheme.onBackground,
    );
  }
}
