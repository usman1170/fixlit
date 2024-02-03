import 'package:fixlit/services/apis.dart';
import 'package:fixlit/widgets/dialogs.dart';
import 'package:fixlit/widgets/drawers.dart';
import 'package:flutter/material.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  void initState() {
    // Services.getMyProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FamiCare"),
      ),
      drawer: const MyDrawer(),
      body: Container(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8, right: 10),
        child: FloatingActionButton(
          onPressed: () {
            _showAddChildDialog();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showAddChildDialog() {
    String email = "";
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.only(
            bottom: 10,
            top: 20,
            left: 20,
            right: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text("Add Child"),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Make sure that child exists...',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  onChanged: (value) => email = value,
                  maxLines: null,
                  decoration: InputDecoration(
                    label: const Text('Email'),
                    hintText: "Enter Child email...",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    minWidth: 0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cencel",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  MaterialButton(
                    minWidth: 0,
                    onPressed: () async {
                      Navigator.of(context).pop();
                      if (email.isNotEmpty) {
                        await Services.addMychilds(email).then((val) {
                          if (val == false) {
                            Dialogs.showMassage(context, "Child not exists");
                          }
                        });
                      }
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
