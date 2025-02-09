import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlantDiseaseDetector extends StatefulWidget {
  const PlantDiseaseDetector({super.key});

  @override
  State<PlantDiseaseDetector> createState() => _PlantDiseaseDetectorState();
}

class _PlantDiseaseDetectorState extends State<PlantDiseaseDetector> {
  File? filePath;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  String result = "";
  String confidence = "";
  String fertilizer = "";
  String treatment = "";

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image == null) return;
    setState(() {
      filePath = File(image.path);
      result = ""; // Clear previous result
    });
    await uploadImage();
  }

  Future<void> uploadImage() async {
    if (filePath == null) return;

    setState(() {
      isLoading = true;
    });

    var request = http.MultipartRequest(
        'POST', Uri.parse("https://diseasedetectionrend.onrender.com/predict"));
    request.files
        .add(await http.MultipartFile.fromPath('file', filePath!.path));

    try {
      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseData);

      setState(() {
        result = jsonResponse["prediction"];
        confidence = jsonResponse["confidence"];
        fertilizer = jsonResponse["fertilizer"];
        treatment = jsonResponse["treatment"];
      });
    } catch (e) {
      setState(() {
        result = "Error: Failed to connect to server!";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildResultCard(
      String title, String value, IconData icon, Color color) {
    if (value.isEmpty) return const SizedBox();

    return SizedBox(
      width: 350,
      height: 160,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 5),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Disease Detection',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Color.fromRGBO(59, 180, 118, 1),
      ),
      body: Container(
        width: double.infinity, // Ensures full width
        height: double.infinity, // Ensures full height
        color: Color.fromRGBO(243, 233, 233, 1), // Light green background
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20), // Adds spacing below AppBar
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => pickImage(ImageSource.camera),
                  child: Card(
                    elevation: 10,
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        image: filePath == null
                            ? const DecorationImage(
                                image: AssetImage('assets/upload.jpg'),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: filePath != null
                          ? Image.file(filePath!, fit: BoxFit.cover)
                          : const SizedBox(),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => pickImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      label: const Text("Take a Photo",
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () => pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.image, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[500],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      label: const Text("Pick from Gallery",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                isLoading
                    ? const CircularProgressIndicator()
                    : Column(
                        children: [
                          buildResultCard(
                              "Prediction", result, Icons.eco, Colors.green),
                          buildResultCard("Confidence", confidence,
                              Icons.bar_chart, Colors.blue),
                          buildResultCard("Fertilizer", fertilizer,
                              Icons.agriculture, Colors.orange),
                          buildResultCard("Treatment", treatment,
                              Icons.medical_services, Colors.red),
                          const SizedBox(height: 200),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
