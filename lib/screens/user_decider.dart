import 'package:fixlit/auth/login.dart';
import 'package:fixlit/screens/service_home.dart';
import 'package:fixlit/screens/user_home.dart';
import 'package:fixlit/services/apis.dart';
import 'package:flutter/material.dart';

class UserDeciderScreen extends StatefulWidget {
  const UserDeciderScreen({super.key});

  @override
  State<UserDeciderScreen> createState() => _UserDeciderScreenState();
}

class _UserDeciderScreenState extends State<UserDeciderScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Services.getMyProfile(),
      builder: (context, snapshot) {
        print("${Services.me.email}");
        if (Services.me.role == "serviceProvider") {
          return const ServiceProviderHome();
        } else if (Services.me.role == "user") {
          return const UserHomeScreen();
        } else {
          return const UserLoginScreen();
        }
      },
    );
  }
}
