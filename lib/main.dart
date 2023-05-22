import 'package:flutter/material.dart';

import 'package:invoice_bot/views/selectorPage.dart';
import 'package:invoice_bot/utils/theme.dart' as theme;
import 'package:oktoast/oktoast.dart';


void main() async {
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
        title: "Invoice Bot",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: theme.accentColor),
          useMaterial3: true,
        ),
        home: const SelectorPage(),
      ),
    );
  }
}
