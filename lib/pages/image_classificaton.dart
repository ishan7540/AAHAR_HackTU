import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as devtools;

class PlantDiseaseDetector extends StatefulWidget {
  const PlantDiseaseDetector({super.key});

  @override
  State<PlantDiseaseDetector> createState() => _PlantDiseaseDetectorState();
}

class _PlantDiseaseDetectorState extends State<PlantDiseaseDetector> {
  File? filePath;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image == null) return;
    setState(() {
      filePath = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Diseases Detection',
          style: TextStyle(
              fontFamily: 'Coolvetica',
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
        backgroundColor: Color(0xFF3BB476),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
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
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => pickImage(ImageSource.camera),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Take a Photo"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => pickImage(ImageSource.gallery),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Pick from Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
