import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myhomie/Auth/signup.dart';
import 'package:myhomie/uipages/bottomNavBar.dart';
import 'package:myhomie/uipages/home.dart';
import 'package:myhomie/utils/routes.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();


  Future<void> signInUser() async {
    String email = emailController.text;
    String password = pwController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        // Check if authenticated
        if (userCredential.user != null) {
          Navigator.pushReplacementNamed(context, myRoutes.navBarRoute);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Welcome!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please verify your email to proceed.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong: ${e.toString()}')));
      }
    } else {
      // Show message if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in email and password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Image.asset(
                'assets/images/house.png',
                width: 45,
                height: 45,
                color: Colors.deepOrange,
              ),
              Container(
                child: const Center(
                  child: Text('My Hoomie',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          fontSize: 20)),
                ),
              ),
              SizedBox(height: 50),
              // Expanded is not needed here, because we are using SingleChildScrollView
              Container(
                height: 590, // Set a specific height or leave it open to take all space
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0XFFF2F2F2),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, myRoutes.navBarRoute);
                          },
                          child: Text('Login',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 22)),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Your Email',
                            prefixIcon: Icon(Icons.email_outlined),
                            contentPadding: EdgeInsets.only(
                                left: 5, top: 14, right: 3),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: pwController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Your Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            contentPadding: EdgeInsets.only(
                                left: 5, top: 14, right: 3),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.only(left: 13, right: 5),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: GestureDetector(
                            onTap: () {
                              signInUser();
                            },
                            child: Text('Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Forgot Password?',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 14)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Don\'t have an account? ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14)),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, myRoutes.signUpRoute);
                            },
                            child: Text('SignUp',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
