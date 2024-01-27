import 'package:easy_do/components.dart';
import 'package:easy_do/src/controllers/screen_controllers/authentication_screen_controller.dart';
import 'package:easy_do/src/controllers/services/functions/colors.dart';
import 'package:easy_do/src/views/widgets/base_widgets/custom_animated_size_widget.dart';
import 'package:easy_do/src/views/widgets/others/company_logo.dart';
import 'package:easy_do/src/views/widgets/text_fields/custom_text_field1.dart';
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
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(
                children: [
                  //! Top Logo
                  _Logo(),

                  //! Input fields
                  _InputFields(),
                  // Obx(
                  //   () => CustomAnimatedSize(
                  //     child: !_controller.isSplashScreenDone.value ? null : SizedBox(height: height / 3 * 2),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  _Logo();
  final AuthenticationScreenController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Obx(
      () => AnimatedContainer(
        alignment: Alignment.center,
        duration: defaultDuration,
        height: !_controller.isSplashScreenDone.value ? height : height / 4,
        constraints: BoxConstraints(minHeight: Theme.of(context).buttonTheme.height),
        padding: EdgeInsets.only(
          bottom: defaultPadding,
          top: defaultPadding + (!_controller.isSplashScreenDone.value ? defaultPadding : MediaQuery.of(context).padding.top),
        ),
        decoration: BoxDecoration(
          borderRadius: !_controller.isSplashScreenDone.value ? null : BorderRadius.vertical(bottom: Radius.circular(defaultPadding)),
          gradient: LinearGradient(colors: Theme.of(context).brightness == Brightness.light ? defaultGradient : defaultGradient.map((e) => e.customInverseColor).toList(), begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: FittedBox(
          child: const CompanyLogo(),
        ),
      ),
    );
  }
}

class _InputFields extends StatelessWidget {
  _InputFields();
  final AuthenticationScreenController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Obx(
      () => CustomAnimatedSize(
        widthFactor: 1,
        alignment: Alignment.topCenter,
        child: !_controller.isSplashScreenDone.value
            ? null
            : Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: maxBoxWidth),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_controller.isLogin.value ? "Sign In" : "Sign Up", style: theme.textTheme.displaySmall?.copyWith(color: theme.colorScheme.primary)),

                          // if()

                          //! Email
                          _InputField(
                            titleText: "Email",
                            hintText: "Type email here",
                            keyboardType: TextInputType.emailAddress,
                          ),

                          //! Passwords
                          _InputField(
                            titleText: "Password",
                            hintText: "Type password here",
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                          ),

                          //! Submit Button
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.titleText,
    required this.hintText,
    this.textEditingController,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });
  final String titleText;
  final String hintText;
  final TextEditingController? textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: defaultPadding),
        Text(titleText, textAlign: TextAlign.start, style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onBackground)),
        SizedBox(height: defaultPadding / 2),
        CustomTextField1(
          hintText: hintText,
          textEditingController: textEditingController,
          keyboardType: keyboardType,
          obscureText: obscureText,
        ),
      ],
    );
  }
}
