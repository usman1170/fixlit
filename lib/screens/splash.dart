import 'dart:async';

import 'package:fixlit/main.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BuilderScreen(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/icon/playstore.png"),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "FixLit Hub",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: darkColor,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 75,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Container(
          margin: const EdgeInsets.only(left: 12, right: 12, bottom: 18),
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black12.withOpacity(.3),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Powered by",
                  style: TextStyle(
                    fontSize: 16,
                    color: darkColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  "SyncEX",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
