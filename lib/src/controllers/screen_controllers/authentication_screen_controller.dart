import 'package:easy_do/src/controllers/data_controllers/data_controller.dart';
import 'package:get/get.dart';

class AuthenticationScreenController extends GetxController {
  final DataController _controller = Get.find();
  final RxBool isSplashScreenDone = false.obs;
}
