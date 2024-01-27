import 'package:easy_do/src/controllers/services/user_message/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppExceptions {
  final String prefix;
  final String message;

  AppExceptions({this.prefix = "", this.message = ""}) {
    showSnackBar(
      title: prefix,
      message: message,
      icon: Icon(Icons.error, color: Get.theme.colorScheme.error),
    );
  }
}

//! InternetException
class InternetException extends AppExceptions {
  InternetException({String? message}) : super(prefix: "Error", message: "No Internet Connection. ${message ?? ""}");
}

//! RequestTimeOut
class RequestTimeOut extends AppExceptions {
  RequestTimeOut({String? message}) : super(prefix: "Error", message: "Request timeout. ${message ?? ""}");
}

//! InvalidUser
class InvalidUser extends AppExceptions {
  InvalidUser({String? message}) : super(prefix: "Error", message: "Invalid user. ${message ?? ""}");
}

//! CustomException
class CustomException extends AppExceptions {
  CustomException(String message, {String? response}) : super(prefix: "Error", message: "$message${response == null ? "" : "\n$response"}");
}
