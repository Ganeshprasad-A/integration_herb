import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/plant_model.dart';
import 'plant_detail_screen.dart';

class PlantListScreen extends StatefulWidget {
  const PlantListScreen({Key? key}) : super(key: key);

  @override
  _PlantListScreenState createState() => _PlantListScreenState();
}

class _PlantListScreenState extends State<PlantListScreen> {
  late Future<List<Plant>> _plantsFuture;

  @override
  void initState() {
    super.initState();
    _plantsFuture = fetchPlants(); // Fetch plants on initialization
  }

  Future<List<Plant>> fetchPlants() async {
  const apiUrl = 'http://10.21.208.158:3000'; // Replace with your backend URL
  try {
    final response = await http.get(Uri.parse('$apiUrl/plants')).timeout(
      const Duration(seconds: 10), // Set a timeout for the request
    );

    if (response.statusCode == 200) {
      print('Response body: ${response.body}'); // Debug log for response body
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Plant.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load plants. Status Code: ${response.statusCode}');
    }
  } on Exception catch (e) {
    throw Exception('Error fetching plants: $e');
  }
}
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Medicinal Plants"),
      centerTitle: true,
      backgroundColor: Colors.green.shade700,
    ),
    body: FutureBuilder<List<Plant>>(
      future: _plantsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              "No plants available",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        final plants = snapshot.data!;
        return ListView.builder(
          itemCount: plants.length,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          itemBuilder: (context, index) {
            final plant = plants[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    plant.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error, size: 50, color: Colors.red),
                  ),
                ),
                title: Text(
                  plant.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plant.botanicalName,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (plant.audioUrl.isNotEmpty)
                          const Icon(Icons.audiotrack, size: 18, color: Colors.blue),
                        const SizedBox(width: 4),
                        if (plant.videoUrl.isNotEmpty)
                          const Icon(Icons.videocam, size: 18, color: Colors.red),
                        const SizedBox(width: 4),
                        if (plant.modelUrl.isNotEmpty)
                          const Icon(Icons.threed_rotation, size: 18, color: Colors.green),
                      ],
                    ),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlantDetailScreen(plantName:plant.name),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    ),
  );
}
}