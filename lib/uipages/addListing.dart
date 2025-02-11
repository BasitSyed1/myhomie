import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:myhomie/Service/ListingService.dart';
import 'package:myhomie/dataModel/dataModel.dart';
import 'package:myhomie/widgets/headingtext.dart';
import 'package:random_string/random_string.dart';

class Addlisting extends StatefulWidget {
  const Addlisting({super.key});

  @override
  State<Addlisting> createState() => _AddlistingState();
}

class _AddlistingState extends State<Addlisting> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String? selectedValueOfBath = '1';
  String? selectedValueOfBed = '1';

  final ListingService _listingService = ListingService();

  List<String> bath = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];
  List<String> bed = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];
  List<String> type = ['Home', 'apartment', 'shop', 'property'];
  String? selectedCategory = 'Home';

  String folderName = randomAlphaNumeric(10);

  List<Asset> images = [];
  // Method to pick multiple images
  Future<void> loadAssets() async {
    List<Asset> resultList = [];
    try {
      // Define the selection limit settings (limit to 5 images)
      const SelectionSetting selectionSetting = SelectionSetting(
        min: 1,  // Minimum 1 image selection
        max: 5,  // Maximum 5 images selection
        unselectOnReachingMax: true, // Unselect image if max is reached
      );

      // Use MultiImagePicker to pick images
      resultList = await MultiImagePicker.pickImages(
        selectedAssets: images, // Preselect previously selected images
        iosOptions: const IOSOptions(
          // Add iOS-specific options
          settings: CupertinoSettings(
            selection: selectionSetting,
          ),
        ),
        androidOptions: const AndroidOptions(
          // Add Android-specific options
          actionBarTitle: "Select Images Up To ",
          allViewTitle: "All Photos",
          useDetailsView: false,
          maxImages: 5,  // Limit the number of images to 5
        ),
      );
    } catch (e) {
      print("Error picking images: $e");
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref('imageUrls');

  Future<List<String>> uploadImages(List<Asset> images) async {
    List<String> imageUrls = [];

    for (var asset in images) {
      final byteData = await asset.getByteData();
      final bytes = byteData.buffer.asUint8List();

      // Upload to Firebase Storage
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().microsecondsSinceEpoch}.jpg');
      UploadTask uploadTask = ref.putData(bytes);

      // Wait for upload completion and get the download URL
      final snapshot = await uploadTask.whenComplete(() => {});
      final url = await snapshot.ref.getDownloadURL();

      imageUrls.add(url); // Add the URL to the list
    }

    return imageUrls; // Return the list of URLs
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Listing'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    loadAssets();
                  },
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:  images.isNotEmpty ? GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Grid layout for images
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AssetThumb(asset: images[index], width: 300, height: 300,);
                      },) : Icon(Icons.camera_alt_outlined),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 13, right: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'title goes here',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 13, right: 5),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 13, right: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },
                    items: type.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: const TextStyle(color: Colors.blue)),
                      );
                    }).toList(),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.red),
                    dropdownColor: Colors.grey[200],
                    underline: const SizedBox(), // Removes the underline
                    hint: const Text("Type"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(Icons.bathtub_outlined),
                    DropdownButton<String>(
                      value: selectedValueOfBath,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValueOfBath = newValue!;
                        });
                      },
                      items: bath.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: const TextStyle(color: Colors.blue)),
                        );
                      }).toList(),
                      icon:
                          const Icon(Icons.arrow_drop_down, color: Colors.red),
                      dropdownColor: Colors.grey[200],
                      underline: const SizedBox(), // Removes the underline
                      hint: const Text("baths"),
                    ),
                    const Icon(Icons.bed),
                    DropdownButton<String>(
                      value: selectedValueOfBed,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValueOfBed = newValue!;
                        });
                      },
                      items: bed.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: const TextStyle(color: Colors.blue)),
                        );
                      }).toList(),
                      icon:
                          const Icon(Icons.arrow_drop_down, color: Colors.red),
                      dropdownColor: Colors.grey[200],
                      underline: const SizedBox(), // Removes the underline
                      hint: const Text("beds"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 13, right: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: locationController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'location',
                      suffixIcon: Icon(CupertinoIcons.location),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 13, right: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: priceController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Price',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 13, right: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                      onPressed: () async {
                        List<String> imgUrls = await uploadImages(images);
                        PropertyListing newListing = PropertyListing(
                          id: '',
                          title: titleController.text,
                          desc: descriptionController.text,
                          location: locationController.text,
                          price: priceController.text,
                          bedrooms: selectedValueOfBath.toString(),
                          bathrooms: selectedValueOfBed.toString(),
                          imageUrl: imgUrls,
                          interior: '',
                        );
                        await _listingService.uploadListingToDB(
                            newListing, selectedCategory!);
                      },
                      child: Headingtext(text: 'Upload')),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imagesWidget() {
    return GridView.builder(
        gridDelegate:
         const SliverGridDelegateWithFixedCrossAxisCount(  crossAxisCount: 3, // Grid layout for images
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
          return AssetThumb(asset: images[index], width: 300, height: 300);
    },);
  }
}
