import 'package:flutter/material.dart';
import 'package:my_homie/data/models/property_listing.dart';
import 'package:my_homie/data/services/listing_service.dart';
import 'package:my_homie/features/listings/detail_page.dart';
import 'package:my_homie/shared/widgets/listing_card.dart';
import 'package:my_homie/shared/widgets/search_widget.dart';

class HouseScreen extends StatefulWidget {
  const HouseScreen({super.key});

  @override
  State<HouseScreen> createState() => _HouseScreenState();
}

class _HouseScreenState extends State<HouseScreen> {
  List<PropertyListing> listing = [];
  bool isLoading = true;

  final ListingService _listingService = ListingService();

  @override
  void initState() {
    super.initState();
    _fetchListings();
  }

  Future<void> _fetchListings() async {
    final propertyListing =
        await _listingService.fetchListingsByCategory('Home');
    if (!mounted) return;
    setState(() {
      listing = propertyListing;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Houses'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SearchWidget(),
            const SizedBox(height: 10),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (listing.isEmpty)
              const Center(child: Text('No properties available.'))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: listing.length,
                  itemBuilder: (context, index) {
                    final propertyListing = listing[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              title: propertyListing.title,
                              location: propertyListing.location,
                              images: propertyListing.imageUrl,
                              price: propertyListing.price,
                              desc: propertyListing.desc,
                              bathrooms: propertyListing.bathrooms,
                              bedrooms: propertyListing.bedrooms,
                            ),
                          ),
                        );
                      },
                      child: ListingCard(
                        title: propertyListing.title,
                        location: propertyListing.location,
                        imagepath: propertyListing.imageUrl.isNotEmpty
                            ? propertyListing.imageUrl[0]
                            : '',
                        price: propertyListing.price,
                        desc: propertyListing.desc,
                        bathrooms: propertyListing.bathrooms,
                        bedrooms: propertyListing.bedrooms,
                        item: const {},
                      ),
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
