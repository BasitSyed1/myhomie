import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myhomie/uipages/favorite.dart';
import 'package:myhomie/uipages/home.dart';
import 'package:myhomie/uipages/profile.dart';
import 'package:myhomie/uipages/addListing.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class Bottomnavbar extends StatefulWidget {
  const Bottomnavbar({super.key});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int _currentIndex = 0;

  late List<Widget> _Screens;
  late Widget currentPage;
  late Home home;
  late FavoritePage favorite;
  late Profile profile;
  late Addlisting addlisting;

  @override
  void initState() {
    home = const Home();
    favorite = const FavoritePage();
    addlisting = const Addlisting();
    profile = const Profile();
    _Screens = [home, favorite, addlisting, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Screens[_currentIndex],
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
            icon: Icon(Icons.home_filled),
            title: Text('Home'),
            selectedColor: Colors.deepOrange,
          ),
          BottomBarItem(
            icon: Icon(Icons.favorite),
            title: Text("favorite"),
            selectedColor: Colors.deepOrange,
          ),
          BottomBarItem(
            icon: Icon(Icons.add),
            title: Text('Add Yours'),
            selectedColor: Colors.deepOrange,
          ),
          BottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: Colors.deepOrange,
          ),
        ],
      ),
    );
  }
}
