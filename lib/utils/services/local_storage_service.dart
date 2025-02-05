import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService extends GetxService {
  LocalStorageService._();
  static final box = Hive.box("venturo");

  /// Kode untuk setting localstorage sesuai dengan repository
  // static Future<void> setAuth(Data serverSelected) async {
  //   await box.put("id", serverSelected.user!.id);
  //   await box.put("name", serverSelected.user!.nama);
  //   await box.put("photo", serverSelected.user!.humanisFoto);
  //   await box.put("roles", serverSelected.user!.jabatan);
  //   await box.put("isLogin", true);

  //   /// Log id user
  //   await FirebaseAnalytics.instance.setUserId(
  //     id: serverSelected.user!.id.toString(),
  //   );
  // }

  static Future deleteAuth() async {
    if (box.get("isRememberMe") == false) {
      box.clear();
      box.put("isLogin", false);
    } else {
      box.put("isLogin", false);
    }
  }
}