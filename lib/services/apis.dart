// ignore_for_file: avoid_print
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fixlit/models/client_model.dart';
import 'package:fixlit/models/service_provider_model.dart';
import 'package:fixlit/models/user_model.dart';

class Services {
  // instances
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => auth.currentUser!;
  // all fucntions
  static Future<void> createUser() async {
    final date = DateTime.now().toString();
    final pUser = UserModel(
      name: user.displayName.toString(),
      id: user.uid,
      email: user.email.toString(),
      createdAt: date,
      role: "client",
    );
    await firestore.collection("users").doc(user.uid).set(
          pUser.toJson(),
        );
  }

// client update profile
  static Future<void> mainUpdateProfile(String name, email) async {
    await firestore.collection("users").doc(client.id).update({
      "name": name,
      "email": email,
    });
  }

  // client update profile
  static Future<void> clientUpdateProfile() async {
    await firestore.collection("client").doc(client.id).update({
      "name": client.name,
      "email": client.email,
    });
    mainUpdateProfile(client.name, client.email);
  }

  static Future<void> updateStatus(bool status) async {
    await firestore
        .collection("service_provider")
        .doc(serviceProvider.id)
        .update({
      "available": status,
    });
  }

  // service update profile
  static Future<void> serviceUpdateProfile() async {
    await firestore
        .collection("service_provider")
        .doc(serviceProvider.id)
        .update({
      "name": serviceProvider.name,
      "address": serviceProvider.address,
      "phone": serviceProvider.phone,
      "timings": serviceProvider.timings,
      "bio": serviceProvider.bio,
      "catagory": serviceProvider.catagory,
      "city": serviceProvider.city,
    });

    mainUpdateProfile(serviceProvider.name, serviceProvider.email);
  }

//forget password
  static Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Error is $e");
    }
  }

// // adding child to home
//   static Future<bool> addMychilds(String email) async {
//     final data = await firestore
//         .collection("jr_user")
//         .where("email", isEqualTo: email)
//         .get();
//     if (data.docs.isNotEmpty && data.docs.first.id != user.uid) {
//       await firestore
//           .collection("p_user")
//           .doc(user.uid)
//           .collection("my_childs")
//           .doc(data.docs.first.id)
//           .set({
//         "email": email,
//         "id": data.docs.first.id,
//       });

//       return true;
//     } else {
//       // if not exists
//       return false;
//     }
//   }

// for getting my user
  // static Stream<QuerySnapshot<Map<String, dynamic>>> getMyChilds() {
  //   return firestore
  //       .collection("p_user")
  //       .doc(user.uid)
  //       .collection("my_childs")
  //       .snapshots();
  // }
  static Future<void> userCheck() async {
    await firestore.collection("users").doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = UserModel.fromJson(user.data()!);
      } else {
        await createUser().then((value) => getMyProfile());
      }
    });
  }

  // get all service providers
  // to get all users
  static Stream<QuerySnapshot<Map<String, dynamic>>> getServiceProvidersIds(
      List<String> userIDs) {
    return firestore
        .collection("service_provider")
        .where("id", whereIn: userIDs.isEmpty ? [''] : userIDs)
        // .where("id", isNotEqualTo: user.uid)
        .snapshots();
  } // to get all users

  static Stream<QuerySnapshot<Map<String, dynamic>>> getServiceProviders() {
    return firestore.collection("service_provider").snapshots();
  }

  // get my profile
  static UserModel me = UserModel(
    name: "Name",
    id: user.uid,
    email: user.email!,
    createdAt: "createdAt",
    role: "null",
  );
  static Future<void> getMyProfile() async {
    await firestore.collection("users").doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = UserModel.fromJson(user.data()!);
      } else {
        await createUser().then((value) => getMyProfile());
      }
    });
  }

  static ClientModel client = ClientModel(
    name: user.displayName!,
    id: user.uid,
    email: user.email!,
    createdAt: "createdAt",
    image: "null",
  );
  static Future<void> clientProfile() async {
    await firestore.collection("client").doc(user.uid).get().then((user) async {
      if (user.exists) {
        client = ClientModel.fromJson(user.data()!);
      } else {
        await createUser().then((value) => clientProfile());
      }
    });
  }

  static ServiceProvider serviceProvider = ServiceProvider(
    name: user.displayName!,
    id: user.uid,
    email: user.email!,
    createdAt: "createdAt",
    image: "null",
    catagory: '',
    userCatagory: '',
    address: '',
    bio: '',
    phone: '',
    timings: '',
    license: '',
    available: false,
    city: '',
  );
  static Future<void> serviceProfile() async {
    await firestore
        .collection("service_provider")
        .doc(user.uid)
        .get()
        .then((user) async {
      if (user.exists) {
        serviceProvider = ServiceProvider.fromJson(user.data()!);
      } else {
        await createUser().then((value) => serviceProfile());
      }
    });
  }

  //update profile pic
  static Future<void> updateProfilePic(File file) async {
    final ext = file.path.split(".").first;
    final ref = storage.ref().child("images/${user.uid}.$ext");
    await ref
        .putFile(file, SettableMetadata(contentType: "image/$ext"))
        .then((p0) {});
    client.image = await ref.getDownloadURL();
    serviceProvider.image = await ref.getDownloadURL();
    await firestore
        .collection(me.role == "client" ? "client" : "service_provider")
        .doc(user.uid)
        .update({
      "image": me.role == "client" ? client.image : serviceProvider.image,
    });
  }

  //update profile pic
  static Future<void> updateLicense(File file) async {
    final ext = file.path.split(".").first;
    final ref = storage.ref().child("license/${user.uid}.$ext");
    await ref
        .putFile(file, SettableMetadata(contentType: "image/$ext"))
        .then((p0) {});
    serviceProvider.license = await ref.getDownloadURL();
    await firestore.collection("service_provider").doc(user.uid).update({
      "license": serviceProvider.license,
    });
  }
}
