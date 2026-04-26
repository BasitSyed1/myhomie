import 'package:flutter/foundation.dart';

class FavoriteProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _favListing = [];

  List<Map<String, dynamic>> get favListing => _favListing;

  void addToFavorite(Map<String, dynamic> item) {
    if (!_favListing.any(
        (favItem) => favItem['listing_id'] == item['listing_id'])) {
      _favListing.add(item);
      notifyListeners();
    }
  }

  void removeFromFavorite(Map<String, dynamic> item) {
    _favListing.removeWhere(
        (favItem) => favItem['listing_id'] == item['listing_id']);
    notifyListeners();
  }
}
