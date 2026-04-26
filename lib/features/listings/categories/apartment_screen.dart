import 'package:flutter/material.dart';
import 'package:my_homie/core/constants/sample_listings.dart';
import 'package:my_homie/shared/widgets/listing_card.dart';
import 'package:my_homie/shared/widgets/search_widget.dart';

class ApartmentScreen extends StatelessWidget {
  const ApartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(child: Text('Apartments')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SearchWidget(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: sampleListings.length,
                itemBuilder: (BuildContext context, int index) {
                  final listing = sampleListings[index];
                  return ListingCard(
                    title: listing['description'].toString(),
                    location: listing['address'].toString(),
                    imagepath: listing['image_url'].toString(),
                    desc: listing['description'].toString(),
                    bathrooms: listing['bathrooms'].toString(),
                    bedrooms: listing['bedrooms'].toString(),
                    price: listing['price'].toString(),
                    item: listing,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
