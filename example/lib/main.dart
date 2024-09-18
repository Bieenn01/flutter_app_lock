import 'package:flutter/material.dart';
import 'package:flutter_app_lock_example/services/init.dart';

import 'app/app.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main({
  bool enabled = true,
  @visibleForTesting
  Duration backgroundLockLatency = const Duration(seconds: 30),
}) async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure the Flutter engine is initialized
        await initialize();

  runApp(MyApp(
    navigatorKey: navigatorKey,
    enabled: enabled,
    backgroundLockLatency: backgroundLockLatency,
  ));
}
