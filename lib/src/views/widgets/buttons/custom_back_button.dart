import 'package:easy_do/components.dart';
import 'package:easy_do/src/views/widgets/others/custom_icon.dart';
import 'package:easy_do/src/views/widgets/others/custom_size_builder.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomBackButtonWidget extends StatelessWidget {
  const CustomBackButtonWidget({
    super.key,
    this.color,
    this.onTap,
    this.icon = Icons.arrow_back_ios_new_outlined,
  });

  final void Function()? onTap;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: defaultPadding / 4),
      child: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: Material(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(Theme.of(context).appBarTheme.toolbarHeight ?? 0),
            child: InkWell(
              onTap: () {
                if (onTap != null) {
                  onTap!();
                } else {
                  Get.back();
                }
              },
              child: CustomSizeBuilder(
                child: CustomIcon(icon, color: color),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
