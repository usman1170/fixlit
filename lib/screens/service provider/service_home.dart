// ignore_for_file: avoid_print
import 'dart:async';
import 'package:fixlit/main.dart';
import 'package:fixlit/screens/service%20provider/image_clip_view.dart';
import 'package:fixlit/services/apis.dart';
import 'package:fixlit/widgets/animated_text_and_method.dart';
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
      // appBar: AppBar(
      //   title: const Text("ServiceProvider"),
      //   centerTitle: true,
      // ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 28),
                decoration: const BoxDecoration(
                  color: darkColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            ImageViewerClip(
                                urlImage: user.image, height: 48, width: 48),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Good Morning!",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade100,
                                  ),
                                ),
                                Text(
                                  user.name == ""
                                      ? "Hey There..."
                                      : user.name.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade100,
                                    letterSpacing: .4,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Switch(
                            activeColor: Colors.white,
                            activeTrackColor: Colors.green.shade400,
                            inactiveTrackColor: Colors.white,
                            value: user.available,
                            onChanged: (newValue) {
                              setState(() {
                                user.available = newValue;
                              });
                              Services.updateStatus(user.available);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Container(
                      //   padding: const EdgeInsets.symmetric(horizontal: 22),
                      //   height: 60,
                      //   width: MediaQuery.of(context).size.width,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           const Text(
                      //             "Good Morning!",
                      //             style: TextStyle(
                      //               fontWeight: FontWeight.w500,
                      //               fontSize: 16,
                      //             ),
                      //           ),
                      //           Text(
                      //             user.name == ""
                      //                 ? "Hey There..."
                      //                 : user.name.toUpperCase(),
                      //             style: const TextStyle(
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.w600,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.only(right: 8),
                      //         child: ImageViewerClip(
                      //           urlImage: user.image,
                      //           height: 55,
                      //           width: 55,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      if (user.city == "" ||
                          user.address == "" ||
                          user.phone == "" ||
                          user.bio == "")
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 14),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
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
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      // if (user.city != "" &&
                      //     user.address != "" &&
                      //     user.phone != "" &&
                      //     user.bio != "")
                      //   Container(
                      //     margin: const EdgeInsets.symmetric(horizontal: 14),
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 14, vertical: 12),
                      //     width: MediaQuery.of(context).size.width,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(20),
                      //       color: Colors.green.withOpacity(.3),
                      //       border: Border.all(color: Colors.green),
                      //     ),
                      //     child: const Row(
                      //       children: [
                      //         Icon(
                      //           Icons.check_circle_outline,
                      //           color: Colors.black87,
                      //         ),
                      //         SizedBox(
                      //           width: 12,
                      //         ),
                      //         Text(
                      //           "Your Profile is updated, Thank you",
                      //           style: TextStyle(fontWeight: FontWeight.w500),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      const SizedBox(
                        height: 16,
                      ),
                      // AnimatedContainer(
                      //   margin: EdgeInsets.symmetric(
                      //       horizontal: MediaQuery.of(context).size.width * .03),
                      //   duration: const Duration(milliseconds: 300),
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(30),
                      //       gradient: user.available
                      //           ? LinearGradient(colors: [
                      //               darkColor,
                      //               darkColor.shade600,
                      //               darkColor.shade500,
                      //             ])
                      //           : LinearGradient(
                      //               colors: [
                      //                 darkColor.shade500,
                      //                 darkColor.shade600,
                      //                 darkColor,
                      //               ],
                      //             )),
                      //   child: SwitchListTile(
                      //     title: Text(
                      //       user.available == true
                      //           ? 'Available'
                      //           : 'Not Available',
                      //       style: const TextStyle(color: Colors.white),
                      //     ),
                      //     value: user.available,
                      //     onChanged: (newValue) {
                      //       setState(() {
                      //         user.available = newValue;
                      //       });
                      //       Services.updateStatus(user.available);
                      //     },
                      //     activeColor: Colors.white,
                      //     inactiveThumbColor: Colors.white,
                      //     inactiveTrackColor: Colors.grey[400],
                      //     secondary: Icon(
                      //       user.available == true
                      //           ? Icons.check_circle
                      //           : Icons.cancel,
                      //       color: user.available == true
                      //           ? Colors.green.shade200
                      //           : Colors.white,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 25,
                      // ),
                      // const MethodWidget(),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Welcome",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: "roboto",
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    DotWidget(),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text("Welcome to Home Service Provider"),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                VerticalSpacer(),
                                SizedBox(
                                  height: 1,
                                ),
                                Row(
                                  children: [
                                    DotWidget(),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text("Update status according to schedule"),
                                  ],
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                VerticalSpacer(),
                                SizedBox(
                                  height: 1,
                                ),
                                Row(
                                  children: [
                                    DotWidget(),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text("Check your availablity status daily"),
                                  ],
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                VerticalSpacer(),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    DotWidget(),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text("Share with your friends FixLit Hub"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 16),
                        decoration: BoxDecoration(
                          color: yellowColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Customer Care",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                        // color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  "Ensure you are dressed in clean, professional attire and arrive on time for the scheduled appointment.\n\nGreet the customer warmly, introduce yourself, and confirm the details of the service request before starting any work.\n\nBe mindful of the customer's property and personal space. Wear shoe covers or remove shoes if requested.\n\nExplain the service process clearly and answer any questions the customer may have. Keep the customer informed of progress andany issues that arise.",
                                  style: TextStyle(
                                      // color: Colors.white
                                      ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Positioned(
          //   bottom: 10,
          //   left: MediaQuery.of(context).size.width * .2,
          //   child: InkWell(
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => LicenseScreen(
          //               serviceProvider: user,
          //             ),
          //           ));
          //     },
          //     child: Container(
          //       padding: const EdgeInsets.all(8),
          //       height: 52,
          //       width: MediaQuery.of(context).size.width * .6,
          //       decoration: BoxDecoration(
          //         gradient: LinearGradient(colors: [
          //           darkColor,
          //           darkColor.shade600,
          //         ]),
          //         borderRadius: BorderRadius.circular(30),
          //       ),
          //       child: const Center(
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Text(
          //               "Update yor license",
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 14.5,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //             SizedBox(
          //               width: 8,
          //             ),
          //             Icon(
          //               Icons.arrow_forward,
          //               color: Colors.white,
          //               size: 20,
          //             )
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
