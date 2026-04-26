import 'package:flutter/material.dart';
import 'package:my_homie/app/routes/app_routes.dart';
import 'package:my_homie/app/theme/app_theme.dart';

class MyHomieApp extends StatelessWidget {
  const MyHomieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyHomie',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}
