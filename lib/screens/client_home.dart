import 'package:fixlit/services/apis.dart';
import 'package:fixlit/widgets/drawers.dart';
import 'package:flutter/material.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  @override
  void initState() {
    Services.clientProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Client"),
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: Text(Services.client.email),
      ),
    );
  }
}
