import 'package:filmify/screens/about_content.dart';
import 'package:filmify/screens/review_content.dart';
import 'package:flutter/material.dart';

class CustomDetailsContainer extends StatelessWidget {
  final int selectedTabIndex;
  final Function(int) onTabSelected;
  final Map<String, dynamic> movie; // Perbarui tipe data
  final List<Map<String, String>> reviews; // Data review untuk ReviewContent

  const CustomDetailsContainer({
    required this.selectedTabIndex,
    required this.onTabSelected,
    required this.movie,
    required this.reviews,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tabs: About and Review
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => onTabSelected(0),
                child: Column(
                  children: [
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:
                            selectedTabIndex == 0 ? Colors.black : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => onTabSelected(1),
                child: Column(
                  children: [
                    Text(
                      'Review',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:
                            selectedTabIndex == 1 ? Colors.black : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Page Indicator (Merata)
          Stack(
            children: [
              // Background Line (grey for inactive states)
              Container(
                height: 2,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                ),
              ),
              // Active Indicator Line (black for active tab)
              AnimatedAlign(
                alignment: selectedTabIndex == 0
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 2,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Content based on selected tab
          if (selectedTabIndex == 0)
            AboutContent(movie: movie)
          else
            ReviewContent(reviews: reviews),
        ],
      ),
    );
  }
}
