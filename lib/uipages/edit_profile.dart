import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emailController.text = user.email ?? '';
      fetchuser();
    }
  }

  File? _image;
  final ImagePicker _imagePicker = ImagePicker();
  String imageUrl = '';

  Future<void> uploadImageToFirebaseStorage(File image) async {
    try {
      String fineName =
          'profilepicture/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference ref = FirebaseStorage.instance.ref().child(fineName);

      UploadTask uploadTask = ref.putFile(image);
      await uploadTask.whenComplete(() async {
        String downloadUrl = await ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
        await updateUser(downloadUrl);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchuser() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    if (userDoc.exists) {
      String name = userDoc['name'] ?? 'no name';
      setState(() {
        nameController.text = name;
      });
    }
  }

  Future<void> _pickImage() async {
    //pick an image from the gallery
    final XFile? image =
    await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    } else {
      print("No image selected");
    }
  }

  Future<void> updateUser(String downloadUrl) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Update the user's profile in Firebase Authentication
      await user.updateProfile(
        displayName: nameController.text,
        photoURL: downloadUrl,
      );

      // Update the user's document in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'name': nameController.text,
        'photoUrl': downloadUrl,
        'email': emailController.text
      });

      print('SUCCESS!');
      // Reload the user to ensure the profile is updated
      await user.reload();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Edit User Profile'),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _pickImage();
                },
                child: Stack(children: [
                  CircleAvatar(
                    radius: 30,
                    child: _image == null
                        ? Icon(
                      Icons.person,
                      size: 35,
                    )
                        : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        )),
                  ),
                  const Positioned(
                      right: 2,
                      top: 2,
                      child: Icon(
                        Icons.edit,
                        size: 20,
                      )),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFF5F4F9),
                ),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'name',
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFF5F4F9),
                ),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'email',
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFF5F4F9),
                ),
                child: TextField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'phone number',
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.deepOrange,
                ),
                child: TextButton(
                    onPressed: () {
                      if (_image != null) {
                        uploadImageToFirebaseStorage(_image!); // Upload the image
                      } else {
                        print("No image selected");
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
