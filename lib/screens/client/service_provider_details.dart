import 'package:fixlit/models/service_provider_model.dart';
import 'package:flutter/material.dart';

class ServiceProviderDetails extends StatefulWidget {
  const ServiceProviderDetails({super.key, required this.serviceProvider});
  final ServiceProvider serviceProvider;

  @override
  State<ServiceProviderDetails> createState() => _ServiceProviderDetailsState();
}

class _ServiceProviderDetailsState extends State<ServiceProviderDetails> {
  @override
  Widget build(BuildContext context) {
    final data = widget.serviceProvider;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data.name.toUpperCase(),
        ),
        centerTitle: true,
      ),
    );
  }
}
