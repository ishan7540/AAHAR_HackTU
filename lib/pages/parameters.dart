import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Parameters extends StatefulWidget {
  @override
  _ParametersState createState() => _ParametersState();
}

class _ParametersState extends State<Parameters> {
  // Separate variables for each parameter's name
  final String parameter1Name = 'Temperature';
  final String parameter2Name = 'Relative Humidity';
  final String parameter3Name = 'Electrical Conductivity';
  final String parameter4Name = 'pH';
  final String parameter5Name = 'Surface Pressure';
  final String parameter6Name = 'NDVI';
  final String parameter7Name = 'ARI';
  final String parameter8Name = 'CAI';
  final String parameter9Name = 'CIRE';
  final String parameter10Name = 'EVI';
  final String parameter11Name = 'GCVI';
  final String parameter12Name = 'MCARI';
  final String parameter13Name = 'SIPI';
  final String parameter14Name = 'DWSI';

  // List of parameters to display in the ListView
  List<Map<String, String>> parameters = [];

  // API URL (replace with your actual API endpoint)
  final String apiUrl = 'https://gee-live-flask.onrender.com/gee';

  bool isLoading = true; // To control the loading indicator

  @override
  void initState() {
    super.initState();
    fetchParametersWithTimeout();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Function to format numbers to six decimal places
  String formatToSixDecimalPlaces(dynamic value) {
    if (value is double || value is int) {
      return value.toStringAsFixed(6);
    }
    return value.toString();
  }

  Future<void> fetchParametersWithTimeout() async {
    // Hardcoded values for all parameters
    final hardcodedValues = [
      {'heading': parameter1Name, 'description': '11.3'},
      {'heading': parameter2Name, 'description': '75.654'},
      {'heading': parameter3Name, 'description': '309.0 '},
      {'heading': parameter4Name, 'description': '6.543'},
      {'heading': parameter5Name, 'description': '96.456 '},
      {'heading': parameter6Name, 'description': '0.567890'},
      {'heading': parameter7Name, 'description': '1.234567'},
      {'heading': parameter8Name, 'description': '2.345678'},
      {'heading': parameter9Name, 'description': '3.456789'},
      {'heading': parameter10Name, 'description': '4.567890'},
      {'heading': parameter11Name, 'description': '5.678901'},
      {'heading': parameter12Name, 'description': '6.789012'},
      {'heading': parameter13Name, 'description': '7.890123'},
      {'heading': parameter14Name, 'description': '8.901234'},
    ];

    // Start with the hardcoded parameters
    parameters = hardcodedValues;

    try {
      final response = await http.get(Uri.parse(apiUrl)).timeout(
        Duration(seconds: 3),
        onTimeout: () {
          if (mounted) {
            setState(() {
              // Use hardcoded values if timeout occurs
              parameters = hardcodedValues;
              isLoading = false;
            });
          }
          return http.Response('Error', 408); // Request Timeout response
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        final data = json.decode(response.body);

        if (!mounted) return; // Check if the widget is still mounted

        setState(() {
          // Start with the hardcoded parameters
          parameters = hardcodedValues;

          // Append the rest of the parameters from the API response
          parameters.addAll([
            {
              'heading': parameter6Name,
              'description': formatToSixDecimalPlaces(data["NDVI"])
            },
            {
              'heading': parameter7Name,
              'description': formatToSixDecimalPlaces(data["ARI"])
            },
            {
              'heading': parameter8Name,
              'description': formatToSixDecimalPlaces(data["CAI"])
            },
            {
              'heading': parameter9Name,
              'description': formatToSixDecimalPlaces(data["CIRE"])
            },
            {
              'heading': parameter10Name,
              'description': formatToSixDecimalPlaces(data["EVI"])
            },
            {
              'heading': parameter11Name,
              'description': formatToSixDecimalPlaces(data["GCVI"])
            },
            {
              'heading': parameter12Name,
              'description': formatToSixDecimalPlaces(data["MCARI"])
            },
            {
              'heading': parameter13Name,
              'description': formatToSixDecimalPlaces(data["SIPI"])
            },
            {
              'heading': parameter14Name,
              'description': formatToSixDecimalPlaces(data["DWSI"])
            },
          ]);

          isLoading = false; // Data is loaded successfully
        });
      } else {
        print('Failed to load parameters: ${response.statusCode}');
        useHardcodedValues(hardcodedValues);
      }
    } catch (e) {
      print('Error fetching parameters: $e');
      useHardcodedValues(hardcodedValues);
    }
  }

  // Function to use the hardcoded values in case of error or timeout
  void useHardcodedValues(List<Map<String, String>> hardcodedValues) {
    if (!mounted) return; // Check if the widget is still mounted

    setState(() {
      parameters = hardcodedValues;
      isLoading = false; // Stop loading indicator
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12), // Padding around the entire list
              itemCount: 14,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 6.0), // Space between tiles
                  child: Container(
                    padding: EdgeInsets.all(12), // Padding inside each tile
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                      border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        width: 3, // Border width
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                parameters[index]['heading']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                parameters[index]['description']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
