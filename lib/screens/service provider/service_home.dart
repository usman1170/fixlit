// ignore_for_file: avoid_print
import 'dart:async';
import 'package:fixlit/screens/service%20provider/image_clip_view.dart';
import 'package:fixlit/screens/service%20provider/license.dart';
import 'package:fixlit/services/apis.dart';
import 'package:fixlit/utils/pallate.dart';
import 'package:fixlit/widgets/animated_text_and_method.dart';
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
    Timer(const Duration(seconds: 2), () {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Services.serviceProvider;
    print(user.id);
    return Scaffold(
      appBar: AppBar(
        title: const Text("ServiceProvider"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
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
                      child: ImageViewerClip(
                        urlImage: user.image,
                        height: 55,
                        width: 55,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              AnimatedContainer(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .03),
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: user.available
                        ? LinearGradient(colors: [
                            Clrs.mainColor,
                            Colors.blue.shade600,
                            Colors.blue.shade500,
                          ])
                        : LinearGradient(
                            colors: [
                              Colors.blue.shade500,
                              Colors.blue.shade600,
                              Clrs.mainColor,
                            ],
                          )),
                child: SwitchListTile(
                  title: Text(
                    user.available == true ? 'Available' : 'Not Available',
                    style: const TextStyle(color: Colors.white),
                  ),
                  value: user.available,
                  onChanged: (newValue) {
                    setState(() {
                      user.available = newValue;
                    });
                    Services.updateStatus(user.available);
                  },
                  activeColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey[400],
                  secondary: Icon(
                    user.available == true ? Icons.check_circle : Icons.cancel,
                    color: user.available == true
                        ? Colors.green.shade200
                        : Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const MethodWidget(),
              const SizedBox(
                height: 20,
              ),
              if (user.city == "" ||
                  user.address == "" ||
                  user.phone == "" ||
                  user.bio == "")
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red.withOpacity(.3),
                    border: Border.all(color: Colors.red),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.black87,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "Please update your profile e.g city, \naddress, phone no and bio etc for better\nclient experience",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              if (user.city != "" &&
                  user.address != "" &&
                  user.phone != "" &&
                  user.bio != "")
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green.withOpacity(.3),
                    border: Border.all(color: Colors.green),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.black87,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "Profile updated successfully, Thank you",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
            ],
          ),
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width * .2,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LicenseScreen(
                        serviceProvider: user,
                      ),
                    ));
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 52,
                width: MediaQuery.of(context).size.width * .6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Clrs.mainColor,
                    Colors.blue.shade600,
                  ]),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Update yor license",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      drawer: const MyDrawer(),
    );
  }
}
