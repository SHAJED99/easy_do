import 'package:easy_do/src/controllers/data_controllers/database_handler.dart';
import 'package:easy_do/src/controllers/services/api/api_services.dart';
import 'package:easy_do/src/controllers/services/error_handlers/error_handler.dart';
import 'package:easy_do/src/models/response_models/task_list_response_model.dart';
import 'package:easy_do/src/models/response_models/user_response_model.dart';
import 'package:easy_do/src/views/screens/authentication_screens/splash_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DataController extends GetxController {
  bool _isInit = false;
  late final LocalDataHandler localData;
  final Rx<PackageInfo?> packageInfo = Rxn();
  late final ApiServices _apiServices;
  late final ErrorHandler _errorHandler;

  Future<void> initApp() async {
    if (_isInit) return;
    await _initializingVariables();
    await _startupTask();
    await addingListeners();

    _isInit = true;
  }

  //! ---------------------------------------------------------------------------------------------- Initializing App (All init task will be execute here)
  Future<void> _initializingVariables() async {
    localData = LocalDataHandler();
    _apiServices = ApiServices();
    _errorHandler = ErrorHandler();
  }

  //! ---------------------------------------------------------------------------------------------- Run this function when started
  Future<void> _startupTask() async {
    packageInfo.value = await PackageInfo.fromPlatform();
    await localData.initApp(); // Initializing local data
    await _appSettingTask();
  }

  //! ---------------------------------------------------------------------------------------------- Listeners
  Future<void> addingListeners() async {
    localData.localDataModel.user.listen((_) async => await _userTask());
    localData.localDataModel.appSetting.listen((_) async => await _appSettingTask());
  }

  // App Setting
  Future<void> _appSettingTask() async => _currentTheme();

  void _currentTheme() {
    if (localData.localDataModel.appSetting.value.isDarkMode == null) {
      Get.changeThemeMode(ThemeMode.system);
    } else {
      Get.changeThemeMode(localData.localDataModel.appSetting.value.isDarkMode! ? ThemeMode.dark : ThemeMode.light); // Theme change
    }
  }

  void changeTheme({bool? isDarkMode}) => localData.localDataModel.appSetting.value = localData.localDataModel.appSetting.value.copyWith(isDarkMode: isDarkMode);

  // User
  Future<void> _userTask() async {
    if (isLogin()) {
    } else {
      if (_isInit) Get.offAll(() => const SplashTab()); // Login out
    }
  }

  //! ---------------------------------------------------------------------------------------------- Auth Handler
  bool isLogin() => localData.localDataModel.user.value.isLogin();

  void forceLogout() => logout();

  void logout() {
    localData.localDataModel.user.value = UserResponseModel();
  }

  //! ---------------------------------------------------------------------------------------------- Login Screen
  Future<bool> login({required String email, required String password, Map<String, dynamic>? map}) async {
    UserResponseModel? res;
    await _errorHandler.errorHandler(function: () async => res = await _apiServices.login(email, password, map: map));
    if (res == null) return false;
    localData.localDataModel.user.value = res!;
    return true;
  }

  //! ---------------------------------------------------------------------------------------------- Dashboard
  Future<TaskListResponseModel?> getTaskList() async {
    TaskListResponseModel? res;
    await _errorHandler.errorHandler(function: () async => res = await _apiServices.getTaskList());
    return res;
  }
}
