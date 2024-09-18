import 'package:flutter_app_lock_example/executable/controllers/apps_controller.dart';
import 'package:flutter_app_lock_example/executable/controllers/home_screen_controller.dart';
import 'package:flutter_app_lock_example/executable/controllers/method_channel_control.dart';
import 'package:flutter_app_lock_example/executable/controllers/password_controller.dart';
import 'package:flutter_app_lock_example/executable/controllers/permission_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initialize() async {
  final prefs = await SharedPreferences.getInstance();
  Get.lazyPut(() => prefs);
  Get.lazyPut(() => AppsController(prefs: Get.find()));
  Get.lazyPut(() => HomeScreenController(prefs: Get.find()));
  Get.lazyPut(() => MethodChannelController());
  Get.lazyPut(() => PermissionController());
  Get.lazyPut(() => PasswordController(prefs: Get.find()));
}
