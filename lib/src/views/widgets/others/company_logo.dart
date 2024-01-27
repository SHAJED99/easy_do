import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CompanyLogo extends StatelessWidget {
  const CompanyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(Theme.of(context).brightness == Brightness.light ? "lib/assets/logos/logo_big.svg" : "lib/assets/logos/logo_big.svg");

    //   // colorFilter: Theme.of(context).brightness == Brightness.light
    //   //     ? null
    //   //     : ColorFilter.mode(
    //   //         Theme.of(context).colorScheme.primary,
    //   //         BlendMode.srcIn,
    //   //       ),
    // return Image.asset("lib/assets/logos/logo_big.png");
  }
}
