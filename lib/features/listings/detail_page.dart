import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_homie/shared/widgets/heading_text.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final String location;
  final String desc;
  final String price;
  final String bathrooms;
  final String bedrooms;
  final List<String> images;

  const DetailPage({
    super.key,
    required this.title,
    required this.location,
    required this.images,
    required this.price,
    required this.desc,
    required this.bathrooms,
    required this.bedrooms,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
            SizedBox(
              height: 200,
              width: double.infinity,
              child: CarouselSlider.builder(
                itemCount: widget.images.length,
                itemBuilder:
                    (BuildContext context, int index, int realIndex) {
                  final image = widget.images[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(image, fit: BoxFit.cover),
                  );
                },
                options: CarouselOptions(
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 3),
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 10,
                  viewportFraction: 0.8,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
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
                        ? Colors.deepOrange.withValues(alpha: 0.3)
                        : Colors.grey.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ContactAction(icon: Icons.phone, title: 'Call'),
                  _ContactAction(
                      icon: Icons.phone_in_talk_outlined, title: 'WhatsApp'),
                  _ContactAction(
                      icon: Icons.email_outlined, title: 'Mail'),
                  _ContactAction(icon: Icons.share, title: 'Share'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F4F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.desc,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F4F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.location_solid),
                    const SizedBox(width: 15),
                    Text(widget.location),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
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
                        const SizedBox(height: 5),
                        HeadingText(text: 'Rs.${widget.price}'),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                      child: VerticalDivider(
                          color: Colors.grey, thickness: 1.8, width: 10),
                    ),
                    Column(
                      children: [
                        const Icon(
                          CupertinoIcons.bed_double_fill,
                          size: 22,
                          color: Colors.lightGreen,
                        ),
                        const SizedBox(height: 5),
                        Text(widget.bedrooms),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                      child: VerticalDivider(
                          color: Colors.grey, thickness: 1.8, width: 10),
                    ),
                    Column(
                      children: [
                        const Icon(
                          Icons.bathtub,
                          size: 22,
                          color: Colors.lightGreen,
                        ),
                        const SizedBox(height: 5),
                        Text(widget.bathrooms),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                      child: VerticalDivider(
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
                        SizedBox(height: 5),
                        Text('1000SqFt.'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.person_fill, color: Colors.white),
                      Text(
                        'Contact to Agent',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactAction extends StatelessWidget {
  final IconData icon;
  final String title;

  const _ContactAction({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 75,
        height: 60,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F4F9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.green, size: 20),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(fontSize: 10, color: Colors.green),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
