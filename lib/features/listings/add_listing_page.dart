import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:my_homie/data/models/property_listing.dart';
import 'package:my_homie/data/services/listing_service.dart';
import 'package:my_homie/shared/widgets/heading_text.dart';

class AddListingPage extends StatefulWidget {
  const AddListingPage({super.key});

  @override
  State<AddListingPage> createState() => _AddListingPageState();
}

class _AddListingPageState extends State<AddListingPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String? selectedValueOfBath = '1';
  String? selectedValueOfBed = '1';

  final ListingService _listingService = ListingService();

  final List<String> bath = ['1', '2', '3', '4', '5', '6', '7', '8'];
  final List<String> bed = ['1', '2', '3', '4', '5', '6', '7', '8'];
  final List<String> type = ['Home', 'apartment', 'shop', 'property'];
  String? selectedCategory = 'Home';

  List<Asset> images = [];

  Future<void> loadAssets() async {
    List<Asset> resultList = [];
    try {
      const SelectionSetting selectionSetting = SelectionSetting(
        min: 1,
        max: 5,
        unselectOnReachingMax: true,
      );

      resultList = await MultiImagePicker.pickImages(
        selectedAssets: images,
        iosOptions: const IOSOptions(
          settings: CupertinoSettings(selection: selectionSetting),
        ),
        androidOptions: const AndroidOptions(
          actionBarTitle: 'Select Images Up To ',
          allViewTitle: 'All Photos',
          useDetailsView: false,
          maxImages: 5,
        ),
      );
    } catch (e) {
      debugPrint('Error picking images: $e');
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  Future<List<String>> uploadImages(List<Asset> images) async {
    final List<String> imageUrls = [];

    for (var asset in images) {
      final byteData = await asset.getByteData();
      final bytes = byteData.buffer.asUint8List();

      final ref = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().microsecondsSinceEpoch}.jpg');
      final uploadTask = ref.putData(bytes);

      final snapshot = await uploadTask.whenComplete(() => {});
      final url = await snapshot.ref.getDownloadURL();

      imageUrls.add(url);
    }

    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a Listing')),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10.0, left: 20, right: 20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: loadAssets,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: images.isNotEmpty
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4,
                            ),
                            itemCount: images.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AssetThumb(
                                asset: images[index],
                                width: 300,
                                height: 300,
                              );
                            },
                          )
                        : const Icon(Icons.camera_alt_outlined),
                  ),
                ),
                const SizedBox(height: 10),
                _buildField(
                    controller: titleController, hint: 'title goes here'),
                const SizedBox(height: 10),
                _buildField(
                  controller: descriptionController,
                  hint: 'Description',
                  height: 200,
                ),
                const SizedBox(height: 10),
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
                    items:
                        type.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: const TextStyle(color: Colors.blue)),
                      );
                    }).toList(),
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.red),
                    dropdownColor: Colors.grey[200],
                    underline: const SizedBox(),
                    hint: const Text('Type'),
                  ),
                ),
                const SizedBox(height: 10),
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
                      items: bath
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: const TextStyle(color: Colors.blue)),
                        );
                      }).toList(),
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.red),
                      dropdownColor: Colors.grey[200],
                      underline: const SizedBox(),
                      hint: const Text('baths'),
                    ),
                    const Icon(Icons.bed),
                    DropdownButton<String>(
                      value: selectedValueOfBed,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValueOfBed = newValue!;
                        });
                      },
                      items: bed
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: const TextStyle(color: Colors.blue)),
                        );
                      }).toList(),
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.red),
                      dropdownColor: Colors.grey[200],
                      underline: const SizedBox(),
                      hint: const Text('beds'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildField(
                  controller: locationController,
                  hint: 'location',
                  suffix: const Icon(CupertinoIcons.location),
                ),
                const SizedBox(height: 10),
                _buildField(
                    controller: priceController, hint: 'Price'),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(left: 13, right: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextButton(
                    onPressed: _onUpload,
                    child: const HeadingText(text: 'Upload'),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onUpload() async {
    final imgUrls = await uploadImages(images);
    final newListing = PropertyListing(
      id: '',
      title: titleController.text,
      desc: descriptionController.text,
      location: locationController.text,
      price: priceController.text,
      bedrooms: selectedValueOfBed.toString(),
      bathrooms: selectedValueOfBath.toString(),
      imageUrl: imgUrls,
      interior: '',
    );
    await _listingService.uploadListingToDB(newListing, selectedCategory!);
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    double? height,
    Widget? suffix,
  }) {
    return Container(
      padding: const EdgeInsets.only(left: 13, right: 5),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          suffixIcon: suffix,
        ),
      ),
    );
  }
}
