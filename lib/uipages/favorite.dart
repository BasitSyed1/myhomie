import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myhomie/provider/favoriteProvider.dart';
import 'package:myhomie/widgets/listingCard.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
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
        child: Expanded(
          child: provider.favListing.isNotEmpty
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
                        item: favoriteListing[index]);
                  },
                )
              : const Center(
                  child: Text(
                  'You Have No Favorite Listings',
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w800,
                      fontSize: 18),
                                  )),
        ),
      ),
    );
  }
}
