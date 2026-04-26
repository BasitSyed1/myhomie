import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_homie/app/app.dart';
import 'package:my_homie/data/providers/favorite_provider.dart';
import 'package:my_homie/data/providers/search_filter_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    debugPrint('Firebase initialized successfully');
  } catch (e) {
    debugPrint('Error initializing Firebase: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FavoriteProvider>(
          create: (_) => FavoriteProvider(),
        ),
        ChangeNotifierProvider<SearchFilterProvider>(
          create: (_) => SearchFilterProvider(),
        ),
      ],
      child: const MyHomieApp(),
    ),
  );
}
