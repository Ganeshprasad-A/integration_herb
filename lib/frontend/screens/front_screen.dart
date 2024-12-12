import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'herb_details_screen.dart';
// Import CategoriesScreen to allow navigation
import 'package:herbalhub/frontend/screens/categories_screen.dart';

class FrontScreen extends StatefulWidget {
  const FrontScreen({Key? key}) : super(key: key);

  @override
  _FrontScreenState createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  List<String> bookmarkedPlants = [];

  Future<void> toggleBookmark(String plantTitle, String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedBookmarks = prefs.getStringList('bookmarkedHerbs') ?? [];

    final plantData = json.encode({'name': plantTitle, 'imagePath': imagePath});

    if (savedBookmarks.contains(plantData)) {
      savedBookmarks.remove(plantData);
    } else {
      savedBookmarks.add(plantData);
    }

    await prefs.setStringList('bookmarkedHerbs', savedBookmarks);
    setState(() {
      bookmarkedPlants = savedBookmarks;
    });
  }

  bool isBookmarked(String plantTitle, String imagePath) {
    final plantData = json.encode({'name': plantTitle, 'imagePath': imagePath});
    return bookmarkedPlants.contains(plantData);
  }

  @override
  void initState() {
    super.initState();
    fetchBookmarks();
  }

  Future<void> fetchBookmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bookmarkedPlants = prefs.getStringList('bookmarkedHerbs') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7F6D4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7F6D4),
        elevation: 0,
        title: Text(
          'HerbalHub',
          style: GoogleFonts.lexend(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD7E9B9),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search your next herbal discovery...',
                    hintStyle: GoogleFonts.lexend(color: Colors.green[800]),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.green[800]),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CategoriesScreen()),
                        );
                      },
                      child: Icon(Icons.filter_alt, color: Colors.green[800]),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Top Searches Section
              Text(
                'Top Searches',
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildPlantCard(
                      'Aloe Vera',
                      'lib/frontend/assets/images/alo.jpg',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HerbDetailsScreen(herbName: 'Aloe Vera'),
                          ),
                        );
                      },
                    ),
                    buildPlantCard(
                      'Amla',
                      'lib/frontend/assets/images/Amla.jpg',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HerbDetailsScreen(herbName: 'Amla'),
                          ),
                        );
                      },
                    ),
                    buildPlantCard(
                      'Turmeric',
                      'lib/frontend/assets/images/turmeric.jpg',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HerbDetailsScreen(herbName: 'Turmeric'),
                          ),
                        );
                      },
                    ),
                    buildPlantCard(
                      'Fenugreek',
                      'lib/frontend/assets/images/Fenugreek.jpg',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HerbDetailsScreen(herbName: 'Fenugreek'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Recents Section
              Text(
                'Recents',
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildPlantCard(
                      'Kutki',
                      'lib/frontend/assets/images/Kutki.jpg',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HerbDetailsScreen(
                                herbName: 'Kutki (Indian Kudzu)'),
                          ),
                        );
                      },
                    ),
                    buildPlantCard(
                      'Ashwagandha',
                      'lib/frontend/assets/images/Ashwagandha.jpg',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HerbDetailsScreen(herbName: 'Ashwagandha'),
                          ),
                        );
                      },
                    ),
                    buildPlantCard(
                      'Mexican Mint',
                      'lib/frontend/assets/images/Mexican_Mint.jpg',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HerbDetailsScreen(herbName: 'Mexican mint'),
                          ),
                        );
                      },
                    ),
                    buildPlantCard(
                      'Sarpagandha',
                      'lib/frontend/assets/images/Sarpagandha.jpg',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HerbDetailsScreen(herbName: 'Sarpagandha'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Suggestions for You Section
              Text(
                'Suggestions for you',
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              buildPlantCard(
                'Jatamansi',
                'lib/frontend/assets/images/Jatamansi.jpg',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HerbDetailsScreen(herbName: 'Aloe Vera'),
                    ),
                  );
                },
                width: double.infinity,
              ),
              const SizedBox(height: 10),
              buildPlantCard(
                'Brahmi',
                'lib/frontend/assets/images/Brahmi.jpg',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HerbDetailsScreen(herbName: 'Aloe Vera'),
                    ),
                  );
                },
                width: double.infinity,
              ),
              const SizedBox(height: 10),
              buildPlantCard(
                'Henna',
                'lib/frontend/assets/images/Henna.jpg',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HerbDetailsScreen(herbName: 'Aloe Vera'),
                    ),
                  );
                },
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: const Color.fromARGB(255, 27, 69, 29),
        backgroundColor: const Color(0xFFF0F8EE),
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.camera_alt_outlined, color: Colors.white),
          Icon(Icons.local_florist_outlined, color: Colors.white),
          Icon(Icons.bar_chart_outlined, color: Colors.white),
          Icon(Icons.person_outline, color: Colors.white),
        ],
        onTap: (index) {
          // Handle bottom navigation taps if needed
        },
      ),
    );
  }

  Widget buildPlantCard(String title, String imagePath, VoidCallback onTap,
      {double width = 150}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: PlantCard(
          title: title,
          imagePath: imagePath,
          width: width,
        ),
      ),
    );
  }
}

class BookmarkedPlantsScreen extends StatefulWidget {
  const BookmarkedPlantsScreen({Key? key}) : super(key: key);

  @override
  _BookmarkedPlantsScreenState createState() => _BookmarkedPlantsScreenState();
}

class _BookmarkedPlantsScreenState extends State<BookmarkedPlantsScreen> {
  List<Map<String, dynamic>> bookmarkedPlants = [];

  @override
  void initState() {
    super.initState();
    fetchBookmarkedPlants();
  }

  Future<void> fetchBookmarkedPlants() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarkedPlantsJson =
        prefs.getStringList('bookmarkedHerbs') ?? [];

    setState(() {
      bookmarkedPlants = bookmarkedPlantsJson
          .map((e) => Map<String, dynamic>.from(json.decode(e)))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked Plants'),
        backgroundColor: const Color(0xFFE7F6D4),
        elevation: 0,
      ),
      body: bookmarkedPlants.isEmpty
          ? const Center(
              child: Text(
                'No Bookmarked Plants!',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : ListView.builder(
              itemCount: bookmarkedPlants.length,
              itemBuilder: (context, index) {
                final plant = bookmarkedPlants[index];
                return ListTile(
                  leading: plant['imagePath'] != null
                      ? Image.asset(
                          plant['imagePath'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : null,
                  title: Text(
                    plant['name'] ?? 'Unknown Plant',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
    );
  }
}

class PlantCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final double width;

  const PlantCard({
    required this.title,
    required this.imagePath,
    this.width = 150,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.5), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Text(
          title,
          style: GoogleFonts.lexend(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
