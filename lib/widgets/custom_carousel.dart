import 'package:filmify/data/data_banner.dart';
import 'package:filmify/widgets/custom_banner.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({super.key});

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView(
            controller: _pageController,
            children: DataBanner.banners.map((banner) {
              return CustomBanner(
                imagePath: banner['imagePath']!,
                title: banner['title']!,
                subtitle: banner['subtitle']!,
              );
            }).toList(),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: DataBanner.banners.length,
              effect: const WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Colors.indigo,
                dotColor: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
