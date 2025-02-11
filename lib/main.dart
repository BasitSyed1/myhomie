import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myhomie/Auth/signin.dart';
import 'package:myhomie/Auth/signup.dart';
import 'package:myhomie/provider/favoriteProvider.dart';
import 'package:myhomie/provider/searchFilterProvider.dart';
import 'package:myhomie/uipages/bottomNavBar.dart';
import 'package:myhomie/uipages/categoriesScreens/apartment_screen.dart';
import 'package:myhomie/uipages/categoriesScreens/propert_Screen.dart';
import 'package:myhomie/uipages/categoriesScreens/shop_Screen.dart';
import 'package:myhomie/uipages/home.dart';
import 'package:myhomie/utils/routes.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(
      MultiProvider(
        providers: [
       ChangeNotifierProvider<FavoriteProvider>(create: (context) => FavoriteProvider()),
          ChangeNotifierProvider<SearchFilterProvider>(create: (context) => SearchFilterProvider()),
        ],
        child: MyApp(),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyHomie',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Signin(),
        myRoutes.homeRoute : (context) => Home(),
        myRoutes.signInRoute : (context) => Signin(),
        myRoutes.signUpRoute : (context) => Signup(),
        myRoutes.navBarRoute : (context) => Bottomnavbar(),
        myRoutes.apartmentRoute : (context) => ApartmentScreen(),
        myRoutes.shopRoute : (context) => ShopScreen(),
        myRoutes.propertyRoute : (context) => PropertScreen(),
      },
    );

  }
}

