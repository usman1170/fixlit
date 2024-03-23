import 'package:fixlit/models/client_model.dart';
import 'package:fixlit/screens/service%20provider/chat/service_caht_user_card.dart';
import 'package:fixlit/screens/service%20provider/service_main_header.dart';
import 'package:fixlit/services/apis.dart';
import 'package:flutter/material.dart';

class ServiceInbox extends StatefulWidget {
  const ServiceInbox({super.key});

  @override
  State<ServiceInbox> createState() => _ServiceInboxState();
}

class _ServiceInboxState extends State<ServiceInbox> {
  List<ClientModel> list = [];
  bool homeScreen = false;
  bool inboxScreen = true;
  bool profileScreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ServiceCustomAppBar(
            btn: false,
          ),
          Expanded(
            child: StreamBuilder(
                stream: Services.getServiceMyUsers(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.active:
                    case ConnectionState.done:
                      return StreamBuilder(
                        stream: Services.getServiceAllUsers(
                          snapshot.data?.docs.map((e) => e.id).toList() ?? [],
                        ),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case ConnectionState.active:
                            case ConnectionState.done:
                              final data = snapshot.data?.docs;
                              list = data
                                      ?.map(
                                          (e) => ClientModel.fromJson(e.data()))
                                      .toList() ??
                                  [];
                              if (list.isNotEmpty) {
                                return ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.only(top: 6),
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    return ServiceChatUSerCard(
                                      user: list[index],
                                    );
                                  },
                                );
                              } else if (list.isEmpty) {
                                return const Center(
                                  child: Text(
                                    'Start a new Chat 🙂',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: Text(
                                    'Start a new Chat 🙂',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              }
                          }
                        },
                      );
                  }
                }),
          ),
        ],
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
      //   child: Container(
      //     padding: const EdgeInsets.symmetric(
      //       horizontal: 16,
      //     ),
      //     height: 62,
      //     width: MediaQuery.of(context).size.width,
      //     decoration: BoxDecoration(
      //       color: Clrs.mainColor,
      //       borderRadius: BorderRadius.circular(30),
      //     ),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       children: [
      //         BottomSheetButton(
      //           ontap: () {
      //             setState(() {
      //               homeScreen = true;
      //               inboxScreen = false;
      //               profileScreen = false;
      //             });

      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => const ClientHomeScreen(),
      //               ),
      //             );
      //           },
      //           title: 'Home',
      //           icon: Icons.home,
      //           color: homeScreen ? Colors.orange : Clrs.mainColor,
      //         ),
      //         BottomSheetButton(
      //           ontap: () {
      //             setState(() {
      //               homeScreen = false;
      //               inboxScreen = true;
      //               profileScreen = false;
      //             });
      //           },
      //           title: 'Inbox',
      //           icon: Icons.inbox,
      //           color: inboxScreen ? Colors.orange : Clrs.mainColor,
      //         ),
      //         BottomSheetButton(
      //           ontap: () {
      //             setState(() {
      //               homeScreen = false;
      //               inboxScreen = false;
      //               profileScreen = true;
      //             });

      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) =>
      //                       ClientProfileScreen(user: Services.client),
      //                 ));
      //           },
      //           title: 'Profile',
      //           icon: Icons.person,
      //           color: profileScreen ? Colors.orange : Clrs.mainColor,
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
