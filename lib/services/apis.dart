// ignore_for_file: avoid_print
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fixlit/models/client_model.dart';
import 'package:fixlit/models/message_model.dart';
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

  // for adding an chat user for our conversation
  static Future<bool> addChatUser(String email) async {
    final data = await firestore
        .collection('service_provider')
        .where('email', isEqualTo: email)
        .get();
    if (data.docs.isNotEmpty && data.docs.first.id != user.uid) {
      //user exists
      firestore
          .collection('client')
          .doc(user.uid)
          .collection('inbox')
          .doc(data.docs.first.id)
          .set({
        "email": email,
      });

      return true;
    } else {
      //user doesn't exists

      return false;
    }
  }

  //getting my inbox users
  // to get all users
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(
      List<String> userIDs) {
    return firestore
        .collection("service_provider")
        .where("id", whereIn: userIDs.isEmpty ? [''] : userIDs)
        // .where("id", isNotEqualTo: user.uid)
        .snapshots();
  }

  // to get all  my users
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyUsers() {
    return firestore
        .collection("client")
        .doc(user.uid)
        .collection("inbox")
        .snapshots();
  }

  // to get all users
  static Stream<QuerySnapshot<Map<String, dynamic>>> getServiceAllUsers(
      List<String> userIDs) {
    return firestore
        .collection("client")
        .where("id", whereIn: userIDs.isEmpty ? [''] : userIDs)
        .snapshots();
  }

  // to get all  my users
  static Stream<QuerySnapshot<Map<String, dynamic>>> getServiceMyUsers() {
    return firestore
        .collection("service_provider")
        .doc(user.uid)
        .collection("inbox")
        .snapshots();
  }

  // get all service providers
  static Stream<QuerySnapshot<Map<String, dynamic>>> getServiceProviders(
      List<String> userIDs) {
    return firestore
        .collection("service_provider")
        .where("id", whereIn: userIDs.isEmpty ? [''] : userIDs)
        // .where("id", isNotEqualTo: user.uid)
        .snapshots();
  }

  // get all service providers Ids
  static Stream<QuerySnapshot<Map<String, dynamic>>> getServiceProvidersIds() {
    return firestore.collection("service_provider").snapshots();
  }

  // get main profile for user decider
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
  // User info

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ServiceProvider chatUser) {
    return firestore
        .collection("users")
        .where("id", isEqualTo: chatUser.id)
        .snapshots();
  }

// for update active status of user
  static Future<void> upDateActiveStatus(bool isOnline) async {
    firestore.collection("users").doc(user.uid).update({
      "is_online": isOnline,
      "last_seen": DateTime.now().millisecondsSinceEpoch.toString(),
      // "token": me.token,
    });
  }

  // getting conversation id
  static String getConversationId(String id) => user.uid.hashCode <= id.hashCode
      ? "${user.uid}_$id"
      : "${id}_${user.uid}";
// to get all messages
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      ServiceProvider user) {
    return firestore
        .collection("chats/${getConversationId(user.id)}/messages")
        .orderBy(
          "sent",
          descending: true,
        )
        .snapshots();
  }

  // to get all messages
  static Stream<QuerySnapshot<Map<String, dynamic>>> getServiceMessages(
      ClientModel user) {
    return firestore
        .collection("chats/${getConversationId(user.id)}/messages")
        .orderBy(
          "sent",
          descending: true,
        )
        .snapshots();
  }

  // delete message function
  static Future<void> deleteMessage(MessageModel message) async {
    await firestore
        .collection("chats/${getConversationId(message.toId)}/messages")
        .doc(message.sent)
        .delete();
    if (message.type == Type.image) {
      await storage.refFromURL(message.msg).delete();
    }
  }

  // update message
  static Future<void> updateMessage(
      MessageModel message, String updatedMsg) async {
    await firestore
        .collection("chats/${getConversationId(message.toId)}/messages")
        .doc(message.sent)
        .update({
      "msg": updatedMsg,
    });
  }

  // to send message
  static Future<void> sendMessage(
      ServiceProvider chatUser, String msg, Type type) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final MessageModel message = MessageModel(
      msg: msg,
      toId: chatUser.id,
      read: '',
      type: type,
      fromId: user.uid,
      sent: time,
    );
    final ref = firestore
        .collection("chats/${getConversationId(chatUser.id)}/messages");
    await ref.doc(time).set(message.toJson());
  }

// update changes of muy profile
  static Future<void> sendFirstMessage(
      ServiceProvider chatUser, String msg, Type type) async {
    firestore
        .collection("service_provider")
        .doc(chatUser.id)
        .collection("inbox")
        .doc(user.uid)
        .set({}).then(
      (value) => sendMessage(chatUser, msg, type),
    );
  }

// update changes of muy profile
  static Future<void> sendServiceFirstMessage(
      ClientModel chatUser, String msg, Type type) async {
    firestore
        .collection("client")
        .doc(chatUser.id)
        .collection("inbox")
        .doc(user.uid)
        .set({}).then(
      (value) => sendServiceMessage(chatUser, msg, type),
    );
  }

  // to send message
  static Future<void> sendServiceMessage(
      ClientModel chatUser, String msg, Type type) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final MessageModel message = MessageModel(
      msg: msg,
      toId: chatUser.id,
      read: '',
      type: type,
      fromId: user.uid,
      sent: time,
    );
    final ref = firestore
        .collection("chats/${getConversationId(chatUser.id)}/messages");
    await ref.doc(time).set(message.toJson());
  }

  // to read or not read message blue tick
  static Future<void> updateReadMessage(MessageModel message) async {
    firestore
        .collection("chats/${getConversationId(message.fromId)}/messages")
        .doc(message.sent)
        .update(
      {
        'read': DateTime.now().millisecondsSinceEpoch.toString(),
      },
    );
  }

// get last message to show
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ServiceProvider user) {
    return firestore
        .collection("chats/${getConversationId(user.id)}/messages")
        .orderBy(
          "sent",
          descending: true,
        )
        .limit(1)
        .snapshots();
  }

  // funtion to send images between chat
  static Future<void> sendChatImage(ServiceProvider chatUser, File file) async {
    final ext = file.path.split(".").last;
    final ref = storage.ref().child(
        "images/${getConversationId(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext");
    await ref
        .putFile(file, SettableMetadata(contentType: "image/$ext"))
        .then((p0) {});
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(
      chatUser,
      imageUrl,
      Type.image,
    );
  }

// get last message to show
  static Stream<QuerySnapshot<Map<String, dynamic>>> getServiceLastMessage(
      ClientModel user) {
    return firestore
        .collection("chats/${getConversationId(user.id)}/messages")
        .orderBy(
          "sent",
          descending: true,
        )
        .limit(1)
        .snapshots();
  }

  // funtion to send images between chat
  static Future<void> sendServiceChatImage(
      ClientModel chatUser, File file) async {
    final ext = file.path.split(".").last;
    final ref = storage.ref().child(
        "images/${getConversationId(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext");
    await ref
        .putFile(file, SettableMetadata(contentType: "image/$ext"))
        .then((p0) {});
    final imageUrl = await ref.getDownloadURL();
    await sendServiceMessage(
      chatUser,
      imageUrl,
      Type.image,
    );
  }
}
