// ignore_for_file: must_be_immutable

import 'package:fixlit/main.dart';
import 'package:fixlit/widgets/client_home/profile_header.dart';
import 'package:flutter/material.dart';

class ClientCustomAppBar extends StatelessWidget {
  ClientCustomAppBar({required this.btn, required this.isSearch, super.key});
  bool btn;
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 18),
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
            height: mq.height * .03,
          ),
          ProfileHeader(
            isButton: btn,
          ),
          isSearch
              ? const SizedBox(
                  height: 12,
                )
              : const SizedBox(
                  height: 6,
                ),
        ],
      ),
    );
  }
}
