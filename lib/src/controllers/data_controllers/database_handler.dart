import 'package:easy_do/src/controllers/services/dev_functions/dev_print.dart';
import 'package:easy_do/src/models/pojo_classes/local_data_model.dart';
import 'package:get_storage/get_storage.dart';

class LocalDataHandler {
  LocalDataModel localDataModel = LocalDataModel();
  late final GetStorage _box;
  final String _localDataString = "data";

  initApp() async {
    await GetStorage.init();
    _box = GetStorage();
    var r = _box.read(_localDataString);
    try {
      if (r != null) localDataModel = LocalDataModel.fromJson(r);
    } catch (e) {
      _box.erase();
      devPrint("error: $e");
    }

    _print(localDataModel.toString());

    localDataModel.user.listen((_) {
      devPrint("UserData Data is Changed. Writing local data.");
      _print(localDataModel.user.value.toString());
      _box.write(_localDataString, localDataModel.toJson());
    });

    localDataModel.appSetting.listen((_) {
      devPrint("AppSetting Data is Changed. Writing local data.");
      _print(localDataModel.appSetting.value.toString());
      _box.write(_localDataString, localDataModel.toJson());
    });
  }
}

_print(String text) {
  devPrint("""
LocalDataHandler ------------------------------------------------------------
$text
----------------------------------------------------------------------------------------------------
""");
}
