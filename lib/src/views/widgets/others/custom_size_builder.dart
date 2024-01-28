import 'package:easy_do/components.dart';
import 'package:flutter/material.dart';

class CustomSizeBuilder extends StatelessWidget {
  const CustomSizeBuilder({
    super.key,
    required this.child,
    this.constraints,
    this.alignment = Alignment.center,
    this.maxSize,
  });
  final Widget child;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  final double? maxSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) => Container(
        alignment: alignment,
        child: Container(
          height: box.maxHeight,
          width: box.maxWidth,
          constraints: constraints ?? BoxConstraints(maxHeight: maxSize ?? defaultPadding, maxWidth: maxSize ?? defaultPadding),
          child: FittedBox(
            child: child,
          ),
        ),
      ),
    );
  }
}
