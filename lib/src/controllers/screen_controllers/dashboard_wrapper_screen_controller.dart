import 'package:easy_do/components.dart';
import 'package:easy_do/src/models/pojo_classes/page_model.dart';
import 'package:easy_do/src/views/screens/dashboard_screens/home_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardWrapperScreenController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentItem = 0.obs;

  final List<PageModel> pages = [
    PageModel(pageHeading: "Home", page: const HomeTab()),
    PageModel(pageHeading: "Tasks", page: const HomeTab()),
    PageModel(pageHeading: "Profile", page: const HomeTab()),
  ];

  changePage([int? index]) {
    currentItem.value = index ?? 0;
    pageController.animateToPage(currentItem.value, duration: defaultDuration, curve: defaultCurve);
  }
}
