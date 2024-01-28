import 'package:easy_do/components.dart';
import 'package:easy_do/src/controllers/data_controllers/data_controller.dart';
import 'package:easy_do/src/models/pojo_classes/page_model.dart';
import 'package:easy_do/src/models/response_models/task_list_response_model.dart';
import 'package:easy_do/src/views/screens/dashboard_screens/home_tab.dart';
import 'package:easy_do/src/views/screens/dashboard_screens/profile_tab.dart';
import 'package:easy_do/src/views/screens/dashboard_screens/task_tab.dart';
import 'package:easy_do/src/views/widgets/others/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardWrapperScreenController extends GetxController {
  final DataController _controller = Get.find();
  final PageController pageController = PageController();
  final RxInt currentItem = 0.obs;

  final List<PageModel> pages = [
    PageModel(pageHeading: "Home", page: const HomeTab(), svg: "lib/assets/icons/home_tab.svg"),
    PageModel(pageHeading: "Tasks", page: const TaskTab(), svg: "lib/assets/icons/task_tab.svg"),
    PageModel(pageHeading: "Profile", page: const ProfileTab(), svg: "lib/assets/icons/person.svg"),
  ];

  changePage([int? index]) {
    currentItem.value = index ?? 0;
    pageController.animateToPage(currentItem.value, duration: defaultDuration, curve: defaultCurve);
  }

  @override
  void onInit() {
    super.onInit();

    getData();
  }

  //! ---------------------------------------------------------------------------------------------- Home Tab
  final Rx<TaskListResponseModel?> response = Rxn();
  final RxBool isLoading = false.obs;

  Future<void> getData() async {
    if (isLoading.value) return;

    isLoading.value = true;
    response.value = await _controller.getTaskList();
    isLoading.value = false;
  }
}
