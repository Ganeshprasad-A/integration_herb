
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import for SharedPreferences
import 'package:herbalhub/frontend/assets/database/database_helper.dart';

class HerbDetailsScreen extends StatefulWidget {
  final String herbName;

  const HerbDetailsScreen({required this.herbName, Key? key}) : super(key: key);

  @override
  _HerbDetailsScreenState createState() => _HerbDetailsScreenState();
}

class _HerbDetailsScreenState extends State<HerbDetailsScreen> {
  Map<String, dynamic>? herbData;
  bool isBookmarked = false; // State to track bookmark status

  @override
  void initState() {
    super.initState();
    fetchHerbDetails();
    checkBookmarkStatus(); // Check initial bookmark status
  }

  Future<void> fetchHerbDetails() async {
    final dbHelper = DatabaseHelper();
    final data = await dbHelper.fetchHerb(widget.herbName);

    setState(() {
      herbData = data;
    });
  }

  Future<void> toggleBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarkedHerbs = prefs.getStringList('bookmarkedHerbs') ?? [];

    if (isBookmarked) {
      bookmarkedHerbs.removeWhere((element) =>
          Map<String, dynamic>.from(json.decode(element))['name'] ==
          widget.herbName);
      showToast('Removed from bookmarks');
    } else {
      bookmarkedHerbs.add(json.encode(herbData));
      showToast('Added to bookmarks');
    }

    await prefs.setStringList('bookmarkedHerbs', bookmarkedHerbs);

    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  Future<void> checkBookmarkStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarkedHerbs = prefs.getStringList('bookmarkedHerbs') ?? [];
    setState(() {
      isBookmarked = bookmarkedHerbs.any((element) {
        Map<String, dynamic> herb =
            Map<String, dynamic>.from(json.decode(element));
        return herb['name'] == widget.herbName;
      });
    });
  }

  void showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (herbData == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Loading...'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE7F6D4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7F6D4),
        elevation: 0,
        title: Text(
          herbData!['name'] ?? 'Unknown',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? Colors.green : Colors.black,
            ),
            onPressed: toggleBookmark,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                herbData!['imagePath'] ??
                    'lib/frontend/assets/images/default_image.png',
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Displaying Details
            buildDetailText('Botanical Name', herbData!['botanicalName']),
            buildDetailText('Type', herbData!['type']),
            buildDetailText('Habitat', herbData!['habitat']),
            buildDetailText('Region', herbData!['region']),
            buildDetailText('Parts Usage', herbData!['partsUsage']),
            buildDetailText(
                'Growth Requirements', herbData!['growthRequirements']),
            buildDetailText('Endangered Status', herbData!['endangeredStatus']),
            buildDetailText('Lifespan', herbData!['lifespan']),
            buildDetailText('Medicinal Uses', herbData!['medicinalUses']),
            buildDetailText(
                'Method of Cultivation', herbData!['methodOfCultivation']),
            const SizedBox(height: 16),

            // Short Description
            Text(
              herbData!['shortDescription'] ?? 'Description not available',
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // Explore Button
            ElevatedButton(
              onPressed: () {
                // Handle Explore action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Explore',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailText(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$title: ',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: (value != null && value.toString().isNotEmpty)
                  ? value.toString()
                  : 'N/A',
              style: const TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
