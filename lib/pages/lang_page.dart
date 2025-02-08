// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_gradient_text/flutter_gradient_text.dart';

class Lang_page extends StatefulWidget {
  const Lang_page({super.key});

  @override
  State<Lang_page> createState() => _Lang_pageState();
}

class _Lang_pageState extends State<Lang_page> {
  void Function()? onTap() {
    setState(() {
      Navigator.popAndPushNamed(context, 'welcome');
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3E9E9),
      body: Padding(
        padding: EdgeInsets.only(top: 75, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Language/",
              style: TextStyle(
                  fontSize: 55,
                  fontFamily: 'Inter',
                  letterSpacing: -1.7,
                  height: 1),
            ),
            SizedBox(
              height: 17,
            ),
            Padding(
              padding: const EdgeInsets.only(),
              child: GradientText(
                  Text(
                    "भाषा चुनें",
                    style: TextStyle(
                        fontFamily: 'Devanagri',
                        fontSize: 65,
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
              height: 15,
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.only(left: 5),
                width: 325,
                height: 75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xFF3BB476),
                      width: 3,
                    )),
                child: Row(
                  children: [
                    SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset('lib/images/Asset 1@4x 1.png')),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'हिन्दी',
                      style: TextStyle(
                          fontFamily: 'Devanagri',
                          fontSize: 24,
                          color: Color(0xFF3BB476)),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.only(left: 5),
                width: 325,
                height: 75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xFF3BB476),
                      width: 3,
                    )),
                child: Row(
                  children: [
                    SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset('lib/images/Asset 1@4x 4.png')),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'English',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 24,
                          color: Color(0xFF3BB476)),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.only(left: 5),
                width: 325,
                height: 75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xFF3BB476),
                      width: 3,
                    )),
                child: Row(
                  children: [
                    SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset('lib/images/Asset 1@4x 2.png')),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'ਪੰਜਾਬੀ',
                      style: TextStyle(
                          fontFamily: 'Devanagri',
                          fontSize: 24,
                          color: Color(0xFF3BB476)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
