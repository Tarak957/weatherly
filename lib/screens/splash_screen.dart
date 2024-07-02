import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherly/screens/mainscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () {
        Get.off(() => const MainScreen());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5),
                      color: Colors.lightBlue[200],
                    ),
                    padding: const EdgeInsets.all(60),
                    height: size.height / 2,
                    width: size.width / 2,
                    child: Image.asset(
                      'assets/images/thunderstorm.png',
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5),
                      color: Colors.orange[200],
                    ),
                    padding: const EdgeInsets.all(60),
                    height: size.height / 2,
                    width: size.width / 2,
                    child: Image.asset(
                      'assets/images/cloudy-day.png',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5),
                      color: Colors.grey[300],
                    ),
                    padding: const EdgeInsets.all(60),
                    height: size.height / 2,
                    width: size.width / 2,
                    child: Image.asset(
                      'assets/images/snowflake.png',
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5),
                      color: Colors.green,
                    ),
                    padding: const EdgeInsets.all(60),
                    height: size.height / 2,
                    width: size.width / 2,
                    child: Image.asset(
                      'assets/images/wind.png',
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: (size.height / 2) - 40,
            left: (size.width / 2) - 100,
            child: Container(
              height: 80,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(width: 3),
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(90), right: Radius.circular(90)),
                color: Colors.white,
              ),
              child: Center(
                child: AnimatedTextKit(
                  animatedTexts: [
                    FlickerAnimatedText(
                      'Weatherly',
                      textStyle: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
