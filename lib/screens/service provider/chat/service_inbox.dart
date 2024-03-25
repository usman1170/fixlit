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
    );
  }
}
