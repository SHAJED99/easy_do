import 'package:easy_do/components.dart';
import 'package:flutter/material.dart';

class CustomCircularProgressBar extends StatelessWidget {
  const CustomCircularProgressBar({super.key, this.color, this.size});
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    double s = size ?? defaultPadding;
    return SizedBox(
        width: s,
        height: s,
        child: FittedBox(
          child: CircularProgressIndicator(
            color: color ?? Theme.of(context).colorScheme.primary,
          ),
        ));
  }
}

// LinearProgressIndicator

class CustomLinearProgressBar extends StatelessWidget {
  const CustomLinearProgressBar({super.key, this.color, this.size, this.show = true}) : _opacity = 0.1;
  final Color? color;
  final double? size;
  final bool show;

  const CustomLinearProgressBar.small({super.key, this.color, this.size = 2, this.show = true}) : _opacity = 1;

  final double _opacity;

  @override
  Widget build(BuildContext context) {
    double s = size ?? defaultPadding;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(s / 2)),
      height: s,
      child: show
          ? LinearProgressIndicator(
              color: color ?? Theme.of(context).colorScheme.primary.withOpacity(_opacity),
            )
          : null,
    );
  }
}
