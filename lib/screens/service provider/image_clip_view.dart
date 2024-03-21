import 'package:fixlit/screens/service%20provider/image_view.dart';
import 'package:fixlit/utils/pallate.dart';
import 'package:flutter/material.dart';

class ImageViewerClip extends StatelessWidget {
  const ImageViewerClip({super.key, required this.urlImage});
  final String urlImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade100,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageViewScreen(image: urlImage),
                ));
          },
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Clrs.mainColor,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              }
            },
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return Container(
                width: 55,
                height: 55,
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
