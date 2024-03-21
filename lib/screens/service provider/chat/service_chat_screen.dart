import 'package:fixlit/screens/service%20provider/image_clip_view.dart';
import 'package:fixlit/services/apis.dart';
import 'package:flutter/material.dart';

class ServiceChatScreen extends StatefulWidget {
  const ServiceChatScreen({super.key});

  @override
  State<ServiceChatScreen> createState() => _ServiceChatScreenState();
}

class _ServiceChatScreenState extends State<ServiceChatScreen> {
  bool homeScreen = false;
  bool inboxScreen = true;
  bool profileScreen = false;

  @override
  Widget build(BuildContext context) {
    final user = Services.serviceProvider;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inbox"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Good Morning!",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      user.name == ""
                          ? "Hey There..."
                          : user.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ImageViewerClip(urlImage: user.image),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),
        ],
      ),
    );
  }
}
