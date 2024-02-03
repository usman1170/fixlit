// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:fixlit/models/user_model.dart';
import 'package:fixlit/services/apis.dart';
import 'package:fixlit/widgets/buttons.dart';
import 'package:fixlit/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.user});
  final PUser user;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? _image;

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: BackPopButton(
            color: Colors.blue.shade700,
            bgcolor: Colors.white,
          ),
          title: Text(
            "Profile Update",
            style: TextStyle(
              color: Colors.blue.shade700,
            ),
          ),
        ),
        body: isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'please wait...',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ],
                ),
              )
            : Form(
                key: _formKey,
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 15, right: 15),
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                _image != null
                                    ? Container(
                                        height: 160,
                                        width: 160,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(75),
                                          child: Image.file(
                                            File(_image!),
                                            fit: BoxFit.cover,
                                            errorBuilder: (BuildContext context,
                                                Object error,
                                                StackTrace? stackTrace) {
                                              return Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade400,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: const Icon(
                                                  Icons.person,
                                                  size: 50,
                                                  color: Colors.white,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 160,
                                        width: 160,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(75),
                                          child: Image.network(
                                            user.image,
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
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
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade400,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: const Icon(
                                                  Icons.person,
                                                  size: 50,
                                                  color: Colors.white,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: MaterialButton(
                                    onPressed: () {
                                      _bottomSheet();
                                    },
                                    elevation: 1,
                                    color:
                                        Colors.blue.shade300.withOpacity(0.8),
                                    shape: CircleBorder(),
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              user.email,
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                letterSpacing: 0.8,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            TextFormField(
                              onSaved: (value) =>
                                  Services.me.name = value ?? "",
                              validator: (val) => val != null && val.isNotEmpty
                                  ? null
                                  : "Required Field",
                              initialValue: user.name,
                              decoration: InputDecoration(
                                label: const Text(
                                  'Name',
                                  style: TextStyle(color: Colors.black),
                                ),
                                prefixIcon: Icon(Icons.person),
                                hintText: "Enter name",
                                prefixIconColor: Colors.blue,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(color: Colors.blue)),
                                contentPadding: EdgeInsets.only(
                                  top: 18,
                                  bottom: 18,
                                  left: 10,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              onSaved: (value) => Services.me.email = value!,
                              validator: (val) => val != null && val.isNotEmpty
                                  ? null
                                  : "Required Field",
                              initialValue: user.email,
                              decoration: InputDecoration(
                                  label: const Text(
                                    'Email',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  prefixIcon: const Icon(Icons.info),
                                  hintText: "Enter your Email",
                                  prefixIconColor: Colors.blue,
                                  hintStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                    top: 18,
                                    bottom: 18,
                                    left: 10,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 12, right: 12),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.blue.shade600,
            onPressed: () async {
              FocusScope.of(context).unfocus();
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Services.updateProfile().then((value) {
                  setState(() {
                    isLoading = false;
                  });
                  Dialogs.showMassage(context, "Profile Updated Successfully");
                });
              }
              // await Services.upDateActiveStatus(false);
            },
            label: const Text(
              "Update",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            icon: Icon(
              Icons.update,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _bottomSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
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
                "Pick Profile Image",
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
                    Services.updateProfilePic(File(_image!));
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

                    Services.updateProfilePic(File(_image!));
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
