// ignore_for_file: avoid_print

import 'package:fixlit/auth/screens/login.dart';
import 'package:fixlit/screens/client/client_bottom_navigation_bar.dart';
import 'package:fixlit/screens/service%20provider/service_bottom_bar.dart';
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
        if (Services.me.role == "client") {
          return const ClientBottomNavigationBar();
        } else if (Services.me.role == "serviceProvider") {
          return const ServiceBottomNavigationBar();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
//serviceProvider