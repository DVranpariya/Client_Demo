import 'package:get_storage/get_storage.dart';

class PrefManager {
  static GetStorage _getStorage = GetStorage();
  static Future<String> setName({String? name}) async {
    await _getStorage.write('name', name);
    return '';
  }

  static getName() {
    return _getStorage.read("name");
  }

  /// db mobile number
  static setMobileNumber({String? name}) async {
    await _getStorage.write('mobileNumber', name);
    return '';
  }

  static getMobileNumber() {
    return _getStorage.read("mobileNumber");
  }

  ///clear all pref
  static clearAllPrefDb() {
    return _getStorage.erase();
  }
}
