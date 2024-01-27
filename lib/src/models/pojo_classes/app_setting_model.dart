import 'dart:convert';

//! ------------------------------------------------------------------------------------------------ B3
class AppSettingModel {
  final bool? isDarkMode;

  AppSettingModel({this.isDarkMode});

  AppSettingModel copyWith({
    bool? isDarkMode,
  }) {
    return AppSettingModel(
      isDarkMode: isDarkMode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isDarkMode': isDarkMode,
    };
  }

  factory AppSettingModel.fromMap(Map<String, dynamic> map) {
    return AppSettingModel(
      isDarkMode: map['isDarkMode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppSettingModel.fromJson(String source) => AppSettingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => '''AppSettingModel(isDarkMode: $isDarkMode)''';

  @override
  bool operator ==(covariant AppSettingModel other) {
    if (identical(this, other)) return true;

    return other.isDarkMode == isDarkMode;
  }

  @override
  int get hashCode => isDarkMode.hashCode;
}
