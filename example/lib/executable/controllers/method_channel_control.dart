import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_app_lock_example/executable/controllers/apps_controller.dart';
import 'package:flutter_app_lock_example/services/constant.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usage_stats/usage_stats.dart';


class MethodChannelController extends GetxController implements GetxService {
  static const platform = MethodChannel('flutter.native/helper');

  bool isOverlayPermissionGiven = false;
  bool isUsageStatPermissionGiven = false;
  bool isNotificationPermissionGiven = false;

  Future<bool> checkOverlayPermission() async {
    try {
      final bool permissionGiven =
          await platform.invokeMethod('checkOverlayPermission');
      log("Overlay permission: $permissionGiven",
          name: "checkOverlayPermission");
      isOverlayPermissionGiven = permissionGiven;
      update();
      return isOverlayPermissionGiven;
    } on PlatformException catch (e) {
      log("Failed to Invoke: '${e.message}'", name: "checkOverlayPermission");
      isOverlayPermissionGiven = false;
      update();
      return isOverlayPermissionGiven;
    }
  }

  Future<bool> checkNotificationPermission() async {
    isNotificationPermissionGiven = await Permission.notification.isGranted;
    return isNotificationPermissionGiven;
  }

    Future<bool> checkUsageStatePermission() async {
    isUsageStatPermissionGiven =
        (await UsageStats.checkUsagePermission() ?? false);
    update();
    return isUsageStatPermissionGiven;
  }



  Future<void> addToLockedAppsMethod() async {
    try {
      final appsController = Get.find<AppsController>();
      final appList = appsController.lockList.map((e) {
        return {
          "app_name": e.application!.appName,
          "package_name": e.application!.packageName,
          "file_path": e.application!.apkFilePath,
        };
      }).toList();

      await setPassword();
      await platform
          .invokeMethod('addToLockedApps', {'app_list': appList}).then((value) {
        log("addToLockedApps response: $value", name: "addToLockedApps");
      });
    } on PlatformException catch (e) {
      log("Failed to Invoke: '${e.message}'", name: "addToLockedApps");
    }
  }

  Future<void> setPassword() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final String data = prefs.getString(AppConstants.setPassCode) ?? "";
      log("Password: $data", name: "setPassword");
      if (data.isNotEmpty) {
        await platform.invokeMethod('setPasswordInNative', data).then((value) {
          log("setPasswordInNative response: $value",
              name: "setPasswordInNative");
        });
      }
    } on PlatformException catch (e) {
      log("Failed to Invoke: '${e.message}'", name: "setPasswordInNative");
    }
  }

  Future<void> stopForeground() async {
    try {
      await platform.invokeMethod('stopForeground').then((value) {
        log("stopForeground response: $value", name: "stopForeground");
      });
    } on PlatformException catch (e) {
      log("Failed to Invoke: '${e.message}'", name: "stopForeground");
    }
  }

  Future<bool> askNotificationPermission() async {
    await Permission.notification.request();
    isNotificationPermissionGiven = await Permission.notification.isGranted;
    update();
    return isNotificationPermissionGiven;
  }

  Future<bool> askOverlayPermission() async {
    try {
      final bool permissionGiven =
          await platform.invokeMethod('askOverlayPermission');
      log("askOverlayPermission response: $permissionGiven",
          name: "askOverlayPermission");
      isOverlayPermissionGiven = permissionGiven;
      update();
      return isOverlayPermissionGiven;
    } on PlatformException catch (e) {
      log("Failed to Invoke: '${e.message}'", name: "askOverlayPermission");
      return false;
    }
  }

  Future<bool> askUsageStatsPermission() async {
    try {
      final bool permissionGiven =
          await platform.invokeMethod('askUsageStatsPermission');
      log("askUsageStatsPermission response: $permissionGiven",
          name: "askUsageStatsPermission");
      return permissionGiven;
    } on PlatformException catch (e) {
      log("Failed to Invoke: '${e.message}'", name: "askUsageStatsPermission");
      return false;
    }
  }


}
