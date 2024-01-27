import 'package:easy_do/components.dart';
import 'package:easy_do/src/controllers/screen_controllers/authentication_screen_controller.dart';
import 'package:easy_do/src/controllers/services/dev_functions/dev_auto_fill_button.dart';
import 'package:easy_do/src/controllers/services/functions/colors.dart';
import 'package:easy_do/src/views/widgets/base_widgets/custom_animated_size_widget.dart';
import 'package:easy_do/src/views/widgets/others/company_logo.dart';
import 'package:easy_do/src/views/widgets/others/custom_icon.dart';
import 'package:easy_do/src/views/widgets/others/custom_loading_bar.dart';
import 'package:easy_do/src/views/widgets/text_fields/custom_text_field1.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:on_process_button_widget/on_process_button_widget.dart';

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
  void dispose() {
    super.dispose();
    Get.delete<AuthenticationScreenController>();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(builder: (context, box) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                constraints: BoxConstraints(minHeight: box.maxHeight),
                child: Column(
                  children: [
                    //! Top Logo
                    _Logo(box),

                    //! Input fields
                    _InputFields(box),
                  ],
                ),
              ),
            );
          }),
          Positioned(bottom: defaultPadding, left: 0, right: 0, child: _AppVersion()),
          Positioned(
              right: 0,
              bottom: 0,
              child: DevAutoFillButton(onPressed: [
                () => _controller.devFunction1(),
              ]))
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  _Logo(this.box);
  final AuthenticationScreenController _controller = Get.find();
  final BoxConstraints box;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = box.maxHeight;

    return Obx(
      () => AnimatedContainer(
        alignment: Alignment.center,
        duration: defaultDuration,
        height: !_controller.isSplashScreenDone.value ? height : height / 4,
        constraints: BoxConstraints(minHeight: theme.buttonTheme.height * 2 + (defaultPadding * 2)),
        padding: EdgeInsets.only(
          bottom: defaultPadding,
          top: defaultPadding + (!_controller.isSplashScreenDone.value ? defaultPadding : MediaQuery.of(context).padding.top),
        ),
        decoration: BoxDecoration(
          borderRadius: !_controller.isSplashScreenDone.value ? null : BorderRadius.vertical(bottom: Radius.circular(defaultPadding)),
          gradient: LinearGradient(colors: theme.brightness == Brightness.light ? defaultGradient : defaultGradient.map((e) => e.customInverseColor).toList(), begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: const FittedBox(child: CompanyLogo()),
      ),
    );
  }
}

class _InputFields extends StatefulWidget {
  const _InputFields(this.box);
  final BoxConstraints box;

  @override
  State<_InputFields> createState() => _InputFieldsState();
}

class _InputFieldsState extends State<_InputFields> {
  final AuthenticationScreenController _controller = Get.find();
  late final RxBool samePassword;
  late final RxString rePassword;

  @override
  void initState() {
    super.initState();
    samePassword = false.obs;
    rePassword = "".obs;
  }

  void isSamePassword() => samePassword.value = rePassword.value.trim() != _controller.passwordC.text.trim();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(
      () => !_controller.isSplashScreenDone.value
          ? const SizedBox()
          : Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: maxBoxWidth),
                padding: EdgeInsets.all(defaultPadding),
                child: Form(
                  key: _controller.loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_controller.isLogin.value ? "Sign In" : "Sign Up", style: theme.textTheme.displaySmall?.copyWith(color: theme.colorScheme.primary)),

                      //! Name
                      CustomAnimatedSize(
                        alignment: Alignment.topCenter,
                        widthFactor: 1,
                        child: _controller.isLogin.value
                            ? null
                            : Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: _InputField(
                                      textEditingController: _controller.nameC,
                                      titleText: "Name",
                                      hintText: "Type name here",
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  ____size(2),
                                  Expanded(
                                    child: _InputField(
                                      textEditingController: _controller.ageC,
                                      titleText: "Age",
                                      hintText: "Age",
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                      ),

                      //! Email
                      _InputField(
                        textEditingController: _controller.emailC,
                        titleText: "Email",
                        hintText: "Type email here",
                        keyboardType: TextInputType.emailAddress,
                      ),

                      //! Passwords
                      _InputField(
                        textEditingController: _controller.passwordC,
                        titleText: "Password",
                        hintText: "Type password here",
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        onChanged: (v) {
                          isSamePassword();
                        },
                      ),

                      //! Re-Password
                      CustomAnimatedSize(
                        alignment: Alignment.topCenter,
                        widthFactor: 1,
                        child: _controller.isLogin.value
                            ? null
                            : _InputField(
                                titleText: "Retype Password",
                                hintText: "Re-enter your password",
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                showError: samePassword.value,
                                onChanged: (v) {
                                  rePassword.value = v;
                                  isSamePassword();
                                },
                              ),
                      ),

                      //! Submit Button
                      _SubmitButton(),

                      //! Forgo  password Button
                      _GroupButton(),
                    ],
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
    this.showError = false,
    this.onChanged,
  });
  final String titleText;
  final String hintText;
  final TextEditingController? textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool showError;
  final Function(String v)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.titleLarge;
    final height = MediaQuery.textScalerOf(context).scale(textStyle?.fontSize ?? 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ____size(),
        Row(
          children: [
            Flexible(child: Text(titleText, textAlign: TextAlign.start, style: textStyle?.copyWith(color: theme.colorScheme.onBackground))),
            if (showError)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 4),
                child: CustomIcon(
                  Icons.error_sharp,
                  size: height,
                  color: theme.colorScheme.error,
                ),
              )
          ],
        ),
        ____size(2),
        CustomTextField1(
          hintText: hintText,
          textEditingController: textEditingController,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _AppVersion extends StatelessWidget {
  _AppVersion();
  final AuthenticationScreenController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.isSplashScreenDone.value
          ? const SizedBox()
          : Column(
              children: [
                const CustomCircularProgressBar(),
                ____size(2),
                Text(
                  _controller.version,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground),
                )
              ],
            ),
    );
  }
}

class _GroupButton extends StatelessWidget {
  _GroupButton();
  final AuthenticationScreenController _controller = Get.find();

  Widget button(BuildContext context, String headingText, {Function? onDone}) {
    return OnProcessButtonWidget(
      expanded: false,
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.symmetric(vertical: defaultPadding / 4, horizontal: defaultPadding / 2),
      constraints: const BoxConstraints(),
      textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.primary),
      onDone: (_) {
        if (onDone != null) onDone();
      },
      child: Text(headingText),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: defaultPadding / 4),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAnimatedSize(child: !_controller.isLogin.value ? null : button(context, "Forgot Password")),
            Text("/", style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.primary)),
            button(
              context,
              _controller.isLogin.value ? "Sign up" : "Already have an account?",
              onDone: () {
                _controller.isLogin.value = !_controller.isLogin.value;
                // _controller.resetLogin();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  _SubmitButton();
  final AuthenticationScreenController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return OnProcessButtonWidget(
      margin: EdgeInsets.symmetric(vertical: defaultPadding),
      child: Text(_controller.isLogin.value ? "Sign In" : "Sign Up"),
    );
  }
}

Widget ____size([double i = 1]) => SizedBox(height: defaultPadding / i, width: defaultPadding / i);
