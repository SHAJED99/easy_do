import 'package:easy_do/components.dart';
import 'package:flutter/material.dart';

class CompanyLogo extends StatelessWidget {
  const CompanyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // return SvgPicture.asset(Theme.of(context).brightness == Brightness.light ? "lib/assets/logos/logo_full.svg" : "lib/assets/logos/logo_full.svg");

    return Container(
      padding: EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light ? null : scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(defaultPadding / 2),
      ),
      child: Image.asset("lib/assets/logos/logo_full.png"),
    );
  }
}
