import 'package:easy_do/components.dart';
import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  const Button1({
    super.key,
    this.backgroundImage,
    this.width,
    this.constraints,
    this.decoration,
    this.padding,
    this.child,
    this.alignment = Alignment.centerLeft,
    this.color,
    this.margin,
    this.elevation = 0,
    this.shadowColor,
    this.onTap,
    this.borderColor,
  });
  final String? backgroundImage;
  final double? width;
  final BoxConstraints? constraints;
  final Decoration? decoration;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final AlignmentGeometry? alignment;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final double elevation;
  final Color? shadowColor;
  final void Function()? onTap;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        shadowColor: shadowColor,
        elevation: elevation,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(defaultPadding / 2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderColor == null ? null : BorderRadius.circular(defaultPadding / 2),
            border: borderColor == null ? null : Border.all(width: borderWidth2, color: borderColor!),
            image: backgroundImage == null ? null : DecorationImage(image: AssetImage(backgroundImage!), fit: BoxFit.cover, alignment: Alignment.center),
          ),
          child: Material(
            color: color ?? Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: AnimatedContainer(
                duration: defaultDuration,
                width: width,
                constraints: constraints,
                padding: padding ?? EdgeInsets.all(defaultPadding / 2),
                alignment: alignment,
                decoration: decoration,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
