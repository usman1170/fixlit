// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:fixlit/auth/widgets/loading_screen.dart';
import 'package:fixlit/models/service_provider_model.dart';
import 'package:fixlit/screens/service%20provider/image_view.dart';
import 'package:fixlit/services/apis.dart';
import 'package:fixlit/utils/pallate.dart';
import 'package:fixlit/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LicenseScreen extends StatefulWidget {
  const LicenseScreen({super.key, required this.serviceProvider});
  final ServiceProvider serviceProvider;

  @override
  State<LicenseScreen> createState() => _LicenseScreenState();
}

class _LicenseScreenState extends State<LicenseScreen> {
  String? _image;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final user = widget.serviceProvider;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update License",
        ),
        centerTitle: true,
      ),
      body: loading
          ? const LoadingScreen()
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Good Morning!",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            user.name == ""
                                ? "Hey There..."
                                : user.name.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
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
                                      builder: (context) =>
                                          ImageViewScreen(image: user.image),
                                    ));
                              },
                              child: Image.network(
                                user.image,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Clrs.mainColor,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
                                            : null,
                                      ),
                                    );
                                  }
                                },
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
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
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 16,
                      width: 4,
                      decoration: BoxDecoration(
                        color: Clrs.mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Hi, ${user.name.toUpperCase()} please update your license here",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    _bottomSheet();
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .42,
                    width: MediaQuery.of(context).size.width * .6,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: _image != null
                          ? Container(
                              height: MediaQuery.of(context).size.height * .42,
                              width: MediaQuery.of(context).size.width * .6,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(File(_image!)),
                              ),
                            )
                          : user.license != ""
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height * .42,
                                  width: MediaQuery.of(context).size.width * .6,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ImageViewScreen(
                                                      image: user.license),
                                            ));
                                      },
                                      child: Image.network(
                                        user.license,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: Clrs.mainColor,
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        (loadingProgress
                                                                .expectedTotalBytes ??
                                                            1)
                                                    : null,
                                              ),
                                            );
                                          }
                                        },
                                        errorBuilder: (BuildContext context,
                                            Object error,
                                            StackTrace? stackTrace) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Icon(
                                              Icons.add_a_photo,
                                              size: 55,
                                              color: Clrs.mainColor,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              : Icon(
                                  Icons.add_a_photo,
                                  size: 55,
                                  color: Colors.grey.shade600,
                                ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      loading = true;
                    });
                    if (_image != null) {
                      Services.updateLicense(File(_image!));

                      setState(() {
                        loading = false;
                      });
                    } else {
                      setState(() {
                        loading = false;
                      });
                      Dialogs().errorDialog(context, "Error",
                          "Please select license Image first");
                    }
                    setState(() {
                      loading = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 52,
                    width: MediaQuery.of(context).size.width * .6,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Clrs.mainColor,
                        Colors.blue.shade600,
                      ]),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        "Update",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  void _bottomSheet() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * .03,
            bottom: MediaQuery.of(context).size.height * .05,
          ),
          children: [
            const Center(
              child: Text(
                "Pick License Image",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * .3,
                      MediaQuery.of(context).size.height * .15,
                    ),
                  ),
                  onPressed: () async {
                    final XFile? image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 75,
                    );
                    if (image != null) {
                      setState(() {
                        _image = image.path;
                      });
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: const Text('Error Occured'),
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 25,
                                bottom: 12,
                              ),
                              child: Text(
                                'Image not selected...',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Ok'),
                            )
                          ],
                        ),
                      );
                    }
                    Navigator.pop(context);
                  },
                  child: Image.asset('assets/imgs/gallery.png'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    fixedSize: Size(
                      MediaQuery.of(context).size.width * .3,
                      MediaQuery.of(context).size.height * .15,
                    ),
                  ),
                  onPressed: () async {
                    final image = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      imageQuality: 75,
                    );
                    if (image != null) {
                      setState(() {
                        _image = image.path;
                      });
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: const Text('Error Occured'),
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 25,
                                bottom: 12,
                              ),
                              child: Text(
                                'Image not selected...',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Ok'),
                            )
                          ],
                        ),
                      );
                    }

                    // Services.updateLicense(File(_image!));
                    Navigator.pop(context);
                  },
                  child: Image.asset('assets/imgs/cam.jpg'),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
