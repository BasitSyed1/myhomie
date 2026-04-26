import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_homie/app/routes/app_routes.dart';
import 'package:my_homie/features/profile/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String email = '';
  String name = '';
  String profileUrl = '';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final userEmail = user.email ?? '';
    if (mounted) {
      setState(() {
        email = userEmail;
      });
    }

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!mounted) return;

    if (userDoc.exists) {
      final userName = userDoc['name'] ?? 'no name';
      final imageUrl = userDoc['photoUrl'] ?? '';
      setState(() {
        name = userName;
        profileUrl = imageUrl;
      });
    } else {
      setState(() {
        email = 'No Name';
        name = 'no Name';
        profileUrl = 'no profile';
      });
    }
  }

  Future<void> _userSignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.signIn);
    } catch (e) {
      debugPrint('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Profile')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        child: profileUrl.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  profileUrl,
                                  fit: BoxFit.cover,
                                  width: 50,
                                  height: 50,
                                ),
                              )
                            : const Icon(Icons.person),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name),
                          Text(email),
                        ],
                      ),
                    ],
                  ),
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
                            builder: (context) => const EditProfilePage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: 500,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.only(left: 13, right: 5),
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
                            leading: Icon(Icons.phone, color: Colors.black),
                            title: Text(
                              'Phone Number',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          ),
                          const ListTile(
                            leading:
                                Icon(Icons.settings, color: Colors.black),
                            title: Text(
                              'Setting',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          ),
                          const ListTile(
                            leading:
                                Icon(Icons.policy, color: Colors.black),
                            title: Text(
                              'Privacy Policy',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 14),
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 18.0),
                            child: Divider(
                              height: 10,
                              color: Colors.grey,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _userSignOut();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Sign Out...')),
                              );
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
