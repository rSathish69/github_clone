import 'package:shared_preferences/shared_preferences.dart';

class Sharedpref {
  static SharedPreferences? _pref;

  static initilize() async {
    if (_pref != null) {
      return _pref;
    } else {
      return _pref = await SharedPreferences.getInstance();
    }
  }


  static Future<void> saveUserName(String userName) async {
    await _pref!.setString("userName", userName);
  }

  static Future<void> saveAccessToken(String accessToken) async {
    await _pref!.setString("accessToken", accessToken);
  }

  static Future<void> saveOrgListUrl(String orgListUrl) async {
    await _pref!.setString("orgListUrl", orgListUrl);
  }

  static String get getUserName => _pref!.getString("userName") ?? "";
  static String get getAccessToken => _pref!.getString("accessToken")??"";
  static String get getOrgListUrl => _pref!.getString("orgListUrl") ?? "";
}
