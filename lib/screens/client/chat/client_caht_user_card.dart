import 'package:fixlit/models/message_model.dart';
import 'package:fixlit/models/service_provider_model.dart';
import 'package:fixlit/screens/client/chat/client_chat_screen.dart';
import 'package:fixlit/screens/client/chat/date_util.dart';
import 'package:fixlit/screens/service%20provider/image_clip_view.dart';
import 'package:fixlit/services/apis.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatUSerCard extends StatefulWidget {
  const ChatUSerCard({super.key, required this.user});
  final ServiceProvider user;

  @override
  State<ChatUSerCard> createState() => _ChatUSerCardState();
}

class _ChatUSerCardState extends State<ChatUSerCard> {
  MessageModel? _message;
  @override
  Widget build(BuildContext context) {
    final users = widget.user;
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .03,
        vertical: 4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0.5,
      color: Colors.blue.shade50.withOpacity(0.8),
      child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ClientChatScreen(
                  user: widget.user,
                ),
              ),
            );
          },
          child: StreamBuilder(
            stream: Services.getLastMessage(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => MessageModel.fromJson(e.data())).toList() ??
                      [];

              if (list.isNotEmpty) {
                _message = list[0];
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: ImageViewerClip(
                      urlImage: users.image, height: 46, width: 46),
                  // user name
                  title: Text("${users.name.capitalized}, ${users.catagory}"),
                  // for last message
                  subtitle: Text(
                    _message != null
                        ? _message!.type == Type.image
                            ? "Image"
                            : _message!.msg
                        : users.catagory,
                    maxLines: 1,
                  ),
                  // for message sent or received time
                  trailing: _message == null
                      ? null
                      : _message!.read.isEmpty &&
                              _message!.fromId != Services.user.uid
                          ? Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: Colors.green.shade400,
                                shape: BoxShape.circle,
                              ),
                            )
                          : Text(
                              MyDate.getLatsMessageTime(
                                  context: context, time: _message!.sent),
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                ),
              );
            },
          )),
    );
  }
}
