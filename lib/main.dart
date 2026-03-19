import 'package:flutter/material.dart';
import 'package:primer_parcial/config/router/router.dart';
import 'package:primer_parcial/config/theme/app_theme.dart';

void main () {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectColor: 0).getThemeData(),
    );
  }
}