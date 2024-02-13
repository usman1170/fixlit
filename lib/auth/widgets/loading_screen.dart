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
    mycolor = Colors.blue.shade400;
    return Container(
      decoration: BoxDecoration(
        color: mycolor,
        image: const DecorationImage(
          image: AssetImage("assets/imgs/bg3.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
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
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
