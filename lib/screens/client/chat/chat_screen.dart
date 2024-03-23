// import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:fixlit/models/message_model.dart';
// import 'package:fixlit/models/service_provider_model.dart';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';


// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key, required this.user});
//   final ServiceProvider user;

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   bool _showEmoji = false, _isUploading = false;
//   List<MessageModel> _list = [];
//   final _textController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     // final user = widget.user;
//     print("Widget rebuild");
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: SafeArea(
//         child: WillPopScope(
//           onWillPop: () {
//             if (_showEmoji) {
//               setState(() {
//                 _showEmoji = !_showEmoji;
//               });
//               return Future.value(false);
//             } else {
//               return Future.value(true);
//             }
//           },
//           child: Scaffold(
//             backgroundColor: const Color.fromARGB(255, 235, 250, 254),
//             appBar: AppBar(
//               automaticallyImplyLeading: false,
//               flexibleSpace: _appBar(),
//             ),
//             body: Column(
//               children: [
//                 Expanded(
//                   child: StreamBuilder(
//                     stream: Services.getMessages(widget.user),
//                     builder: (context, snapshot) {
//                       switch (snapshot.connectionState) {
//                         case ConnectionState.waiting:
//                         case ConnectionState.none:
//                           return const Center(
//                             child: SizedBox(),
//                           );
//                         case ConnectionState.active:
//                         case ConnectionState.done:
//                           final data = snapshot.data!.docs;
//                           _list = data
//                               .map(
//                                 (e) => MessageModel.fromJson(e.data()),
//                               )
//                               .toList();

//                           if (_list.isNotEmpty) {
//                             return ListView.builder(
//                               reverse: true,
//                               physics: const BouncingScrollPhysics(),
//                               padding: const EdgeInsets.only(top: 6),
//                               itemCount: _list.length,
//                               itemBuilder: (context, index) {
//                                 return MassageCard(
//                                   message: _list[index],
//                                 );
//                               },
//                             );
//                           } else {
//                             return const Center(
//                               child: Text(
//                                 'Start a Chat with user 🙂',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             );
//                           }
//                       }
//                     },
//                   ),
//                 ),
//                 if (_isUploading)
//                   const Align(
//                       alignment: Alignment.bottomRight,
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(
//                           vertical: 8,
//                           horizontal: 20,
//                         ),
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                         ),
//                       )),
//                 _chatInput(),
//                 if (_showEmoji)
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * .34,
//                     child: EmojiPicker(
//                       textEditingController: _textController,
//                       config: Config(
//                         bgColor: const Color.fromARGB(255, 235, 250, 254),
//                         columns: 8,
//                         emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

// // app bar
//   Widget _appBar() {
//     final user = widget.user;
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ViewProfileScreen(user: user),
//           ),
//         );
//       },
//       child: StreamBuilder(
//         stream: Services.getUserInfo(widget.user),
//         builder: (context, snapshot) {
//           final data = snapshot.data?.docs;
//           final list =
//               data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
//           return Row(
//             children: [
//               IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: const Icon(Icons.arrow_back),
//               ),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(
//                   MediaQuery.of(context).size.height * .03,
//                 ),
//                 child: CachedNetworkImage(
//                   height: MediaQuery.of(context).size.height * .055,
//                   width: MediaQuery.of(context).size.height * .055,
//                   imageUrl: list.isNotEmpty ? list[0].image : user.image,
//                   fit: BoxFit.cover,
//                   errorWidget: (context, url, error) => const CircleAvatar(
//                     child: Icon(Icons.person),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     list.isNotEmpty ? list[0].name : user.name,
//                     style: const TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 2,
//                   ),
//                   Text(
//                     list.isNotEmpty
//                         ? list[0].isOnline
//                             ? "Online"
//                             : MyDate.getLastActiveTime(
//                                 context: context, lastActive: list[0].lastSeen)
//                         : MyDate.getLastActiveTime(
//                             context: context, lastActive: user.lastSeen),
//                     style: const TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w300,
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           );
//         },
//       ),
//     );
//   }

// // bootom field
//   Widget _chatInput() {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         vertical: MediaQuery.of(context).size.height * .01,
//         horizontal: MediaQuery.of(context).size.width * .025,
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       FocusScope.of(context).unfocus();
//                       setState(() => _showEmoji = !_showEmoji);
//                     },
//                     icon: const Icon(
//                       Icons.emoji_emotions,
//                       size: 26,
//                       color: Colors.blueAccent,
//                     ),
//                   ),
//                   Expanded(
//                     child: TextField(
//                       onTap: () {
//                         if (_showEmoji) {
//                           setState(() => _showEmoji = !_showEmoji);
//                         }
//                       },
//                       controller: _textController,
//                       keyboardType: TextInputType.multiline,
//                       maxLines: null,
//                       decoration: const InputDecoration(
//                         hintText: "Type somthing...",
//                         hintStyle: TextStyle(
//                           color: Colors.blueAccent,
//                           fontSize: 15,
//                         ),
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () async {
//                       final List<XFile> images =
//                           await ImagePicker().pickMultiImage(
//                         imageQuality: 60,
//                       );
//                       for (var i in images) {
//                         setState(() => _isUploading = true);
//                         await Services.sendChatImage(widget.user, File(i.path))
//                             .then((value) {
//                           setState(() => _isUploading = false);
//                         });
//                       }
//                     },
//                     icon: const Icon(
//                       Icons.image,
//                       size: 26,
//                       color: Colors.blueAccent,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () async {
//                       final XFile? image = await ImagePicker().pickImage(
//                         source: ImageSource.camera,
//                         imageQuality: 60,
//                       );
//                       if (image != null) {
//                         setState(() => _isUploading = true);
//                         await Services.sendChatImage(
//                                 widget.user, File(image.path))
//                             .then((value) {
//                           setState(() => _isUploading = false);
//                         });
//                       }
//                     },
//                     icon: const Icon(
//                       Icons.camera_alt,
//                       size: 28,
//                       color: Colors.blueAccent,
//                     ),
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * .015,
//                   )
//                 ],
//               ),
//             ),
//           ),
//           MaterialButton(
//             minWidth: 0,
//             padding:
//                 const EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 8),
//             shape: const CircleBorder(),
//             color: Colors.cyan,
//             onPressed: () {
//               if (_textController.text.isNotEmpty) {
//                 if (_list.isEmpty) {
//                   Services.sendFirstMessage(
//                       widget.user, _textController.text, Type.text);
//                 } else {
//                   Services.sendMessage(
//                       widget.user, _textController.text, Type.text);
//                 }
//                 _textController.text = '';
//               }
//             },
//             child: const Icon(
//               Icons.send,
//               color: Colors.white,
//               size: 26,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
