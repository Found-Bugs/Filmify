import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../data/data_banner.dart';
import '../widgets/custom_banner.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({super.key});

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  final PageController _pageController = PageController();
  late Future<List<Map<String, String>>> bannersFuture;

  @override
  void initState() {
    super.initState();
    bannersFuture = DataBanner.fetchBanners();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: bannersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No banners available'));
        } else {
          final banners = snapshot.data!;
          return Column(
            children: [
              SizedBox(
                height: 180,
                child: PageView(
                  controller: _pageController,
                  children: banners.map((banner) {
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
                    count: banners.length,
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
      },
    );
  }
}
