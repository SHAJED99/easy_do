import 'package:easy_do/components.dart';
import 'package:easy_do/src/controllers/screen_controllers/authentication_screen_controller.dart';
import 'package:easy_do/src/controllers/services/functions/colors.dart';
import 'package:easy_do/src/views/widgets/base_widgets/custom_animated_size_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthenticationScreenController _controller = Get.put(AuthenticationScreenController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.initApp());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: Column(
        children: [
          //! Top Logo
          Expanded(
            child: Obx(
              () => AnimatedContainer(
                duration: defaultDuration,
                decoration: BoxDecoration(
                  borderRadius: !_controller.isSplashScreenDone.value ? null : BorderRadius.vertical(bottom: Radius.circular(defaultPadding)),
                  gradient: LinearGradient(colors: Theme.of(context).brightness == Brightness.light ? defaultGradient : defaultGradient.map((e) => e.customInverseColor).toList(), begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
              ),
            ),
          ),

          //! Input fields
          Obx(
            () => CustomAnimatedSize(
              child: !_controller.isSplashScreenDone.value ? null : SizedBox(height: height / 3 * 2),
            ),
          )
        ],
      ),
    );
  }
}
