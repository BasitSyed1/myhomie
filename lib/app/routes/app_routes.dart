import 'package:flutter/material.dart';
import 'package:my_homie/features/auth/signin_page.dart';
import 'package:my_homie/features/auth/signup_page.dart';
import 'package:my_homie/features/home/bottom_nav_bar.dart';
import 'package:my_homie/features/home/home_page.dart';
import 'package:my_homie/features/listings/categories/apartment_screen.dart';
import 'package:my_homie/features/listings/categories/house_screen.dart';
import 'package:my_homie/features/listings/categories/property_screen.dart';
import 'package:my_homie/features/listings/categories/shop_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String home = '/home';
  static const String navBar = '/bottom-nav';
  static const String house = '/house';
  static const String apartment = '/apartment';
  static const String shop = '/shop';
  static const String property = '/property';

  static Map<String, WidgetBuilder> get routes => {
        '/': (_) => const SigninPage(),
        signIn: (_) => const SigninPage(),
        signUp: (_) => const SignupPage(),
        home: (_) => const HomePage(),
        navBar: (_) => const BottomNavBar(),
        house: (_) => const HouseScreen(),
        apartment: (_) => const ApartmentScreen(),
        shop: (_) => const ShopScreen(),
        property: (_) => const PropertyScreen(),
      };
}
