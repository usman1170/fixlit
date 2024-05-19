import 'package:fixlit/main.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late Color mycolor;
  @override
  Widget build(BuildContext context) {
    mycolor = darkColor;
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage('assets/icon/playstore.png'),
            ),
            SizedBox(height: 30),
            Text(
              'Please wait...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: darkColor,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                darkColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
