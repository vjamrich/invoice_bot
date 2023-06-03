import 'package:flutter/material.dart';

import 'package:oktoast/oktoast.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:vat_appeal_bot/views/selectorPage.dart';
import 'package:vat_appeal_bot/utils/theme.dart' as theme;


void main() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      backgroundColor: Colors.black87,
      duration: const Duration(seconds: 3),
      radius: theme.borderRadius.bottomLeft.x,
      position: ToastPosition.bottom,
      textPadding: const EdgeInsets.all(16.0),
      textStyle: const TextStyle(
        color: theme.textPrimaryColor,
        fontSize: 16.0,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "VAT Appeal Bot",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: theme.accentColor),
          useMaterial3: true,
        ),
        home: const SelectorPage(),
      ),
    );
  }
}
