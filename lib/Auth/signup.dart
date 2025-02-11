import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myhomie/Auth/signin.dart';
import 'package:myhomie/utils/routes.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController confpwController = TextEditingController();
  TextEditingController nameController = TextEditingController();


  DatabaseReference databaseReference = FirebaseDatabase.instance.ref('users');

  Future<void> registerUser(String email, String password, String confPassword,
      String name) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User Register Succesfully!'),
            duration: Duration(seconds: 2),
          ));

      User? user = userCredential.user;

      if (user != null) {
        //create a document for new user in firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name,
          'password': password,
          'email': email,
          'uid': user.uid,
          'createdAt': DateTime.now(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User Register Succesfully!'),
              duration: Duration(seconds: 2),
            ));
        }

        }catch(e)
        {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Something Went Wrong!', style: TextStyle(color: Colors.red),),
            duration: Duration(seconds: 5),

          ));
        }
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60,),
            Image.asset('assets/images/house.png',width: 45,height: 45, color: Colors.deepOrange,),
            Container(
              child: const Center(
                child: Text('My Hoomie', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700,fontStyle: FontStyle.italic, fontSize: 20)),
              ),
            ),
            const SizedBox(height: 50,),
            Container(
              height: 590,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF2F2F2),
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
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, myRoutes.navBarRoute);
                          },
                          child: const Text('Sign Up', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w800, fontSize: 22),)),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Your Name',
                          prefixIcon: Icon(Icons.person),
                          contentPadding: EdgeInsets.only(left: 5, top: 10, right: 3),
                        ),
            
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.mail_outline),
                        ),
            
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: pwController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.password),
                        ),
            
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: confpwController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                          prefixIcon: Icon(Icons.password),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.only(left: 13, right: 5),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextButton(onPressed: () {
                        String email = emailController.text;
                        String password = pwController.text;
                        String cmPassword = confpwController.text;
                        String name = nameController.text;
                        if (email.isNotEmpty && password.isNotEmpty &&
                            cmPassword.isNotEmpty && name.isNotEmpty) {
                          if (password == cmPassword) {
                            registerUser(email, password, cmPassword, name);
                            emailController.clear();
                            pwController.clear();
                            confpwController.clear();
                            nameController.clear();
                            Navigator.pushNamed(context, myRoutes.signInRoute);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Password Should be Same')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please Fill All Fields')));
                        }
                      },
                        child: const Text('Register', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 18)),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('Already have an account? ',
                            style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14)),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, myRoutes.signInRoute);
                            },
                            child: const Text('Login', style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 14))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
