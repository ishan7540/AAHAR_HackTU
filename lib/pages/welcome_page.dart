// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_gradient_text/flutter_gradient_text.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  void Function()? verif() {
    setState(() {
      Navigator.pushNamed(context, 'login');
    });
    return null;
  }

  void Function()? onTap() {
    setState(() {
      Navigator.popAndPushNamed(context, 'language');
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3E9E9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(children: [
                Icon(
                  Icons.translate_outlined,
                  color: Colors.black,
                ),
                Text(
                  "Languages",
                  style: TextStyle(color: Colors.black, fontFamily: 'Inter'),
                )
              ]),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 0),
            child: SizedBox(
                height: 106,
                width: 195,
                child: Image.asset(
                  'lib/images/aahar-line.png',
                  fit: BoxFit.contain,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: SizedBox(
              height: 230,
              width: 230,
              child: Image.asset(
                'lib/images/Asset 2@4x 2.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            child: Text(
              "Welcome to the",
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Inter', fontSize: 32),
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: GradientText(
                    Text(
                      "        AAHAR",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.black,
                          fontSize: 32,
                          shadows: [
                            BoxShadow(
                              color: Colors.black.withOpacity(1),
                              offset: Offset(0, 0),
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                            )
                          ]),
                    ),
                    colors: [Colors.green, Colors.white, Colors.orange]),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                "App",
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.black,
                  fontSize: 32,
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: verif,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFF3BB476),
                  borderRadius: BorderRadius.circular(10)),
              width: 275,
              height: 50,
              child: Center(
                  child: Text(
                "Login",
                style: TextStyle(
                    fontFamily: 'Inter', fontSize: 24, color: Colors.white),
              )),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {},
            child: Center(
              child: Text(
                "Create New Account",
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Inter', fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            height: 45,
          ),
          Text(
            "By continuing, you accept Terms & Conditions",
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
