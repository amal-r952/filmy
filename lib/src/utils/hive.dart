import 'package:hive/hive.dart';
import 'constants.dart';

class AppHive {
  static const String _TOKEN = "token";

  void hivePut({String? key, String? value}) async {
    await Hive.box(Constants.BOX_NAME).put(key, value);
  }

  String hiveGet({String? key}) {
    // openBox();
    return Hive.box(Constants.BOX_NAME).get(key);
  }

  putToken({String? token}) {
    hivePut(key: _TOKEN, value: token);
  }

  String getToken() {
    return hiveGet(key: _TOKEN);
  }

  AppHive();
}
