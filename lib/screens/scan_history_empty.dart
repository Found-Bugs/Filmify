import 'package:filmify/data/data_movie_A.dart';
import 'package:filmify/screens/detail_movie.dart';
import 'package:filmify/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:filmify/services/auth_service.dart';

class ScanHistory extends StatefulWidget {
  const ScanHistory({super.key});

  @override
  _ScanHistoryState createState() => _ScanHistoryState();
}

class _ScanHistoryState extends State<ScanHistory> {
  List<Map<String, dynamic>> _history = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final authService = AuthService();
      final history = await authService.fetchPredictionHistory(user.uid);
      setState(() {
        _history = history;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      title: "Scan History",
      hintText: "Cari Judul Film",
      content: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16), // Padding dalam container
          decoration: BoxDecoration(
            color: Colors.white, // Latar belakang putih
            borderRadius: BorderRadius.circular(12), // Sudut melengkung
            border: Border.all(
              color: Colors.grey.withOpacity(0.5), // Warna border abu-abu
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Bayangan halus
                blurRadius: 4,
                offset: const Offset(0, 2), // Posisi bayangan
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul Scan Result
              const Center(
                child: Text(
                  "Scan Result",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Tampilkan riwayat scan
              if (_isLoading)
                Center(child: CircularProgressIndicator())
              else if (_history.isEmpty)
                Center(child: Text('No history found.'))
              else
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    final item = _history[index];
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item['image_url'],
                          fit: BoxFit.cover,
                          width: 110,
                          height: 160,
                        ),
                      ),
                      title: Text(
                        item['prediction']['predicted_class'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        'Confidence: ${(item['prediction']['confidence'] * 100).toStringAsFixed(2)}%',
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomHistoryCard extends StatelessWidget {
  final List<Map<String, dynamic>> movies; // Ubah tipe data

  const CustomHistoryCard({
    super.key,
    required this.movies, // Data film diterima melalui parameter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () {
                },
                child: Container(
                  width: 110,
                  margin: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          movie['imagePath']!,
                          fit: BoxFit.cover,
                          width: 110,
                          height: 160,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie['title']!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
