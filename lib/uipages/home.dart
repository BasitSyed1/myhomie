import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myhomie/uipages/Detailpage.dart';
import 'package:myhomie/uipages/categoriesScreens/house.dart';
import 'package:myhomie/utils/routes.dart';
import 'package:myhomie/widgets/Search_Widget.dart';
import 'package:myhomie/widgets/headingtext.dart';
import 'package:myhomie/dataModel/dataModel.dart';
import 'package:myhomie/widgets/main_PageListingCard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Map<String, dynamic>> listings = [
    {
      "listing_id": 101,
      "address": "123 Maple Street, Springfield, IL",
      "price": 350000,
      "bedrooms": 4,
      "bathrooms": 3,
      "square_feet": 2500,
      "lot_size": 0.25,
      "year_built": 2005,
      "description":
          "Spacious family home with a large backyard and modern amenities.",
      "listing_date": "2025-01-01",
      "agent_name": "John Doe",
      "agent_phone": "555-1234",
      "status": "Active",
      "image_url":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZxll7mgS9x1BLOH5MGBTdPnsU57FbzVe0cQwaGWdL6qcpwfTnTtgtoaj28nr0txwYRxI&usqp=CAU",
    },
    {
      "listing_id": 102,
      "address": "456 Oak Avenue, Chicago, IL",
      "price": 275000,
      "bedrooms": 3,
      "bathrooms": 2,
      "square_feet": 1800,
      "lot_size": 0.15,
      "year_built": 2010,
      "description":
          "Charming home close to downtown with easy access to public transport.",
      "listing_date": "2025-01-10",
      "agent_name": "Sarah Smith",
      "agent_phone": "555-5678",
      "status": "Active",
      "image_url":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8DUtcVvWLMr3DNV0SZvfP6zmUB07DTt3LMuWq16ynzZltRjRluQ0X22PnpQcRQSC-yGg&usqp=CAU"
    },
    {
      "listing_id": 103,
      "address": "789 Pine Road, Oakwood, IL",
      "price": 475000,
      "bedrooms": 5,
      "bathrooms": 4,
      "square_feet": 3500,
      "lot_size": 0.5,
      "year_built": 1998,
      "description":
          "Luxurious home with a pool and expansive outdoor living area.",
      "listing_date": "2025-01-15",
      "agent_name": "Mike Johnson",
      "agent_phone": "555-8901",
      "status": "Pending",
      "image_url":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiYFTLYYXuwKa4WhjuxZvgLlEoN2daxAvlTkdu-HvToFYi-v9Exb1PwfAZbFfhmfNkWys&usqp=CAU"
    },
    {
      "listing_id": 104,
      "address": "321 Birch Lane, Milltown, IL",
      "price": 220000,
      "bedrooms": 2,
      "bathrooms": 1,
      "square_feet": 1200,
      "lot_size": 0.12,
      "year_built": 1985,
      "description":
          "Affordable starter home in a quiet neighborhood with good schools.",
      "listing_date": "2025-01-20",
      "agent_name": "Emily White",
      "agent_phone": "555-4321",
      "status": "Active",
      "image_url":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRy_6Yg4imUqRZYIkwTllHrvUfZ0-XV7A8nnPKe2JcCLCe0F2sb1OQeocMADffAbMqLDwI&usqp=CAU"
    },
    {
      "listing_id": 105,
      "address": "654 Elm Street, Riverside, IL",
      "price": 550000,
      "bedrooms": 6,
      "bathrooms": 5,
      "square_feet": 4000,
      "lot_size": 0.75,
      "year_built": 2015,
      "description":
          "Modern, luxury home with a home theater, gym, and beautiful landscaping.",
      "listing_date": "2025-01-25",
      "agent_name": "David Brown",
      "agent_phone": "555-6789",
      "status": "Active",
      "image_url":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6OzqyynD3ENykraslq4aktrHPpCjMO4UCOdjm0oqlzCk4_hbVlWpNXZlgxOqxgZKwy5Q&usqp=CAU"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.all(14),
            width: 5,
            height: 5,
            child: Image.asset('assets/images/menu.png',)),
        backgroundColor: Colors.white,
        actions: [
          Container(

              width: 24,
              height: 24,

              child: Image.asset('assets/images/bell.png',)),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                Headingtext(text: 'Hi, There!'),
              ]),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10),
              child: SearchWidget(),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const House()));
                      },
                      child: buildcategoriesCard(
                        const AssetImage('assets/images/house.png'),
                        'House',
                      )),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, myRoutes.apartmentRoute);
                    },
                    child: buildcategoriesCard(
                        const AssetImage('assets/images/apartment.png'),
                        'apartment'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, myRoutes.shopRoute);
                    },
                    child: buildcategoriesCard(
                        const AssetImage('assets/images/shop.png'), 'shop'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, myRoutes.propertyRoute);
                    },
                    child: buildcategoriesCard(
                      const AssetImage('assets/images/property.png'),
                      'property',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10),
              child: Headingtext(text: 'Feature'),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                height: 235,
                child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: listings.length,
                  itemBuilder: (BuildContext context, int index) {
                    final listing = listings.toList()[index];
                    return MainScreenListingCard(
                      title: listing['description'].toString(),
                      location: listing['address'].toString(),
                      imagepath: listing['image_url'].toString(),
                      desc: listing['description'].toString(),
                      bathrooms: listing['bathrooms'].toString(),
                      bedrooms: listing['bedrooms'].toString(),
                      price: listing['price'].toString(),
                      item: listings[index],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Headingtext(text: 'Recommended For You'),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(height: 850, child: bottomGrid()),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildcategoriesCard(ImageProvider img, String title) {
    return Container(
      width: 80,
      height: 60,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xFFF5F4F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: img,
                fit: BoxFit.cover, // Adjust the image fit here
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center, // Center-align the text
          ),
        ],
      ),
    );
  }

  Widget bottomGrid() {
    return GridView.builder(
      itemCount: listings.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.63,
      ),
      itemBuilder: (BuildContext context, int index) {
        final listing = listings[index];
        return ListingCardVertical(listing['description'].toString(),
            listing['address'].toString(), listing['image_url']);
      },
    );
  }

  Widget ListingCardVertical(
    String title,
    String location,
    String imagepath,
  ) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: const Color(0xFFF5F4F9),
              borderRadius: BorderRadius.circular(16)),
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
                    child: Image.network(
                      imagepath,
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                  child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
              const SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.location_solid,
                    size: 15,
                    color: Colors.grey[800],
                  ),
                  Container(
                    width: 120,
                    child: Text(
                      location,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: const Text(
                      '\$120000',
                      style: TextStyle(color: Colors.deepOrange, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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
                      ))
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
