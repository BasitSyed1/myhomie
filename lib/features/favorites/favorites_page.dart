import 'package:flutter/material.dart';
import 'package:my_homie/data/providers/favorite_provider.dart';
import 'package:my_homie/shared/widgets/listing_card.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);
    final favoriteListing = provider.favListing;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Favorite')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: favoriteListing.isNotEmpty
            ? ListView.builder(
                itemCount: favoriteListing.length,
                itemBuilder: (BuildContext context, int index) {
                  final listing = favoriteListing[index];
                  return ListingCard(
                    title: listing['description'].toString(),
                    location: listing['address'].toString(),
                    imagepath: listing['image_url'].toString(),
                    desc: listing['description'].toString(),
                    bathrooms: listing['bathrooms'].toString(),
                    bedrooms: listing['bedrooms'].toString(),
                    price: listing['price'].toString(),
                    item: favoriteListing[index],
                  );
                },
              )
            : const Center(
                child: Text(
                  'You Have No Favorite Listings',
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ),
      ),
    );
  }
}
