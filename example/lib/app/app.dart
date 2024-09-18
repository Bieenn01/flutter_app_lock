import 'package:flutter/material.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:flutter_app_lock_example/screens/home.dart';
import 'package:flutter_app_lock_example/screens/list_applications.dart';
import 'package:flutter_app_lock_example/services/themes.dart';
import '../screens/lock_screen.dart';
import '../screens/my_home_page.dart';


class MyApp extends StatelessWidget {
  final bool enabled;
  @visibleForTesting
  final Duration backgroundLockLatency;

  const MyApp({
    super.key,
    this.enabled = false,
    required this.backgroundLockLatency, required GlobalKey<NavigatorState> navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.dark,
      builder: (context, child) => AppLock(
        builder: (context, arg) => child!,
        lockScreenBuilder: (context) => const LockScreen(
          key: Key('LockScreen'),
        ),
        enabled: enabled,
        backgroundLockLatency: backgroundLockLatency,
        inactiveBuilder: (context) => const Scaffold(
          key: Key('InactiveScreen'),
          body: Center(
            child: FlutterLogo(size: 80),
          ),
        ),
      ),
      home: HomePage(),
      // home: const MyHomePage(
      //   key: Key('MyHomePage'),
      //   title: 'Flutter Demo Home Page',
      // ),
      // routes: {
      //   '/settings': (context) => AppLockSettingsPage(),
      // },
    );
  }
}
