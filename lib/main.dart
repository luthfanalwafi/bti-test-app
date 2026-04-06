import 'dart:async';

import 'package:bti_test_app/pages/empty/empty_page.dart';
import 'package:bti_test_app/pages/login/index.dart';
import 'package:bti_test_app/provider/news_provider.dart';
import 'package:bti_test_app/provider/user_provider.dart';
import 'package:bti_test_app/services/sqflite/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bti_test_app/router/router.dart' as router_gen;
import 'package:provider/provider.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      SQFLiteService();
      await Firebase.initializeApp();
      runApp(MainApp());
    },
    (error, stackTrace) async {
      // Send error to FirebaseCrashlytics
    },
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router_gen.Router.generateRoute,
        title: 'BTI Test App',
        onUnknownRoute: (settings) => MaterialPageRoute(
          settings: settings,
          builder: (context) => EmptyPage(),
        ),
        home: LoginPage(),
      ),
    );
  }
}
