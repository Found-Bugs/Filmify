import 'package:filmify/tmdb_api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:filmify/screens/detail_movie.dart'; // Import the DetailMovie screen

class CustomSearch extends StatefulWidget {
  const CustomSearch({super.key});

  @override
  _CustomSearchState createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  final TextEditingController _controller = TextEditingController();
  final TMDBApiService _apiService = TMDBApiService();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;

  void _onSearchChanged(String query) async {
    if (query.isNotEmpty) {
      setState(() {
        _isSearching = true;
      });
      final results = await _apiService.searchMovies(query);
      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search movies title',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onChanged: _onSearchChanged,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.bookmark, color: Colors.black),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bookmark ditekan!')),
                );
              },
            ),
          ],
        ),
        if (_searchResults.isNotEmpty)
          Container(
            constraints:
                BoxConstraints(maxHeight: 470), // Increase the max height
            decoration: BoxDecoration(
              color: Colors.white, // Non-transparent background
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final movie = _searchResults[index];
                return ListTile(
                  contentPadding: EdgeInsets.all(3.0), // Add padding
                  leading: Container(
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w154${movie['poster_path']}', // Larger image
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    movie['title'],
                    style: TextStyle(
                      fontSize: 18, // Increase the font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMovie(movie: movie),
                      ),
                    );
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
