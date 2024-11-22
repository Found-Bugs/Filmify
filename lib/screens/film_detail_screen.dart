import 'package:flutter/material.dart';

class FilmDetailScreen extends StatefulWidget {
  const FilmDetailScreen({Key? key}) : super(key: key);

  @override
  _FilmDetailScreenState createState() => _FilmDetailScreenState();
}

class _FilmDetailScreenState extends State<FilmDetailScreen> {
  int _selectedTabIndex = 0; // 0: About, 1: Review

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container 1: Card Film
            CardContainer(),
            // Section: Information
            InfoSection(),
            // Container 2: Details Section
            DetailsContainer(
              selectedTabIndex: _selectedTabIndex,
              onTabSelected: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CardContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // Background Image
        Container(
          width: screenWidth, // Full width
          height: 400, // Set height for the card
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/background.jpg'), // Replace with your asset path
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Dark overlay for text
        Container(
          width: screenWidth,
          height: 400,
          color: Colors.black.withOpacity(0.6),
        ),

        // Back and Bookmark Buttons
        Positioned(
          top: 30, // Adjust to place the buttons properly
          left: 15,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            iconSize: 28,
            onPressed: () {
              Navigator.pop(context); // Navigate back
            },
          ),
        ),
        Positioned(
          top: 30,
          right: 15,
          child: IconButton(
            icon: const Icon(Icons.bookmark_border),
            color: Colors.white,
            iconSize: 28,
            onPressed: () {
              // Handle bookmark action
            },
          ),
        ),

        // Content inside the card
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Play Trailer Button
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.play_arrow,
                  color: Colors
                      .white, // Icon color (black for contrast with white button)
                ),
                label: const Text(
                  'Play Trailer',
                  style: TextStyle(color: Colors.white), // Text color
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Title
              const Text(
                'The Wild Robot',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              // Description
              const Text(
                'After a shipwreck, an intelligent robot called Roz is stranded '
                'on an uninhabited island. To survive the harsh environment, Roz '
                'bonds with the island\'s animals and cares for an orphaned baby goose.',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            blurRadius: 6, // Blur radius
            offset: const Offset(0, 3), // Offset (x, y)
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Release Date
          Row(
            children: const [
              Icon(Icons.calendar_today, size: 24, color: Colors.black),
              SizedBox(width: 8), // Space between icon and text
              Text(
                '2024',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),

          // Duration
          Row(
            children: const [
              Icon(Icons.access_time, size: 24, color: Colors.black),
              SizedBox(width: 8), // Space between icon and text
              Text(
                '1h 24m',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),

          // Rating
          Row(
            children: const [
              Icon(Icons.movie_filter, size: 24, color: Colors.black),
              SizedBox(width: 8), // Space between icon and text
              Text(
                'PG',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DetailsContainer extends StatelessWidget {
  final int selectedTabIndex;
  final Function(int) onTabSelected;

  const DetailsContainer({
    required this.selectedTabIndex,
    required this.onTabSelected,
    Key? key,
  }) : super(key: key);

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
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          // Content based on selected tab
          if (selectedTabIndex == 0)
            const AboutContent()
          else
            const ReviewContent(),
        ],
      ),
    );
  }
}

class AboutContent extends StatelessWidget {
  const AboutContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Synopsis',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          'Beginning Scene (Movie Version): The movie begins with a factory where the workers '
          'build Rozzum unit 7134, a robot. Roz however wakes up for the very first time to find '
          'that she’s alone on a remote, wild island. Roz doesn’t know how she got there, or where '
          'she came from: she only knows that she wants to stay alive.',
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 20),
        const Text(
          'Genre',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text('Sci-Fi, Animation, Survival'),
        const SizedBox(height: 20),
        const Text(
          'Director',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text('Chris Sanders'),
        const SizedBox(height: 20),
        const Text(
          'Writers',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text('Chris Sanders, Peter Brown'),
        const SizedBox(height: 20),
        const Text(
          'Watch On',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 80, // Tinggi widget untuk scroll horizontal
          child: ListView(
            scrollDirection: Axis.horizontal, // Scrollable ke kanan/kiri
            children: [
              WatchOnItem(
                imagePath: 'assets/images/netflix.png',
                platformName: 'Netflix',
              ),
              const SizedBox(width: 10),
              WatchOnItem(
                imagePath: 'assets/images/disney.png',
                platformName: 'Disney+ Hotstar',
              ),
              const SizedBox(width: 10),
              WatchOnItem(
                imagePath: 'assets/images/viu.png',
                platformName: 'Viu',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Widget for Individual Watch On Items
class WatchOnItem extends StatelessWidget {
  final String imagePath;
  final String platformName;

  const WatchOnItem({
    required this.imagePath,
    required this.platformName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imagePath,
          height: 40,
          width: 40,
        ),
        const SizedBox(height: 5),
        Text(
          platformName,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class ReviewContent extends StatelessWidget {
  const ReviewContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Daftar review dengan data dummy
    final List<Map<String, dynamic>> reviews = [
      {
        'name': 'Alphariz Lotera',
        'rating': 9,
        'comment':
            'It has a wonderful message of tolerance and unity. The voice acting is charming. The animation is very good, stunning at times. I liked the story, though I can see some people feeling it\'s too schmaltzy or corny.',
      },
      {
        'name': 'Lapras Snorly',
        'rating': 10,
        'comment':
            'Chris Sanders comes back right when he’s needed, this animated movie will go down in history not only as one of the greatest animated movies but as one of the greatest films in cinema history.',
      },
      {
        'name': 'Soble Inteleon',
        'rating': 7,
        'comment':
            'The animation was great, yes. Although for me personally, the animals became too overly personified and lost some of their charm once they started speaking.',
      },
      {
        'name': 'Gengar Gastly',
        'rating': 10,
        'comment':
            'Now this film is, at a masterpiece, but in my opinion no film or piece of art can be. In many ways it just serves as an excellently made "kid\'s movie", with nice universal themes and schadenfreude humour.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header: Review and See More Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Review',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                // Handle See More action
              },
              child: const Text(
                'See More',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Review List
        Column(
          children: reviews.map((review) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar Placeholder
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.shade300,
                    child: Text(
                      review['name'][0], // Mengambil huruf pertama dari nama
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12), // Spasi antara avatar dan konten
                  // Review Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama dan Rating
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              review['name'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${review['rating']}/10',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Komentar
                        Text(
                          review['comment'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
