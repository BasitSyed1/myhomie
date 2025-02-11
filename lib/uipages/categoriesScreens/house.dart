import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myhomie/Service/ListingService.dart';
import 'package:myhomie/dataModel/dataModel.dart';
import 'package:myhomie/provider/favoriteProvider.dart';
import 'package:myhomie/uipages/Detailpage.dart';
import 'package:myhomie/uipages/favorite.dart';
import 'package:myhomie/widgets/Search_Widget.dart';
import 'package:myhomie/widgets/headingtext.dart';
import 'package:myhomie/widgets/listingCard.dart';
import 'package:provider/provider.dart';

class House extends StatefulWidget {
  const House({super.key});

  @override
  State<House> createState() => _HouseState();
}

class _HouseState extends State<House> {
  List<PropertyListing> listing = [];
  bool isLoading = true;

  final ListingService _listingService = ListingService();

  @override
  void initState() {
    super.initState();
    _fetchListings();
  }

  Future<void> _fetchListings() async {
    List<PropertyListing> _propertyListing =
        await _listingService.fetchListingsByCategory('Home');
    setState(() {
      listing = _propertyListing;
      isLoading = false;
    });
  }

  bool isSelected = false;

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
            SearchWidget(),
            SizedBox(
              height: 10,
            ),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : listing.isEmpty
                    ? Center(child: Text('No properties available.'))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: listing.length,
                          itemBuilder: (context, index) {
                            final propertListing = listing[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Detailpage(
                                              title: propertListing.title,
                                              location: propertListing.location,
                                              images: propertListing.imageUrl,
                                              price: propertListing.price,
                                              desc: propertListing.desc,
                                              bathrooms:
                                                  propertListing.bathrooms,
                                              bedrooms: propertListing.bedrooms,
                                            )));
                              },
                              child: ListingCard(
                              title: propertListing.title,
                            location: propertListing.location,
                            imagepath: propertListing.imageUrl[0],
                            price: propertListing.price,
                            desc: propertListing.desc,
                            bathrooms: propertListing.bathrooms,
                            bedrooms: propertListing.bedrooms,  item: {},
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
