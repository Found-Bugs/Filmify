import 'package:filmify/tmdb_api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:filmify/screens/detail_movie.dart'; // Import the DetailMovie screen
import 'package:filmify/screens/home.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filmify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
      navigatorObservers: [routeObserver],
    );
  }
}

class CustomSearch extends StatefulWidget {
  const CustomSearch({super.key});

  @override
  _CustomSearchState createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> with RouteAware {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final TMDBApiService _apiService = TMDBApiService();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
    _resetSearch();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _resetSearch();
    }
  }

  void _resetSearch() {
    setState(() {
      _searchResults = [];
      _isSearching = false;
      _controller.clear();
    });
  }

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
      _resetSearch();
    }
  }

  @override
  void didPopNext() {
    _resetSearch();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
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
                        fit: BoxFit
                            .cover, // Ensure the image covers the container
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
                          builder: (context) => DetailMovie(id: movie['id']),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
