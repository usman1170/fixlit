// ignore_for_file: must_be_immutable
import 'package:fixlit/services/apis.dart';
import 'package:fixlit/utils/pallate.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({
    required this.isButton,
    super.key,
  });
  bool isButton = false;
  @override
  Widget build(BuildContext context) {
    final image = Services.client.image;
    return Row(
      children: [
        isButton
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
              width: isButton ? 8 : 20,
            ),
            if (image != "")
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
                    image,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
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
                        child: Icon(
                          Icons.person,
                          size: 28,
                          color: Clrs.mainColor,
                        ),
                      );
                    },
                  ),
                ),
              ),
            if (image == "")
              Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      color: Clrs.mainColor,
                      size: 28,
                    ),
                  )),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Text(
                  "Good Morning!",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade100,
                  ),
                ),
                Text(
                  "Usman Ghani",
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
    );
  }
}
