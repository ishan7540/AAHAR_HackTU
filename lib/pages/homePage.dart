import 'package:flutter/material.dart';
import 'package:rain/components/first_tile.dart';
import 'package:rain/components/sideMenu.dart';
import 'package:rain/components/second_tile.dart';
import 'package:rain/components/third_tile.dart';
import 'package:rain/pages/chatbot.dart';

class Name extends StatelessWidget {
  const Name({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 75),
          child: Image.asset('lib/images/aahar.png', height: 30),
        ),
        backgroundColor: const Color.fromRGBO(59, 180, 118, 1),
      ),
      drawer: sideMenu(),
      body: Container(
        color: const Color.fromRGBO(243, 233, 233, 1),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FirstTile(),
                SecondTile(),
                thirdTile(),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to chatbot or trigger chatbot function
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatBOT()),
          );
        },
        backgroundColor: const Color.fromRGBO(
            59, 180, 118, 1), // Match AppBar color for consistency
        child: Image.asset(
          'lib/images/chatbot.png',
          height: 40,
          width: 40,
        ), // Chat icon
      ),
    );
  }
}
