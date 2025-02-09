import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rain/models/InfoDialog.dart'; // Import the custom widget

// Model class for crop rotation
class CropRotation {
  final String name;
  final String details;

  CropRotation({required this.name, required this.details});

  factory CropRotation.fromJson(Map<String, dynamic> json) {
    return CropRotation(
      name: json['name'],
      details: json['details'],
    );
  }
}

// Service class to fetch data from Google Custom Search
class CropRotationService {
  final String apiKey = 'YOUR_API_KEY'; // Replace with your API Key
  final String searchEngineId = 'YOUR_CSE_ID'; // Replace with your CSE ID

  Future<String> fetchCropRotationDetails(String query) async {
    final url =
        'https://www.googleapis.com/customsearch/v1?q=$query&key=$apiKey&cx=$searchEngineId';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['items'] != null && data['items'].isNotEmpty) {
        // Extract and return the first relevant result
        return data['items'][0]['snippet'] ?? 'No details available';
      } else {
        return 'No results found';
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}

// Model class for the vegetable (crop rotation)
class vege {
  String name;
  String description; // Add description
  bool isFollowedByMe;

  vege(this.name, this.description, this.isFollowedByMe);
}

class cropROTATE extends StatefulWidget {
  const cropROTATE({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<cropROTATE> {
  List<vege> _users = [
    vege("Colocasia - Radish - French bean", '', false),
    vege("Brinjal - Vegetable pea - Chilli", '', false),
    vege("Sponge gourd - Palak - Brinjal", '', false),
    vege("Okra - Tomato - Amaranth", '', false),
    vege("Cowpea - Cauliflower - Okra", '', false),
    vege("Paddy - Potato - Tomato", '', false),
    vege("Okra - Carrot - Bitter gourd", '', false),
    vege("Round melon - Radish - Onion", '', false),
    vege("Okra - Tomato - French bean", '', false),
    vege("Tomato - French bean - Okra", '', false),
    vege("Brinjal - Cauliflower - Chilli", '', false),
    vege("Cowpea - Cauliflower - Okra", '', false),
    vege("Paddy - Tomato - Bitter gourd", '', false),
    vege(
        "Okra - Vegetable pea - Onion",
        "Year 1: Okra\n"
            "Okra is a warm-season crop that can be a good choice for the first year in a rotation. Its deep roots can help improve soil structure.\n\n"
            "Year 2: Vegetable Pea\n"
            "Peas are a cool-season legume that can benefit from the improved soil conditions created by okra. They can help fix nitrogen into the soil, which can be beneficial for subsequent crops.\n\n"
            "Year 3: Onion\n"
            "Onions are a cool-season crop that can thrive in the soil conditions improved by okra and peas. They are often grown in rotation with other crops to help prevent disease buildup.",
        false),
    vege("Maize - Potato - Okra", '', false),
    vege("Brinjal - Vegetable pea - Chilli", '', false),
    vege("Okra - Tomato - Bitter gourd", '', false),
    vege("Bottle gourd - Vegetable pea - Tomato", '', false),
    vege("Cowpea - Cauliflower - Onion", '', false),
    vege("Paddy - Radish - Onion", '', false),
    vege("Maize - Potato - Onion", '', false),
    vege("Paddy - Potato - Onion", '', false),
    vege("Maize - Potato - Okra", '', false),
    vege("Okra - Tomato - Okra", '', false),
  ];

  List<vege> _foundedUsers = [];
  TextEditingController _searchController = TextEditingController();
  final CropRotationService _cropRotationService = CropRotationService();

  @override
  void initState() {
    super.initState();
    setState(() {
      _foundedUsers = _users;
    });
  }

  void onSearch(String search) {
    setState(() {
      _foundedUsers = _users.where((vege) {
        List<String> crops = vege.name.split(' - ');
        return crops[0].toLowerCase().contains(search.toLowerCase());
      }).toList();
    });
  }

  void clearSearch() {
    _searchController.clear();
    setState(() {
      _foundedUsers = _users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3BB476),
      body: Padding(
        padding: const EdgeInsets.only(top: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Crop rotation Guide",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => onSearch(value),
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey.shade600),
                          onPressed: clearSearch,
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                  hintText: "Search crop rotations",
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: _foundedUsers.isNotEmpty
                    ? ListView.builder(
                        itemCount: _foundedUsers.length,
                        padding: const EdgeInsets.only(top: 8),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: userComponent(
                              vege: _foundedUsers[index],
                              context: context,
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          "No crop rotations found",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userComponent({required vege vege, required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vege.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          InfoDialog(content: vege.description), // Use the custom widget
        ],
      ),
    );
  }
}
