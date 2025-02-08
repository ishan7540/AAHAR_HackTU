import 'package:flutter/material.dart';
import 'package:rain/components/bar_chart.dart';
import 'package:rain/pages/parameters.dart';

class NpkPage extends StatefulWidget {
  const NpkPage({super.key});

  @override
  _NpkPageState createState() => _NpkPageState();
}

class _NpkPageState extends State<NpkPage> {
  // Current values from the provided code
  final double currentN = 248;
  final double currentP = 78;
  final double currentK = 84;

  // Optimal values from the provided code
  final double optimalN = 282;
  final double optimalP = 83;
  final double optimalK = 70;

  String ureaResult = '';
  String dapResult = '';
  String mopResult = '';

  bool isLoading = true; // Start with loading

  @override
  void initState() {
    super.initState();
    // Simulate initial loading time
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false; // Hide loading indicator after 2 seconds
      });
    });
  }

  Future<void> calculateFertilizers() async {
    setState(() {
      isLoading = true; // Show loading indicator when calculating
    });

    // Simulate a loading time of 2 seconds
    await Future.delayed(Duration(seconds: 2));

    // Calculate the fertilizer requirement in kg/acre
    double nitrogenDifference =
        ((optimalN - currentN) * 1300 * 0.15) / (100 * 2.47);
    double phosphorusDifference =
        ((optimalP - currentP) * 1300 * 0.15) / (100 * 2.47);
    double potassiumDifference =
        ((optimalK - currentK) * 1300 * 0.15) / (100 * 2.47);

    // Calculate DAP requirement based on Phosphorus
    double dapRequired = phosphorusDifference / 0.46;
    double nitrogenFromDAP = dapRequired * 0.18;

    // Calculate Urea requirement based on remaining Nitrogen
    double nitrogenNeededFromUrea = nitrogenDifference - nitrogenFromDAP;
    double ureaRequired = nitrogenNeededFromUrea / 0.46;

    // Calculate MOP requirement based on Potassium
    double mopRequired = potassiumDifference / 0.60;

    // Check for excess or deficiency
    ureaResult = nitrogenNeededFromUrea > 0
        ? 'Add ${ureaRequired.toStringAsFixed(2)} kg/acre of Urea'
        : '${(-ureaRequired).toStringAsFixed(2)} kg/acre of Urea is in excess';

    dapResult = phosphorusDifference > 0
        ? 'Add ${dapRequired.toStringAsFixed(2)} kg/acre of DAP'
        : '${(-dapRequired).toStringAsFixed(2)} kg/acre of DAP is in excess';

    mopResult = potassiumDifference > 0
        ? 'Add ${mopRequired.toStringAsFixed(2)} kg/acre of MOP'
        : '${(-mopRequired).toStringAsFixed(2)} kg/acre of MOP is in excess';

    setState(() {
      isLoading = false; // Hide loading indicator after calculations
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(243, 233, 233, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(59, 180, 118, 1),
          title: const Text(
            'Your Field',
            style: TextStyle(
              fontFamily: "Coolvetica",
              fontSize: 30,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.grass_rounded),
              ),
              Tab(
                icon: Icon(Icons.bar_chart_sharp),
              ),
            ],
            unselectedLabelColor: Colors.white,
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              children: [
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 250,
                          width: 360,
                          child: NutrientBarChart(),
                        ),
                        SizedBox(
                          width: 360,
                          height: 100,
                          child: Card(
                            color: const Color.fromARGB(255, 137, 199, 250),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(
                                color: Colors.black,
                                width: 3,
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 8),
                                    Text(
                                      ' 250',
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontFamily: 'Coolvetica'),
                                    ),
                                    Text(
                                      'Nitrogen',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Coolvetica'),
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  width: 2,
                                  indent: 10,
                                  endIndent: 10,
                                  color: Colors.black,
                                ),
                                Column(
                                  children: [
                                    SizedBox(height: 8),
                                    Text(
                                      ' 78',
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontFamily: 'Coolvetica'),
                                    ),
                                    Text(
                                      'Phosphorus',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Coolvetica'),
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  width: 2,
                                  indent: 10,
                                  endIndent: 10,
                                  color: Colors.black,
                                ),
                                Column(
                                  children: [
                                    SizedBox(height: 8),
                                    Text(
                                      ' 84',
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontFamily: 'Coolvetica'),
                                    ),
                                    Text(
                                      'Potassium',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Coolvetica'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 360,
                          height: 100,
                          child: Card(
                            color: const Color.fromARGB(255, 143, 231, 146),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(
                                color: Colors.black,
                                width: 3,
                              ),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 8),
                                    Text(
                                      ' 282',
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontFamily: 'Coolvetica'),
                                    ),
                                    Text(
                                      'Nitrogen',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Coolvetica'),
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  width: 2,
                                  indent: 10,
                                  endIndent: 10,
                                  color: Colors.black,
                                ),
                                Column(
                                  children: [
                                    SizedBox(height: 8),
                                    Text(
                                      ' 83',
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontFamily: 'Coolvetica'),
                                    ),
                                    Text(
                                      'Phosphorus',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Coolvetica'),
                                    ),
                                  ],
                                ),
                                VerticalDivider(
                                  width: 2,
                                  indent: 10,
                                  endIndent: 10,
                                  color: Colors.black,
                                ),
                                Column(
                                  children: [
                                    SizedBox(height: 8),
                                    Text(
                                      ' 70',
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontFamily: 'Coolvetica'),
                                    ),
                                    Text(
                                      'Potassium',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Coolvetica'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Prevent unintended back navigation
                            FocusScope.of(context).unfocus();
                            calculateFertilizers();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors
                                .white, // Sets the background color to white
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                12,
                              ), // Sets the border radius to 12
                            ),
                          ),
                          child: const Text(
                            'Calculate Fertilizer Requirements',
                            style: TextStyle(
                              fontFamily: "Coolvetica",
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Display the fertilizer results
                        if (ureaResult.isNotEmpty ||
                            dapResult.isNotEmpty ||
                            mopResult.isNotEmpty)
                          Column(
                            children: [
                              Text(
                                ureaResult,
                                style: const TextStyle(
                                    fontSize: 18, fontFamily: "Coolvetica"),
                              ),
                              Text(
                                dapResult,
                                style: const TextStyle(
                                    fontSize: 18, fontFamily: "Coolvetica"),
                              ),
                              Text(
                                mopResult,
                                style: const TextStyle(
                                    fontSize: 18, fontFamily: "Coolvetica"),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                Parameters(),
              ],
            ),
            if (isLoading)
              Container(
                color:
                    Colors.white.withOpacity(1), // Semi-transparent background
                child: Center(
                  child: CircularProgressIndicator(), // Loading spinner
                ),
              ),
          ],
        ),
      ),
    );
  }
}
