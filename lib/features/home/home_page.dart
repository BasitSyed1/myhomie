import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_homie/app/routes/app_routes.dart';
import 'package:my_homie/core/constants/sample_listings.dart';
import 'package:my_homie/features/listings/categories/house_screen.dart';
import 'package:my_homie/shared/widgets/heading_text.dart';
import 'package:my_homie/shared/widgets/main_listing_card.dart';
import 'package:my_homie/shared/widgets/search_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.all(14),
          width: 5,
          height: 5,
          child: Image.asset('assets/images/menu.png'),
        ),
        backgroundColor: Colors.white,
        actions: [
          SizedBox(
            width: 24,
            height: 24,
            child: Image.asset('assets/images/bell.png'),
          ),
          const SizedBox(width: 30),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [HeadingText(text: 'Hi, There!')]),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SearchWidget(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HouseScreen(),
                        ),
                      );
                    },
                    child: _categoryCard(
                      const AssetImage('assets/images/house.png'),
                      'House',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, AppRoutes.apartment),
                    child: _categoryCard(
                      const AssetImage('assets/images/apartment.png'),
                      'apartment',
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.shop),
                    child: _categoryCard(
                      const AssetImage('assets/images/shop.png'),
                      'shop',
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.property),
                    child: _categoryCard(
                      const AssetImage('assets/images/property.png'),
                      'property',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: HeadingText(text: 'Feature'),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                height: 235,
                child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: sampleListings.length,
                  itemBuilder: (BuildContext context, int index) {
                    final listing = sampleListings[index];
                    return MainListingCard(
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
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: HeadingText(text: 'Recommended For You'),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(height: 850, child: _bottomGrid()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryCard(ImageProvider img, String title) {
    return Container(
      width: 80,
      height: 60,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F4F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              image: DecorationImage(image: img, fit: BoxFit.cover),
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _bottomGrid() {
    return GridView.builder(
      itemCount: sampleListings.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.63,
      ),
      itemBuilder: (BuildContext context, int index) {
        final listing = sampleListings[index];
        return _ListingCardVertical(
          title: listing['description'].toString(),
          location: listing['address'].toString(),
          imagepath: listing['image_url'].toString(),
        );
      },
    );
  }
}

class _ListingCardVertical extends StatelessWidget {
  final String title;
  final String location;
  final String imagepath;

  const _ListingCardVertical({
    required this.title,
    required this.location,
    required this.imagepath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F4F9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(imagepath, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.location_solid,
                    size: 15,
                    color: Colors.grey[800],
                  ),
                  SizedBox(
                    width: 120,
                    child: Text(
                      location,
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '\$120000',
                    style: TextStyle(
                        color: Colors.deepOrange, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      'Explore',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Positioned(
          right: 15,
          top: 15,
          child: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.favorite_border_outlined,
              color: Colors.deepOrangeAccent,
              size: 15,
            ),
          ),
        ),
      ],
    );
  }
}
