import 'package:flutter/material.dart';

void main() {
  runApp(NearestCinemaApp());
}

class NearestCinemaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nearest Cinema',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NearestCinemaPage(),
    );
  }
}

class NearestCinemaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            right: 16.0,
            left: 16.0,
            top: 50.0,
            bottom: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nearest Cinema Title
              Center(
                child: Text(
                  "Nearest Cinema",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              // Search Bar
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari Cinema Terdekat',
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.bookmark, color: Colors.black),
                    iconSize: 30,
                    onPressed: () {
                      // Add bookmark functionality here
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Cinema List
              buildCinemaCard(
                cinemaName: "Transmart MX XXI",
                address:
                    "Mall Transmart, Jl. Veteran Lt. 5, Penanggungan, Kec. Klojen, Kota Malang, Jawa Timur 65113",
                logoPath: "assets/img/Heretic.jpg",
              ),
              buildCinemaCard(
                cinemaName: "Cinepolis Malang Town Square",
                address:
                    "Malang Town Square, Jl. Veteran Lt. 5, Penanggungan, Kec. Klojen, Kota Malang, Jawa Timur 65113",
                logoPath: "assets/img/Heretic.jpg",
              ),
              buildCinemaCard(
                cinemaName: "Mopic Cinemas Malang",
                address:
                    "Jl. Soekarno  Hatta No.9, Mojolangu, Kec. Lowokwaru, Kota Malang, Jawa Timur 65141",
                logoPath: "assets/img/Heretic.jpg",
              ),
              buildCinemaCard(
                cinemaName: "Araya XXI",
                address:
                    "Komp. Araya Business Center, Jl. R. Bimbing Indah Megah No.2, Purwodadi, Kec. Blimbing, Kota Malang, Jawa Timur 65126",
                logoPath: "assets/img/Heretic.jpg",
              ),
              buildCinemaCard(
                cinemaName: "Movimax Sarinah",
                address:
                    "Sarinah Plaza, Jl. Jenderal Basuki Rahmat No.26, Kiduldalem, Kec. Klojen, Kota Malang, Jawa Timur 65119",
                logoPath: "assets/img/Heretic.jpg",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Cinema Card Widget
  Widget buildCinemaCard({
    required String cinemaName,
    required String address,
    required String logoPath,
  }) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            // Cinema Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cinemaName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    address,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Add location button functionality
                    },
                    icon: const Icon(Icons.location_on, color: Colors.white),
                    label: const Text("Location"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
                width: 20), // Increased spacing between text and image

            // Cinema Logo with border
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  logoPath,
                  height: 120,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
