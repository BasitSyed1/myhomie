import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:my_homie/data/models/property_listing.dart';

class ListingService {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref('ListingCategories');

  Future<List<PropertyListing>> fetchListingsByCategory(String category) async {
    try {
      final snapshot = await _databaseReference.child(category).get();

      if (snapshot.exists) {
        final List<PropertyListing> listings = [];
        final data = snapshot.value;

        debugPrint('Fetched data: $data');

        if (data is Map) {
          data.forEach((key, value) {
            if (value is Map) {
              final listing =
                  PropertyListing.fromMap(Map<String, dynamic>.from(value));
              listings.add(listing);
            }
          });
          return listings;
        } else {
          debugPrint(
              'Data is not in the expected format (Map). Received: ${data.runtimeType}');
          return [];
        }
      } else {
        debugPrint('No data found in the category: $category');
        return [];
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      return [];
    }
  }

  Future<void> uploadListingToDB(
      PropertyListing listing, String selectedCategory) async {
    try {
      final Map<dynamic, dynamic> listingData = listing.toMap();
      final database = FirebaseDatabase.instance.ref();
      await database
          .child('ListingCategories')
          .child(selectedCategory)
          .push()
          .set(listingData);
      debugPrint('Data uploaded successfully!');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
