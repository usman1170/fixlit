import 'package:fixlit/utils/pallate.dart';
import 'package:fixlit/widgets/client_home/main_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchedCatagory extends StatefulWidget {
  const SearchedCatagory({super.key, required this.catagory});
  final String catagory;

  @override
  State<SearchedCatagory> createState() => _SearchedCatagoryState();
}

class _SearchedCatagoryState extends State<SearchedCatagory> {
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
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    color: Colors.grey.shade200,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 18,
                      child: ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Clrs.mainColor,
                          ),
                        ),
                        title: const Text(
                          "Usman Ghani",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(catagory),
                        trailing: Container(
                          height: 38,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.chat_bubble_2,
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
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
