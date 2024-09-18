// import 'package:flutter/material.dart';
// import 'package:device_apps/device_apps.dart';
// import 'package:flutter/services.dart';

// class AppLockSettingsPage extends StatefulWidget {
//   @override
//   _AppLockSettingsPageState createState() => _AppLockSettingsPageState();
// }

// class _AppLockSettingsPageState extends State<AppLockSettingsPage> {
//   static const platform = MethodChannel(
//       'flutter.native/helper'); // Match this channel name with the native side
//   List<AppInfo> _apps = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadInstalledApps();
//   }

//   Future<void> _loadInstalledApps() async {
//     try {
//       List<Application> apps = await DeviceApps.getInstalledApplications(
//         includeAppIcons: true,
//         includeSystemApps: false, // or true if you need system apps
        
//       );

//       setState(() {
//         _apps = apps
//             .map((app) => AppInfo(
//                   app.packageName,
//                   app.appName,
//                   isLocked: false, // Initialize lock status if needed
//                 ))
//             .toList();
//       });
//     } on PlatformException catch (e) {
//       print("Failed to load installed apps: '${e.message}'.");
//     }
//   }

//   Future<void> _toggleAppLock(String packageName, bool enable) async {
//     try {
//       if (enable) {
//         await platform.invokeMethod('lockApp', {'packageName': packageName});
//       } else {
//         await platform.invokeMethod('unlockApp', {'packageName': packageName});
//       }
//     } on PlatformException catch (e) {
//       print("Failed to toggle app lock: '${e.message}'");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('App Lock Settings'),
//       ),
//       body: ListView.builder(
//         itemCount: _apps.length,
//         itemBuilder: (context, index) {
//           final app = _apps[index];
//           return ListTile(
//             leading: app.icon != null ? Image.memory(app.icon!) : null,
//             title: Text(app.name),
//             trailing: Switch(
//               value: app.isLocked,
//               onChanged: (value) {
//                 setState(() {
//                   app.isLocked = value;
//                 });
//                 _toggleAppLock(app.packageName, value);
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class AppInfo {
//   final String packageName;
//   final String name;
//   final Uint8List? icon;
//   bool isLocked;

//   AppInfo(this.packageName, this.name, {this.icon, this.isLocked = false});
// }
