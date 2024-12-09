import 'package:filmify/widgets/detail_movie/custom_card_container.dart';
import 'package:filmify/widgets/detail_movie/custom_details_container.dart';
import 'package:filmify/widgets/detail_movie/custom_info_section.dart';
import 'package:flutter/material.dart';

class DetailMovie extends StatefulWidget {
  final Map<String, dynamic> movie; // Perbarui tipe data

  const DetailMovie({super.key, required this.movie});

  @override
  // ignore: library_private_types_in_public_api
  _DetailMovieState createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  int _selectedTabIndex = 0; // 0: About, 1: Review

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCardContainer(movie: widget.movie),
            CustomInfoSection(movie: widget.movie),
            CustomDetailsContainer(
              selectedTabIndex: _selectedTabIndex,
              onTabSelected: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
              movie: widget.movie,
              reviews:
                  widget.movie['reviews'] as List<Map<String, String>>? ?? [],
            ),
          ],
        ),
      ),
    );
  }
}
