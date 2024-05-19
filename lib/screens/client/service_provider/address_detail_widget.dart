import 'package:fixlit/main.dart';
import 'package:flutter/material.dart';

class AddressDetailsWidget extends StatelessWidget {
  const AddressDetailsWidget(
      {super.key, required this.title, required this.msg});
  final String title;
  final String msg;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: mq.height * .05,
              width: mq.width * .4,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45.withOpacity(.35),
                    blurRadius: 14,
                  ),
                ],
                color: Colors.blue.shade50,
              ),
            ),
            Container(
              // height: mq.height * .2,
              width: mq.width - 40,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45.withOpacity(.35),
                    blurRadius: 14,
                  ),
                ],
                color: Colors.blue.shade50,
              ),
              child: Center(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      msg,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          height: mq.height * .052,
          width: mq.width * .4,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.blue.shade50,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: mq.width * .06,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
