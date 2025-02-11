import 'dart:ffi';

import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';

class PropertyListing {
  final String id;
  final String title;
  final String desc;
  final String location;
  final String price;
  final String interior;
  final String bedrooms;
  final String bathrooms;
  final List<String> imageUrl;

  PropertyListing({
    required this.id,
    required this.title,
    required this.desc,
    required this.location,
    required this.price,
    required this.interior,
    required this.bedrooms,
    required this.bathrooms,
    required this.imageUrl,
  });

  //factory constructor to create a Listing from object from a Map
  factory PropertyListing.fromMap(Map<String, dynamic>map){
    return PropertyListing(
        id: map['id'] ?? '',
        title: map['title'] ?? '',
        desc: map['desc'] ?? '',
        location: map['location'] ?? '',
        price: map['price']  ?? ' ',
      interior: map['interior']  ?? ' ',
        bedrooms: map['bedrooms'] ?? '',
        bathrooms: map['bathrooms'] ?? '',
        imageUrl: List<String>.from(map['imageUrl'] ?? ''),
    );
  }

  //method to convert listing object to a Map
  Map<dynamic, dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'location': location,
      'price': price,
      'interior': interior,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'imageUrl': imageUrl,
    };
  }



}
