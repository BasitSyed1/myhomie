import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService{


    final signOut = FirebaseAuth.instance.signOut();

}