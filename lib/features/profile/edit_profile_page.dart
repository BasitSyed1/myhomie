import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  File? _image;
  final ImagePicker _imagePicker = ImagePicker();
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emailController.text = user.email ?? '';
      _fetchUser();
    }
  }

  Future<void> _uploadImageToFirebaseStorage(File image) async {
    try {
      final fileName =
          'profilepicture/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final ref = FirebaseStorage.instance.ref().child(fileName);

      final uploadTask = ref.putFile(image);
      await uploadTask.whenComplete(() async {
        final downloadUrl = await ref.getDownloadURL();
        if (!mounted) return;
        setState(() {
          imageUrl = downloadUrl;
        });
        await _updateUser(downloadUrl);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _fetchUser() async {
    final user = FirebaseAuth.instance.currentUser;
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    if (userDoc.exists && mounted) {
      final name = userDoc['name'] ?? 'no name';
      setState(() {
        nameController.text = name;
      });
    }
  }

  Future<void> _pickImage() async {
    final image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    } else {
      debugPrint('No image selected');
    }
  }

  Future<void> _updateUser(String downloadUrl) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await user.updateDisplayName(nameController.text);
    await user.updatePhotoURL(downloadUrl);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({
      'name': nameController.text,
      'photoUrl': downloadUrl,
      'email': emailController.text,
    });

    await user.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Edit User Profile')),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: _image == null
                          ? const Icon(Icons.person, size: 35)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),
                            ),
                    ),
                    const Positioned(
                      right: 2,
                      top: 2,
                      child: Icon(Icons.edit, size: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildField(controller: nameController, hint: 'name'),
              const SizedBox(height: 15),
              _buildField(controller: emailController, hint: 'email'),
              const SizedBox(height: 15),
              _buildField(
                  controller: phoneNumberController, hint: 'phone number'),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.deepOrange,
                ),
                child: TextButton(
                  onPressed: () {
                    if (_image != null) {
                      _uploadImageToFirebaseStorage(_image!);
                    } else {
                      debugPrint('No image selected');
                    }
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFF5F4F9),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
      ),
    );
  }
}
