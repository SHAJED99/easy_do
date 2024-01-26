import 'package:easy_do/components.dart';
import 'package:easy_do/src/controllers/data_controllers/data_controller.dart';
import 'package:get/get.dart';

class AuthenticationScreenController extends GetxController {
  final DataController _controller = Get.find();
  final RxBool isSplashScreenDone = false.obs;

  void initApp() {
    // _controller.runApp().then((_) {
    //   isInit.value = true;
    //   gotoHome();
    // });
    Future.delayed(defaultSplashScreenShow).then((_) {
      isSplashScreenDone.value = true;
      gotoHome();
    });
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
}
