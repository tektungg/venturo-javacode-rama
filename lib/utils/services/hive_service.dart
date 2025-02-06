import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Box box = Hive.box('venturo');

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('venturo');
  }
}
