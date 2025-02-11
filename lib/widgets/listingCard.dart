import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myhomie/provider/favoriteProvider.dart';
import 'package:provider/provider.dart';

class ListingCard extends StatelessWidget {
  final String title;
  final String location;
  final String imagepath;
  final String desc;
  final String bathrooms;
  final String bedrooms;
  final String price;
  final Map<String, dynamic> item;

  ListingCard(
      {super.key,
      required this.title,
      required this.location,
      required this.imagepath,
      required this.desc,
      required this.bathrooms,
      required this.bedrooms,
      required this.price,
      required this.item});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);
    final isSelected = provider.favListing.any((favItem) => favItem['listing_id'] == item['listing_id']);


    return Stack(
      children: [
        Container(
          height: 150,
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: const Color(0xFFF5F4F9),
              borderRadius: BorderRadius.circular(16)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 150,
                height: 130,
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
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 140,
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                  const SizedBox(
                    height: 5,
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
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Row(
                    children: [
                      Text(
                        'RS.1200000',
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 14,
                            fontWeight: FontWeight.w800),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Icon(
                            CupertinoIcons.arrow_right,
                            color: Colors.deepOrange,
                          ))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 25,
          left: 20,
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
              backgroundColor:
              isSelected ? Colors.deepOrange : Colors.white,
              child: Icon(
                isSelected
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: isSelected
                    ? Colors.white
                    : Colors.deepOrangeAccent,
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
