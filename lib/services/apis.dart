import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      role: user.photoURL.toString(),
    );
    await firestore.collection("p_user").doc(user.uid).set(
          pUser.toJson(),
        );
  }

  //update profile
  static Future<void> updateProfile() async {
    await firestore.collection("p_user").doc(user.uid).update({
      "name": me.name,
      "email": me.email,
    });
  }

  // update profile pic
  // static Future<void> updateProfilePic(File file) async {
  //   final ext = file.path.split(".").first;
  //   final ref = storage.ref().child("images/${user.uid}.$ext");
  //   await ref
  //       .putFile(file, SettableMetadata(contentType: "image/$ext"))
  //       .then((p0) {});
  //   me.image = await ref.getDownloadURL();
  //   await firestore.collection("p_user").doc(user.uid).update({
  //     "image": me.image,
  //   });
  // }

//forget password
  static Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Error is $e");
    }
  }

// adding child to home
  static Future<bool> addMychilds(String email) async {
    final data = await firestore
        .collection("jr_user")
        .where("email", isEqualTo: email)
        .get();
    if (data.docs.isNotEmpty && data.docs.first.id != user.uid) {
      await firestore
          .collection("p_user")
          .doc(user.uid)
          .collection("my_childs")
          .doc(data.docs.first.id)
          .set({
        "email": email,
        "id": data.docs.first.id,
      });

      return true;
    } else {
      // if not exists
      return false;
    }
  }

// for getting my user
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyChilds() {
    return firestore
        .collection("p_user")
        .doc(user.uid)
        .collection("my_childs")
        .snapshots();
  }

  // to get all users
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      List<String> userIDs) {
    return firestore
        .collection("jr_user")
        .where("id", whereIn: userIDs.isEmpty ? [''] : userIDs)
        // .where("id", isNotEqualTo: user.uid)
        .snapshots();
  }
  // User info

  static Stream<QuerySnapshot<Map<String, dynamic>>> getLocations(
      List<String> childIDs) {
    return firestore
        .collection("jr_user")
        .doc(childIDs.first)
        .collection("location")
        .where("id", whereIn: childIDs.isEmpty ? [""] : childIDs)
        .snapshots();
  }

  // get my profile
  static UserModel me = UserModel(
    name: "Name",
    id: user.uid,
    email: "Email",
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

  // to get location data
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getChildLocation(
      String childId) {
    return firestore
        .collection("jr_user")
        .doc(childId)
        .collection("location")
        .doc(childId)
        .snapshots();
  }
}
