import 'package:flutter/material.dart';
import 'package:myhomie/provider/favoriteProvider.dart';
import 'package:myhomie/widgets/Search_Widget.dart';
import 'package:myhomie/widgets/listingCard.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List <Map<String, dynamic>> listings = [
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
        backgroundColor: Colors.white,
          title: Center(child: Text('Shops'),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SearchWidget(),
            SizedBox(height: 10,),
            Expanded(child: ListView.builder(
              itemCount: listings.length,
                itemBuilder: (BuildContext context, int index) {
                final listing = listings[index];
                  return ListingCard(
                      title: listing['description'].toString(),
                      location: listing['address'].toString(),
                      imagepath: listing['image_url'].toString(),
                      desc: listing['description'].toString(),
                      bathrooms: listing['bathrooms'].toString(),
                      bedrooms: listing['bedrooms'].toString(),
                      price: listing['price'].toString(),
                      item: listings[index],
                  );
                })),
          ],
        ),
      ),
    );
  }
}
