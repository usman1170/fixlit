// ignore_for_file: use_build_context_synchronously

import 'package:fixlit/main.dart';
import 'package:fixlit/models/service_provider_model.dart';
import 'package:fixlit/screens/client/chat/client_chat_screen.dart';
import 'package:fixlit/screens/client/service_provider/address_detail_widget.dart';
import 'package:fixlit/screens/client/service_provider/upper_contaier.dart';
import 'package:fixlit/screens/service%20provider/image_clip_view.dart';
import 'package:fixlit/services/apis.dart';
import 'package:fixlit/utils/pallate.dart';
import 'package:fixlit/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServiceProviderDetails extends StatefulWidget {
  const ServiceProviderDetails({super.key, required this.serviceProvider});
  final ServiceProvider serviceProvider;

  @override
  State<ServiceProviderDetails> createState() => _ServiceProviderDetailsState();
}

class _ServiceProviderDetailsState extends State<ServiceProviderDetails> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    final data = widget.serviceProvider;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data.name.toUpperCase(),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    UpperContainerDetails(
                      user: data,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      data.email,
                      style: TextStyle(
                          color: Clrs.mainColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .06,
                      ),
                      height: 55,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () async {
                              await Clipboard.setData(
                                ClipboardData(text: data.phone),
                              ).then(
                                (value) {
                                  Dialogs.showMassage(
                                      context, "Phone no copied to clipboard");
                                },
                              );
                            },
                            child: const Icon(
                              Icons.copy,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                size: 22,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              const Text(
                                ":",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                data.phone,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    AddressDetailsWidget(
                        title: "City", msg: " City ${data.city}, Pakistan   ➤"),
                    const SizedBox(
                      height: 16,
                    ),
                    AddressDetailsWidget(title: "Address", msg: data.address),
                    const SizedBox(
                      height: 16,
                    ),
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 26),
                          child: Text(
                            "Description : ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: mq.width * .05,
                      ),
                      padding: const EdgeInsets.all(
                        14,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Clrs.mainColor,
                        ),
                      ),
                      child: ListView(
                        children: [
                          Text(
                            data.bio,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      height: 50,
                      width: 220,
                      decoration: BoxDecoration(
                        color: Clrs.mainColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Service licence",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: mq.width * .05,
                      ),
                      padding: const EdgeInsets.all(
                        14,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Clrs.mainColor,
                        ),
                      ),
                      child: ImageViewerClip(
                        urlImage: data.license,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .3,
                      ),
                    ),

                    //
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: mq.width * .18,
            child: InkWell(
              onTap: () async {
                await Services.addChatUser(widget.serviceProvider.email);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ClientChatScreen(
                      user: widget.serviceProvider,
                    ),
                  ),
                );
              },
              child: Container(
                height: 55,
                width: mq.width * .64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Clrs.mainColor,
                    Colors.blue.shade900,
                    Colors.blue.shade600,
                  ]),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Start chat with him",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 22,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
