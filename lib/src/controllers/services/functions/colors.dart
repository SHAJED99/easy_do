import 'package:flutter/material.dart';

extension ColorManipulation on Color {
  Color get customInverseColor => Color.fromRGBO(255 - red, 255 - green, 255 - blue, opacity);
}
