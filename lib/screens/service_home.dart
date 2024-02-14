// ignore_for_file: avoid_print

import 'package:fixlit/services/apis.dart';
import 'package:fixlit/widgets/drawers.dart';
import 'package:flutter/material.dart';

class ServiceProviderHome extends StatefulWidget {
  const ServiceProviderHome({super.key});

  @override
  State<ServiceProviderHome> createState() => _ServiceProviderHomeState();
}

class _ServiceProviderHomeState extends State<ServiceProviderHome> {
  @override
  void initState() {
    Services.serviceProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Email in Home = ${Services.serviceProvider.email}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("ServiceProvider"),
      ),
      body: Text(Services.serviceProvider.email),
      drawer: const MyDrawer(),
    );
  }
}
