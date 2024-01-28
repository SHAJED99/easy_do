import 'package:easy_do/components.dart';
import 'package:easy_do/src/controllers/screen_controllers/authentication_screen_controller.dart';
import 'package:easy_do/src/controllers/services/dev_functions/dev_auto_fill_button.dart';
import 'package:easy_do/src/controllers/services/functions/form_validation.dart';
import 'package:easy_do/src/views/screens/dashboard_screens/dashboard_wrapper_screen.dart';
import 'package:easy_do/src/views/widgets/base_widgets/custom_animated_size_widget.dart';
import 'package:easy_do/src/views/widgets/others/custom_icon.dart';
import 'package:easy_do/src/views/widgets/text_fields/custom_text_field1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_process_button_widget/on_process_button_widget.dart';

class LoginTab extends StatefulWidget {
  const LoginTab(this.box, {super.key});
  final BoxConstraints box;

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  final AuthenticationScreenController _controller = Get.put(AuthenticationScreenController());

  late final RxBool correctName;
  late final RxBool correctAge;
  late final RxBool correctEmail;
  late final RxBool correctPassword;
  late final RxBool samePassword;

  @override
  void initState() {
    super.initState();

    correctName = false.obs;
    correctAge = false.obs;
    correctEmail = false.obs;
    correctPassword = false.obs;
    samePassword = false.obs;
  }

  resetFields() {
    correctName.value = false;
    correctAge.value = false;
    correctEmail.value = false;
    correctPassword.value = false;
    samePassword.value = false;
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<AuthenticationScreenController>();
  }

  void isSamePassword() => samePassword.value = _controller.rePasswordC.text.trim() == _controller.passwordC.text.trim();

  String? get reEnterPasswordMessage {
    if (correctPassword.value && !samePassword.value) return "Password does not match";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(
      () => Center(
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
                      : _InputField(
                          textEditingController: _controller.nameC,
                          titleText: "Name",
                          hintText: "Type name here",
                          keyboardType: TextInputType.name,
                          showError: !correctName.value,
                          onChanged: (v) => correctName.value = nameValidation(v) == null,
                          validator: (value) => _controller.isLogin.value ? null : nameValidation(value),
                        ),
                ),

                //! Age

                CustomAnimatedSize(
                  alignment: Alignment.topCenter,
                  widthFactor: 1,
                  child: !_controller.isLogin.value && correctName.value
                      ? _InputField(
                          textEditingController: _controller.ageC,
                          titleText: "Age",
                          hintText: "Age",
                          keyboardType: TextInputType.number,
                          showError: !correctAge.value,
                          onChanged: (v) => correctAge.value = ageValidation(v) == null,
                          validator: (value) => _controller.isLogin.value ? null : ageValidation(value),
                        )
                      : null,
                ),

                //! Email
                _InputField(
                  textEditingController: _controller.emailC,
                  titleText: "Email",
                  hintText: "Type email here",
                  keyboardType: TextInputType.emailAddress,
                  showError: !correctEmail.value,
                  onChanged: (v) => correctEmail.value = emailValidation(v) == null,
                  validator: (value) => emailValidation(value, showDetails: !_controller.isLogin.value),
                ),

                //! Passwords
                _InputField(
                  textEditingController: _controller.passwordC,
                  titleText: "Password",
                  hintText: "Type password here",
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  showError: !correctPassword.value,
                  validator: (value) => passwordValidation(value, showDetails: !_controller.isLogin.value),
                  onChanged: (v) {
                    correctPassword.value = passwordValidation(v) == null;
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
                          textEditingController: _controller.rePasswordC,
                          titleText: "Retype Password",
                          hintText: "Re-enter your password",
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          showError: !samePassword.value,
                          validator: (value) => _controller.isLogin.value ? null : reEnterPasswordMessage,
                          onChanged: (v) {
                            isSamePassword();
                          },
                        ),
                ),

                //! Submit Button
                _SubmitButton(),

                //! Forgo  password Button
                _GroupButton(resetFields),

                SizedBox(height: MediaQuery.of(context).padding.bottom + defaultPadding),

                DevAutoFillButton(
                  onPressed: [
                    () => _controller.devFunction1(),
                    () => _controller.devFunction2(),
                  ],
                )
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
    this.validator,
  });
  final String titleText;
  final String hintText;
  final TextEditingController? textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool showError;
  final Function(String v)? onChanged;
  final String? Function(String? value)? validator;

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
          validator: validator,
        ),
      ],
    );
  }
}

class _GroupButton extends StatelessWidget {
  _GroupButton(this.onPress);
  final AuthenticationScreenController _controller = Get.find();
  final Function() onPress;

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
                onPress();
                _controller.resetFields();
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
    return Center(
      child: OnProcessButtonWidget(
        margin: EdgeInsets.symmetric(vertical: defaultPadding),
        onTap: () async {
          bool isValid = _controller.loginFormKey.currentState?.validate() ?? false;
          if (!isValid) return false;

          return await _controller.login();
        },
        onDone: (isSuccess) {
          if (isSuccess == null || !isSuccess) return;
          Get.offAll(() => const DashboardWrapperScreen());
        },
        child: Text(_controller.isLogin.value ? "Sign In" : "Sign Up"),
      ),
    );
  }
}

Widget ____size([double i = 1]) => SizedBox(height: defaultPadding / i, width: defaultPadding / i);
