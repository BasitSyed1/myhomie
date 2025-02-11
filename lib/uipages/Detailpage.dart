import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myhomie/widgets/headingtext.dart';

class Detailpage extends StatefulWidget {
  final String title;
  final String location;
  final String desc;
  final String price;
  final String bathrooms;
  final String bedrooms;
  List<String> images;

  Detailpage(
      {super.key,
      required this.title,
      required this.location,
      required this.images,
      required this.price,
      required this.desc,
      required this.bathrooms,
      required this.bedrooms});

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: CarouselSlider.builder(
                itemCount: widget.images.length,
                itemBuilder:
                    (BuildContext context, int index, int realIndex) {
                  final image = widget.images[index];
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: Image.network(
                            image,
                            fit: BoxFit.cover,
                          )));
                },
                options: CarouselOptions(
                  autoPlay: false,
                  // Automatically play the slider
                  autoPlayInterval: const Duration(seconds: 3),
                  // Interval between auto plays
                  enlargeCenterPage: true,
                  // Enlarge the current page
                  aspectRatio: 16 / 10,
                  // Aspect ratio of the slider
                  viewportFraction: 0.8,
                  // Fraction of the screen occupied by the carousel
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index
                        ? Colors.deepOrange.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildcategoriesCard(Icons.phone, 'Call'),
                  buildcategoriesCard(
                      Icons.phone_in_talk_outlined, 'WhatsApp'),
                  buildcategoriesCard(Icons.email_outlined, 'Mail'),
                  buildcategoriesCard(Icons.share, 'Share'),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                child: Text(widget.desc,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,

                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F4F9),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.location_solid),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(widget.location)
                  ],
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F4F9),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Icon(
                          CupertinoIcons.money_dollar_circle,
                          size: 22,
                          color: Colors.lightGreen,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Headingtext(text: 'Rs.${widget.price}'),
                      ],
                    ),
                    Container(
                      height: 40,
                      child: const VerticalDivider(
                          color: Colors.grey, thickness: 1.8, width: 10),
                    ),
                    Column(
                      children: [
                        const Icon(
                          CupertinoIcons.bed_double_fill,
                          size: 22,
                          color: Colors.lightGreen,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(widget.bedrooms),
                      ],
                    ),
                    Container(
                      height: 40,
                      child: const VerticalDivider(
                          color: Colors.grey, thickness: 1.8, width: 10),
                    ),
                    Column(
                      children: [
                        const Icon(
                          Icons.bathtub,
                          size: 22,
                          color: Colors.lightGreen,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(widget.bathrooms),
                      ],
                    ),
                    Container(
                      height: 40,
                      child: const VerticalDivider(
                          color: Colors.grey, thickness: 1.8, width: 10),
                    ),
                    const Column(
                      children: [
                        Icon(
                          CupertinoIcons
                              .rectangle_arrow_up_right_arrow_down_left,
                          size: 22,
                          color: Colors.lightGreen,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('1000SqFt.'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.person_fill, color: Colors.white,),
                        Text('Contact to Agent', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),),
                      ],
                    ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildcategoriesCard(IconData icon, String title) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      width: 75,
      height: 60,
      padding: const EdgeInsets.all(1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 20,
            child: Icon(
              icon,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 5), // Add some spacing between image and text
          Text(
            title,
            style: const TextStyle(fontSize: 10, color: Colors.green),
            textAlign: TextAlign.center, // Center-align the text
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F4F9),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
