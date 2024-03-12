// ignore_for_file: must_be_immutable

import 'package:fixlit/utils/pallate.dart';
import 'package:fixlit/widgets/client_home/profile_header.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({required this.btn, super.key});
  bool btn;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 18),
      // height: 100,
      decoration: BoxDecoration(
        color: Clrs.mainColor,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          ProfileHeader(
            isButton: btn,
          ),
          const SizedBox(
            height: 14,
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            height: 47,
            width: MediaQuery.of(context).size.width - 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey.shade100,
            ),
            child: TextField(
              cursorColor: Colors.black87,
              style: const TextStyle(
                color: Colors.black87,
              ),
              cursorHeight: 20,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Try Plumbing, Cleaning, Welding etc...',
                  prefixIconColor: Colors.black54,
                  hintStyle:
                      const TextStyle(fontSize: 14, color: Colors.black54),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Clrs.mainColor),
                  ),
                  contentPadding: const EdgeInsets.only(
                    top: 18,
                    bottom: 18,
                    left: 12,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
