import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myhomie/Service/auth_Service.dart';
import 'package:myhomie/uipages/edit_profile.dart';
import 'package:myhomie/utils/routes.dart';
import 'package:myhomie/widgets/headingtext.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String Email = '';
  String Name = '';
  String profileUrl = '';

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      //user logeIn now fetch the data
      String email = user.email ?? '';
      setState(() {
        Email = email;
      });

      //Fetch User Details From FirebaseFireStore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        String name = userDoc['name'] ?? 'no name';
        String imageUrl = userDoc['photoUrl'] ?? ' ';
        setState(() {
          Name = name;
          Name = name;
          profileUrl = imageUrl;
          profileUrl = imageUrl;
        });
      } else {
        setState(() {
          Email = 'No Name';
          Name = 'no Name';
          profileUrl = 'no profile';
        });
      }
    }
  }

  Future<void> userSignOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context,
          myRoutes.signInRoute); // Navigate to the login screen after signout
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Profile'),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Row(children: [
                   CircleAvatar(
                     radius: 25,
                     child: profileUrl != null ? ClipRRect(
                         borderRadius: BorderRadius.circular(50),
                         child: Image.network(
                           profileUrl,
                           fit: BoxFit.cover,
                           width: 50,
                           height: 50,
                         )): Icon(Icons.person),
                   ),
                   SizedBox(
                     width: 10,
                   ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(Name),
                       Text(Email),
                     ],
                   ),
                 ],),
                  Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile()));
                        },
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 13, right: 5),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Phone Number',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                          const ListTile(
                            leading: Icon(
                              Icons.settings,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Setting',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                          const ListTile(
                            leading: Icon(
                              Icons.policy,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Privacy Policy',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0),
                            child: Divider(
                              height: 10,
                              color: Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              userSignOut(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Sign Out...')));
                            },
                            child: const ListTile(
                              leading: Icon(
                                Icons.keyboard_arrow_left,
                                color: Colors.redAccent,
                              ),
                              title: Text(
                                'Sign Out',
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
