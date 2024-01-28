import 'package:flutter/material.dart';

extension ColorManipulation on Color {
  Color get customInverseColor => Color.fromRGBO(255 - red, 255 - green, 255 - blue, opacity);

  Color customBlendColors({required Color baseColor, required BlendModeType blendMode}) {
    double normalize(int value) => value / 255.0;

    int clamp(double value) => value.clamp(0, 255).toInt();

    switch (blendMode) {
      case BlendModeType.normal:
        return baseColor;

      case BlendModeType.multiply:
        return Color.fromARGB(
          baseColor.alpha,
          clamp(normalize(baseColor.red) * normalize(red) * 255),
          clamp(normalize(baseColor.green) * normalize(green) * 255),
          clamp(normalize(baseColor.blue) * normalize(blue) * 255),
        );

      case BlendModeType.screen:
        return Color.fromARGB(
          baseColor.alpha,
          clamp((1 - (1 - normalize(baseColor.red)) * (1 - normalize(red))) * 255),
          clamp((1 - (1 - normalize(baseColor.green)) * (1 - normalize(green))) * 255),
          clamp((1 - (1 - normalize(baseColor.blue)) * (1 - normalize(blue))) * 255),
        );

      default:
        return baseColor;
    }
  }
}

enum BlendModeType {
  normal,
  multiply,
  screen,
}
