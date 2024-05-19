// ignore_for_file: must_be_immutable
import 'package:fixlit/main.dart';
import 'package:fixlit/services/apis.dart';
import 'package:flutter/material.dart';

class ServiceCustomAppBar extends StatelessWidget {
  ServiceCustomAppBar({
    required this.btn,
    super.key,
  });
  bool btn;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 18),
      // height: 100,
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
          Row(
            children: [
              btn
                  ? IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    )
                  : const SizedBox(),
              Row(
                children: [
                  SizedBox(
                    width: btn ? 8 : 20,
                  ),
                  if (Services.serviceProvider.image != "")
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade100,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(75),
                        child: Image.network(
                          Services.serviceProvider.image,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 28,
                                color: darkColor,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  if (Services.serviceProvider.image == "")
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade100,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          color: darkColor,
                          size: 28,
                        ),
                      ),
                    ),
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
                        Services.serviceProvider.name == ""
                            ? "Hey There..."
                            : Services.serviceProvider.name.toUpperCase(),
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
            ],
          ),
          const SizedBox(
            height: 6,
          ),
        ],
      ),
    );
  }
}
