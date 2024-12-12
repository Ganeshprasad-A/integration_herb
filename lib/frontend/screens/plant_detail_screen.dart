import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PlantDetailScreen extends StatefulWidget {
  final String plantName; // Accept only plantName

  const PlantDetailScreen({Key? key, required this.plantName}) : super(key: key);

  @override
  State<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  late VideoPlayerController _videoController;
  late AudioPlayer _audioPlayer;
  bool _isPlayingAudio = false;
  Map<String, dynamic>? plant; // Store plant details
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    fetchPlantDetails();
  }

  void fetchPlantDetails() async {
    const apiUrl = 'http://10.21.208.158:3000/plants'; // Replace with your backend URL
    try {
      final response = await http.get(Uri.parse('$apiUrl?name=${widget.plantName}'));
      if (response.statusCode == 200) {
        setState(() {
          plant = json.decode(response.body); // Store plant details
          isLoading = false;

          // Initialize video controller with fetched video URL
          _videoController = VideoPlayerController.network(plant!['videoUrl'])
            ..initialize().then((_) {
              setState(() {});
            });

          // Initialize audio player
          _audioPlayer = AudioPlayer();
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Error: Failed to fetch plant details');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Loading..."),
          backgroundColor: Colors.green.shade900,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (plant == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
          backgroundColor: Colors.green.shade900,
        ),
        body: const Center(child: Text("Plant details not found.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(plant!['name']),
        centerTitle: true,
        backgroundColor: Colors.green.shade900,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Plant Image
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              plant!['imageUrl'],
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Text("No image available."),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          // Plant Description
          Text(
            plant!['description'],
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16,
                  height: 1.5,
                ),
            textAlign: TextAlign.justify,
          ),
          const Divider(height: 32, color: Colors.green),

          // 3D Model Section
          if (plant!['modelUrl'] != null && plant!['modelUrl'].endsWith('.glb'))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "3D Model:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green.shade900),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ModelViewer(
                    src: plant!['modelUrl'],
                    alt: "A 3D model of ${plant!['name']}",
                    ar: false,
                    autoRotate: true,
                    cameraControls: true,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16.0),

          // Video Section
          if (_videoController.value.isInitialized)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Video:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        _videoController.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_videoController.value.isPlaying) {
                            _videoController.pause();
                          } else {
                            _videoController.play();
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.stop),
                      color: Colors.red,
                      onPressed: () {
                        setState(() {
                          _videoController.pause();
                          _videoController.seekTo(Duration.zero);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          const Divider(height: 32, color: Colors.green),

          // Audio Section
          if (plant!['audioUrl'] != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Audio:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        _isPlayingAudio ? Icons.pause : Icons.play_arrow,
                        color: Colors.blue,
                      ),
                      onPressed: () async {
                        setState(() {
                          if (_isPlayingAudio) {
                            _audioPlayer.pause();
                          } else {
                            _audioPlayer.play(UrlSource(plant!['audioUrl']));
                          }
                          _isPlayingAudio = !_isPlayingAudio;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.stop, color: Colors.red),
                      onPressed: () {
                        _audioPlayer.stop();
                        setState(() {
                          _isPlayingAudio = false;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          const Divider(height: 32, color: Colors.green),
        ],
      ),
    );
  }
}
