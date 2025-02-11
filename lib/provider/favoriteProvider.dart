import 'package:flutter/foundation.dart';
class FavoriteProvider with ChangeNotifier {
  List<Map<String, dynamic>> _favListing = [];
  List<Map<String, dynamic>> get favListing => _favListing;

  // Add a single item to the favorites
  void addToFavorite(Map<String, dynamic> item) {
    // Check if the item is already in the favorites based on its unique identifier
    if (!_favListing.any((favItem) => favItem['listing_id'] == item['listing_id'])) {
      _favListing.add(item);
      notifyListeners();  // Notify listeners that the list has changed
    }
  }

  // Remove from favorites
  void removeFromFavorite(Map<String, dynamic> item) {
    _favListing.removeWhere((favItem) => favItem['listing_id'] == item['listing_id']);
    notifyListeners();
  }
}
