import 'dart:async';
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
  List<Map<String, String>>? banners;
  int currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    bannersFuture = DataBanner.fetchBanners();
    bannersFuture.then((data) {
      setState(() {
        banners = data;
      });
      _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients && banners != null) {
        int nextPage = _pageController.page!.toInt() + 1;
        if (nextPage >= banners!.length + 1) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  void _onPageChanged(int index, int bannerCount) {
    setState(() {
      currentPage = index;
    });

    if (index == bannerCount) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _pageController.jumpToPage(0);
      });
    } else if (index == -1) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _pageController.jumpToPage(bannerCount - 1);
      });
    }
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
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) =>
                      _onPageChanged(index, banners.length),
                  itemCount: banners.length + 1,
                  itemBuilder: (context, index) {
                    if (index == banners.length) {
                      return CustomBanner(
                        imagePath: banners[0]['imagePath']!,
                        title: banners[0]['title']!,
                        subtitle: banners[0]['subtitle']!,
                      );
                    }
                    return CustomBanner(
                      imagePath: banners[index]['imagePath']!,
                      title: banners[index]['title']!,
                      subtitle: banners[index]['subtitle']!,
                    );
                  },
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
