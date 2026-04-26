import 'package:flutter/material.dart';
import 'package:my_homie/data/providers/search_filter_provider.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchFilterProvider>(context);

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[100],
            ),
            child: const Row(
              children: [
                Icon(Icons.search_outlined),
                Text('Search a listing...'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: provider.toggle,
          child: Container(
            width: 35,
            height: 35,
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.deepOrange,
            ),
            child: provider.isSelected
                ? Image.asset(
                    'assets/images/filterfill.png',
                    color: Colors.white,
                  )
                : Image.asset(
                    'assets/images/filter.png',
                    color: Colors.white,
                  ),
          ),
        ),
      ],
    );
  }
}
