import 'package:fixlit/screens/service%20provider/image_view.dart';
import 'package:fixlit/utils/pallate.dart';
import 'package:flutter/material.dart';

class ImageViewerClip extends StatelessWidget {
  const ImageViewerClip(
      {super.key,
      required this.urlImage,
      required this.height,
      required this.width});
  final String urlImage;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade100,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: () {
            if (urlImage != "") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageViewScreen(image: urlImage),
                  ));
            }
          },
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  ),
                );
              }
            },
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return Container(
                width: height,
                height: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
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
    );
  }
}
