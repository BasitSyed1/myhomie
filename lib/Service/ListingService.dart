import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';
import 'package:myhomie/dataModel/dataModel.dart';

class ListingService{

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref('ListingCategories');

  Future<List<PropertyListing>> fetchListingsByCategory(String category) async {
    try {
      final snapshot = await _databaseReference.child(category).get();

      if (snapshot.exists) {
        // Map retrieved data to a list of Listing objects
        List<PropertyListing> listings = [];
        var data = snapshot.value;

        // Debug print to inspect the data type and structure
        print("Fetched data: $data");

        // Ensure the data is a Map before proceeding
        if (data is Map) {
          data.forEach((key, value) {
            if (value is Map) {
              PropertyListing listing = PropertyListing.fromMap(Map<String, dynamic>.from(value));
              listings.add(listing);
            }
          });
          return listings;
        } else {
          print("Data is not in the expected format (Map). Received: ${data.runtimeType}");
          return [];
        }
      } else {
        print("No data found in the category: $category");
        return [];
      }
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }


  Future<void> uploadListingToDB(PropertyListing listing, String selectedCategory)async{
    try{
      //convert the property object to map
      Map<dynamic, dynamic> listingData = listing.toMap();

      final DatabaseReference _database = FirebaseDatabase.instance.ref();
      _database.child('ListingCategories').child(selectedCategory).push().set(listingData);
      print("Data uploaded successfully!");
    }catch(e){
      print({e.toString()});
    }
  }

}

