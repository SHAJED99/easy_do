import 'dart:convert';
import 'package:easy_do/src/models/response_models/user_response_model.dart';
import 'package:get/get.dart';
import 'package:easy_do/src/models/pojo_classes/app_setting_model.dart';

class LocalDataModel {
  final Rx<UserResponseModel> user;
  final Rx<AppSettingModel> appSetting;
  LocalDataModel({
    UserResponseModel? user,
    AppSettingModel? appSetting,
  })  : user = Rx(user ?? UserResponseModel()),
        appSetting = Rx(appSetting ?? AppSettingModel());

  LocalDataModel copyWith({
    UserResponseModel? user,
    AppSettingModel? appSetting,
  }) {
    return LocalDataModel(
      user: user ?? this.user.value,
      appSetting: appSetting ?? this.appSetting.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.value.toMap(),
      'appSetting': appSetting.value.toMap(),
    };
  }

  factory LocalDataModel.fromMap(Map<String, dynamic> map) {
    return LocalDataModel(
      user: UserResponseModel.fromMap(map['user'] as Map<String, dynamic>),
      appSetting: AppSettingModel.fromMap(map['appSetting'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalDataModel.fromJson(String source) => LocalDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => '''
LocalDataModel(
  user: ${user.value.toString()},
  appSetting: ${appSetting.value.toString()}
)
''';

  @override
  bool operator ==(covariant LocalDataModel other) {
    if (identical(this, other)) return true;

    return other.user == user && other.appSetting == appSetting;
  }

  @override
  int get hashCode => user.hashCode ^ appSetting.hashCode;
}
