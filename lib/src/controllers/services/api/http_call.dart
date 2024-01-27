import 'dart:convert';
import 'dart:io';

import 'package:easy_do/components.dart';
import 'package:easy_do/src/controllers/data_controllers/data_controller.dart';
import 'package:easy_do/src/controllers/services/dev_functions/dev_print.dart';
import 'package:easy_do/src/controllers/services/user_message/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HttpCall {
  final DataController _controller = Get.find();

  String _cookie = "";
  final Map<String, String> _header = {
    "Content-Type": "application/json",
    // "Accept": "application/json",
    "Accept": "/",
  };

  Future<http.Response> __catchCookie(Function function) async {
    http.Response res = await function();
    if (res.headers['set-cookie'] != null) _cookie = res.headers['set-cookie']!.split(';')[0].trim();
    return res;
  }

  String get _getToken => "Bearer ${_controller.localData.localDataModel.user.value.token}";

  // Map<String, String>  _getHeader() {

  // }

  //! Get
  Future<http.Response> get(String url, {bool isAuthServer = false, String? token, Map<String, String>? headerParameter, Map<String, String>? additionalHeaderParameter, bool addCookie = false, String? customBaseLink}) async {
    if (kDebugMode) showToast(title: null, message: url);

    final Map<String, String> header = {};

    header.addAll(headerParameter ?? _header); // adding head

    if (additionalHeaderParameter != null) header.addAll(additionalHeaderParameter);

    if ((token) != null || _getToken.isNotEmpty) {
      header.addAll({
        HttpHeaders.authorizationHeader: token ?? _getToken // adding token
      });
    }

    if (addCookie) {
      header.addAll({
        'Cookie': _cookie // adding cookie
      });
    }

    String sendLink = (customBaseLink ?? (isAuthServer ? baseLinkAuth : baseLink)) + url;
    devPrint("HttpCall: Requesting: Get------------------------------------------------------------- $sendLink");
    http.Response res = await __catchCookie(() async => await http.get(Uri.parse(sendLink), headers: header).timeout(apiCallTimeOut));
    devPrint("HttpCall: Response: GET ------------------------------------------------------------ $sendLink --- Status Code: ${res.statusCode} --- Data: ${res.body}");

    return res;
  }

  Future<http.Response> post(String url, {bool isAuthServer = false, String? token, Map<String, String>? headerParameter, Map<String, String>? additionalHeaderParameter, bool addCookie = false, Object? body, String? customBaseLink, bool doEncode = true}) async {
    if (kDebugMode) showToast(title: null, message: url);

    final Map<String, String> header = {};

    header.addAll(headerParameter ?? _header); // adding head

    if (additionalHeaderParameter != null) header.addAll(additionalHeaderParameter);

    if ((token) != null || _getToken.isNotEmpty) {
      header.addAll({
        HttpHeaders.authorizationHeader: token ?? _getToken // adding token
      });
    }

    if (addCookie) {
      header.addAll({
        'Cookie': _cookie // adding cookie
      });
    }

    String sendLink = (customBaseLink ?? (isAuthServer ? baseLinkAuth : baseLink)) + url;
    devPrint("HttpCall: Requesting: POST ------------------------------------------------------------ $sendLink Body: ${jsonEncode(body)}");
    http.Response res = await __catchCookie(() async => await http.post(Uri.parse(sendLink), headers: doEncode ? header : null, body: doEncode ? jsonEncode(body) : body).timeout(apiCallTimeOut));
    devPrint("HttpCall: Response: POST ------------------------------------------------------------ $sendLink --- Status Code: ${res.statusCode} --- Data: ${res.body}");

    return res;
  }
}
