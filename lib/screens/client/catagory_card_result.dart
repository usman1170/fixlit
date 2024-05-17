// ignore_for_file: avoid_print
import 'package:fixlit/models/service_provider_model.dart';
import 'package:fixlit/screens/client/service_provider/service_provider_details.dart';
import 'package:fixlit/screens/service%20provider/image_clip_view.dart';
import 'package:fixlit/services/apis.dart';
import 'package:fixlit/utils/pallate.dart';
import 'package:fixlit/widgets/client_home/main_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchedCatagory extends StatefulWidget {
  const SearchedCatagory({
    super.key,
    required this.catagory,
  });
  final String catagory;

  @override
  State<SearchedCatagory> createState() => _SearchedCatagoryState();
}

class _SearchedCatagoryState extends State<SearchedCatagory> {
  List<ServiceProvider> list = [];
  List<ServiceProvider> newList = [];
  @override
  Widget build(BuildContext context) {
    final catagory = widget.catagory;
    return Scaffold(
      body: Column(
        children: [
          ClientCustomAppBar(
            btn: true,
            isSearch: false,
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text(
                  'Showing Result For "$catagory"',
                  style: TextStyle(
                    color: Clrs.mainColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Expanded(
            child: StreamBuilder(
                stream: Services.getServiceProvidersIds(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ));
                    case ConnectionState.none:
                      return const Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ));
                    case ConnectionState.active:
                    case ConnectionState.done:
                      return StreamBuilder(
                        stream: Services.getServiceProviders(
                          snapshot.data?.docs.map((e) => e.id).toList() ?? [],
                        ),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              );
                            case ConnectionState.none:
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              );
                            case ConnectionState.active:
                            case ConnectionState.done:
                              final data = snapshot.data?.docs;
                              list = data
                                      ?.map((e) =>
                                          ServiceProvider.fromJson(e.data()))
                                      .toList() ??
                                  [];
                              newList.clear();
                              for (var i in list) {
                                if (i.catagory == widget.catagory) {
                                  newList.add(i);
                                }
                              }
                              if (newList.isNotEmpty) {
                                print(newList.length);
                                return ListView.builder(
                                  itemCount: newList.length,
                                  itemBuilder: (context, index) {
                                    final data = newList[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ServiceProviderDetails(
                                                serviceProvider: data,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Card(
                                          color: Colors.grey.shade200,
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                18,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6),
                                              child: ListTile(
                                                leading: ImageViewerClip(
                                                  urlImage: data.image,
                                                  height: 55,
                                                  width: 55,
                                                ),
                                                title: Text(
                                                  data.name.toUpperCase(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                subtitle: Text(data.catagory),
                                                trailing: Container(
                                                  height: 38,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                    color: Colors.orange,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: const Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          CupertinoIcons
                                                              .chat_bubble_2,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 6,
                                                        ),
                                                        Text(
                                                          "Ask",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                  child: Text(
                                    'There is no Service availabe yet  😢',
                                    style: TextStyle(
                                      fontSize: 16,
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
