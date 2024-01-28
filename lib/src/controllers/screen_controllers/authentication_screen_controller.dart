import 'package:easy_do/src/controllers/data_controllers/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationScreenController extends GetxController {
  final DataController _controller = Get.find();
  final RxBool isLogin = true.obs;
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onClose() {
    super.onClose();
    nameC.dispose();
    ageC.dispose();
    emailC.dispose();
    passwordC.dispose();
    rePasswordC.dispose();
  }

  resetFields() {
    nameC.clear();
    ageC.clear();
    emailC.clear();
    passwordC.clear();
    rePasswordC.clear();
  }

  devFunction1() {
    isLogin.value = true;
    emailC.text = "user@jotno.dev";
    passwordC.text = "12345678";
  }

  devFunction2() {
    isLogin.value = false;
    nameC.text = "abc abc abc";
    emailC.text = "abc_${DateTime.now().microsecond}@gmail.com";
    ageC.text = "18";
    passwordC.text = "12345678";
    rePasswordC.text = "12345678";
  }

  final TextEditingController nameC = TextEditingController();
  final TextEditingController ageC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final TextEditingController rePasswordC = TextEditingController();

  Future<bool> login() async {
    Map<String, dynamic>? sendData;
    if (!isLogin.value) {
      sendData = {
        "name": nameC.text.trim(),
        "age": ageC.text.trim(),
      };
    }

    return await _controller.login(email: emailC.text.trim(), password: passwordC.text.trim(), map: sendData);
  }
}
