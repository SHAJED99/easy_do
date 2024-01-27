import 'package:easy_do/components.dart';
import 'package:easy_do/src/controllers/data_controllers/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationScreenController extends GetxController {
  final DataController _controller = Get.find();
  final RxBool isLogin = true.obs;
  final loginFormKey = GlobalKey<FormState>();

  String get version => _controller.packageInfo.value?.version ?? "";

  final RxBool isInit = false.obs;
  final RxBool isSplashScreenDone = false.obs;

  void initApp() {
    _controller.initApp().then((_) {
      isInit.value = true;
      gotoHome();
    });
    Future.delayed(defaultSplashScreenShow).then((_) {
      isSplashScreenDone.value = true;
      gotoHome();
    });
  }

  devFunction1() {
    isLogin.value = true;
    emailC.text = "user@jotno.dev";
    passwordC.text = "12345678";
  }

  @override
  void onClose() {
    super.onClose();
    nameC.dispose();
    ageC.dispose();
    emailC.dispose();
    passwordC.dispose();
  }

  resetFields() {
    nameC.clear();
    ageC.clear();
    emailC.clear();
    passwordC.clear();
  }

  gotoHome() {
    // if (isSplashScreenDone.value && isInit.value) {
    //   if (_controller.isLogin()) {
    //     // Get.offAll(() => const DashboardScreenWrapper());
    //     // Get.offAll(() => const SettingScreenWrapper());
    //   } else {
    //     // expendLogin.value = true;
    //     // greetingText.value = "Welcome to $projectName";
    //   }
    // }
  }

  TextEditingController nameC = TextEditingController();
  TextEditingController ageC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  Future<bool> login() async {
    return await _controller.login(email: emailC.text.trim(), password: passwordC.text.trim());
  }
}
