import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myhomie/provider/favoriteProvider.dart';
import 'package:provider/provider.dart';

class MainScreenListingCard extends StatelessWidget {
  final String title;
  final String location;
  final String imagepath;
  final String desc;
  final String bathrooms;
  final String bedrooms;
  final String price;
  final Map<String, dynamic> item;

  MainScreenListingCard({super.key, required this.title, required this.location, required this.imagepath, required this.desc, required this.bathrooms, required this.bedrooms, required this.price, required this.item});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);
    final isSelected = provider.favListing.any((favItem) => favItem['listing_id'] == item['listing_id']);
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Stack(
        children: [
          Container(
            height: 230,
            width: 250,
            padding: EdgeInsets.symmetric(),
            decoration: BoxDecoration(
                color: Color(0xFFF5F4F9),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 130,
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
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                      child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                ),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
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
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Rs: ${price}',
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 16,
                              fontWeight: FontWeight.w800),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            'Explore',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              onTap: () {
                if (isSelected) {
                  provider.removeFromFavorite(item);
                } else {
                  provider.addToFavorite(item);
                }
              },
              child: CircleAvatar(
                radius: 15,
                backgroundColor: isSelected ? Colors.deepOrange : Colors.white,
                child: Icon(
                  isSelected ? Icons.favorite : Icons.favorite_border_outlined,
                  color: isSelected ? Colors.white : Colors.deepOrangeAccent,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
