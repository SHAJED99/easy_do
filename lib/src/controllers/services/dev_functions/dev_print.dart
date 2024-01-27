import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

devPrint(dynamic message, {Color color = Colors.green}) {
  if (kDebugMode) {
    print("[Log] - $message");
  }
}
