import 'package:flutter/material.dart';

class PageModel {
  final Widget? headingIcon;
  final String pageHeading;
  final String svg;
  final Widget page;

  PageModel({
    required this.pageHeading,
    this.headingIcon,
    this.svg = "",
    required this.page,
  });
}
