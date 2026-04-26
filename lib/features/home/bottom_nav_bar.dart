import 'package:flutter/material.dart';
import 'package:my_homie/features/favorites/favorites_page.dart';
import 'package:my_homie/features/home/home_page.dart';
import 'package:my_homie/features/listings/add_listing_page.dart';
import 'package:my_homie/features/profile/profile_page.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  static const List<Widget> _screens = <Widget>[
    HomePage(),
    FavoritesPage(),
    AddListingPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: StylishBottomBar(
        option: BubbleBarOptions(
          barStyle: BubbleBarStyle.horizontal,
          bubbleFillStyle: BubbleFillStyle.fill,
          borderRadius: BorderRadius.circular(50),
          opacity: 0.3,
        ),
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomBarItem(
            icon: const Icon(Icons.home_filled),
            title: const Text('Home'),
            selectedColor: Colors.deepOrange,
          ),
          BottomBarItem(
            icon: const Icon(Icons.favorite),
            title: const Text('Favorite'),
            selectedColor: Colors.deepOrange,
          ),
          BottomBarItem(
            icon: const Icon(Icons.add),
            title: const Text('Add Yours'),
            selectedColor: Colors.deepOrange,
          ),
          BottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
            selectedColor: Colors.deepOrange,
          ),
        ],
      ),
    );
  }
}
