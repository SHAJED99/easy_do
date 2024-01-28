import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:easy_do/src/controllers/data_controllers/data_controller.dart';
import 'package:easy_do/src/controllers/services/error_handlers/app_exceptions.dart';
import 'package:easy_do/src/controllers/services/functions/string_formatter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tuple/tuple.dart';

class ErrorHandler {
  late final DataController _controller;
  ErrorHandler() {
    _controller = Get.find();
  }

  Future<ResponseModel> errorHandler({bool showError = true, required Future Function() function, bool isAuthService = false}) async {
    //!
    Tuple2<ErrorType, int?> res = await _errorHandler(
      showError: showError,
      function: () async => await function(),
      isAuthService: isAuthService,
    );

    //! -------------------------------------------------------------------------------------------- Refreshing token
    if (res.item1 == ErrorType.invalidUser) {
      if (showError) InvalidUser();
      _controller.forceLogout();
    }

    return ResponseModel(isSuccess: res.item1 == ErrorType.done, statusCode: res.item2 ?? -1);

    // !
    // await function();
    // return ResponseModel(isSuccess: true, statusCode: 200);
  }

  Future<Tuple2<ErrorType, int?>> _errorHandler({bool showError = true, required Function function, required bool isAuthService}) async {
    try {
      await function();
      return const Tuple2(ErrorType.done, null); // !  --------------------------------------------- Done
    } on SocketException {
      if (kDebugMode) print("ErrorHandler: SocketException");
      if (showError) InternetException();
      return const Tuple2(ErrorType.internetException, null); //! ---------------------------------- InternetException
    } on TimeoutException {
      if (kDebugMode) print("ErrorHandler: TimeoutException");
      if (showError) RequestTimeOut();
      return const Tuple2(ErrorType.requestTimeOut, null); //! ------------------------------------- RequestTimeOut
    } catch (e) {
      if (e is! http.Response) {
        if (kDebugMode) print("ErrorHandler: ${e.toString()}");
        if (showError) CustomException(e.toString().customCutString(replaceString: "..."));
        return const Tuple2(ErrorType.customException, null); //! ------------------------------------------- CustomException
      }
      if (e.statusCode == 401) {
        if (kDebugMode) print("ErrorHandler: InvalidUser");
        return Tuple2(ErrorType.invalidUser, e.statusCode); //! -------------------------------------- InvalidUser
      }

      if (kDebugMode) print("ErrorHandler: CustomException");

      String message = "";
      try {
        message = jsonDecode(e.body)['error'] ?? "";
      } catch (_) {}

      // if (message.isNotEmpty) message = "Error Message: $message";
      if (showError) CustomException(message.isEmpty ? "Unexpected error. Please contact the support team." : message, response: "Error code: ${e.statusCode}");
      return Tuple2(ErrorType.customException, e.statusCode); //! ---------------------------------------- CustomException
    }
  }
}

enum ErrorType {
  done,
  internetException,
  requestTimeOut,
  invalidUser,
  customException
}

class ResponseModel {
  final bool isSuccess;
  final int statusCode;

  ResponseModel({required this.isSuccess, this.statusCode = -1});
}
