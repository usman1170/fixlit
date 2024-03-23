import 'package:cached_network_image/cached_network_image.dart';
import 'package:fixlit/models/message_model.dart';
import 'package:fixlit/screens/client/chat/date_util.dart';
import 'package:fixlit/services/apis.dart';
import 'package:fixlit/utils/pallate.dart';
import 'package:fixlit/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServiceMassageCard extends StatefulWidget {
  const ServiceMassageCard({super.key, required this.message});
  final MessageModel message;

  @override
  State<ServiceMassageCard> createState() => _ServiceMassageCardState();
}

class _ServiceMassageCardState extends State<ServiceMassageCard> {
  @override
  Widget build(BuildContext context) {
    bool isMe = Services.user.uid == widget.message.fromId;
    return InkWell(
      onLongPress: () {
        _bottomSheetDialog(isMe);
      },
      child: isMe ? _greenMessage() : _blueMessage(),
    );
  }

  void _bottomSheetDialog(bool isMe) {
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
            Center(
              child: Container(
                height: 5,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .36),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            // copy Text
            widget.message.type == Type.text
                ? _OptionItem(
                    icon: const Icon(
                      Icons.copy_all_rounded,
                      color: Colors.blue,
                      size: 26,
                    ),
                    name: "Copy text",
                    ontap: () async {
                      await Clipboard.setData(
                              ClipboardData(text: widget.message.msg))
                          .then((value) {
                        Navigator.pop(context);
                        Dialogs.showMassage(
                            context, "text copied to clipboard");
                      });
                    },
                  )
                : _OptionItem(
                    icon: const Icon(
                      Icons.download_rounded,
                      color: Colors.blue,
                      size: 26,
                    ),
                    name: "Save image",
                    ontap: () async {
                      // await GallerySaver.saveImage(widget.message.msg,
                      //         albumName: "Hello Chat")
                      //     .then((value) {
                      //   Navigator.pop(context);
                      //   if (value != null && value == true) {
                      //     Dialogs.showMassage(
                      //         context, "Image saved to Gellary");
                      //   } else {
                      //     Dialogs.showMassage(
                      //         context, "Error: Image not saved");
                      //   }
                      // });
                    },
                  ),
            Divider(
              color: Colors.black54,
              endIndent: MediaQuery.of(context).size.width * .04,
              indent: MediaQuery.of(context).size.height * .02,
            ),
            // edit message
            if (widget.message.type == Type.text && isMe)
              _OptionItem(
                icon: const Icon(
                  Icons.edit_rounded,
                  color: Colors.cyan,
                  size: 26,
                ),
                name: "Edit message",
                ontap: () {
                  Navigator.pop(context);
                  _showMessageUpdateDialog();
                },
              ),
            // delete message
            if (isMe)
              _OptionItem(
                icon: const Icon(
                  Icons.delete_rounded,
                  color: Colors.red,
                  size: 26,
                ),
                name: "Delete message",
                ontap: () async {
                  await Services.deleteMessage(widget.message).then((value) {
                    Navigator.pop(context);
                    Dialogs.showMassage(context, "Message deleted");
                  });
                },
              ),
            if (isMe)
              Divider(
                color: Colors.black54,
                endIndent: MediaQuery.of(context).size.width * .04,
                indent: MediaQuery.of(context).size.width * .04,
              ),
            // seen at
            _OptionItem(
              icon: const Icon(
                Icons.remove_red_eye,
                color: Colors.blue,
                size: 26,
              ),
              name:
                  "Seen at  ${MyDate.getLatsMessageTime(context: context, time: widget.message.sent)}",
              ontap: () {},
            ),
            _OptionItem(
              icon: const Icon(
                Icons.remove_red_eye,
                color: Colors.green,
                size: 26,
              ),
              name: widget.message.read.isEmpty
                  ? "Read at: Not seen yet"
                  : "Read at  ${MyDate.getLatsMessageTime(context: context, time: widget.message.read)}",
              ontap: () {},
            ),
          ],
        );
      },
    );
  }

  void _showMessageUpdateDialog() {
    String updatedMsg = widget.message.msg;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 20,
            bottom: 8,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Row(
            children: [
              const Icon(
                Icons.message,
                color: Colors.blue,
                size: 28,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .04,
              ),
              const Text("Update Message")
            ],
          ),
          content: TextFormField(
            maxLines: null,
            onChanged: (value) => updatedMsg = value,
            initialValue: updatedMsg,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          actions: [
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
                await Services.updateMessage(widget.message, updatedMsg);
              },
              child: const Text(
                "Update",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _blueMessage() {
    if (widget.message.read.isEmpty) {
      Services.updateReadMessage(widget.message);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(
              widget.message.type == Type.image
                  ? MediaQuery.of(context).size.width * .03
                  : MediaQuery.of(context).size.width * .04,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .04,
              vertical: MediaQuery.of(context).size.height * .01,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: const Color.fromARGB(255, 215, 235, 250),
            ),
            child: widget.message.type == Type.text
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.message.msg,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        MyDate.getFormatedTime(
                            context: context, time: widget.message.sent),
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height * .015,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: widget.message.msg,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.image,
                            size: 60,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        MyDate.getFormatedTime(
                            context: context, time: widget.message.sent),
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * .15,
          ),
        ),
      ],
    );
  }

  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * .15,
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(
              widget.message.type == Type.image
                  ? MediaQuery.of(context).size.width * .0
                  : MediaQuery.of(context).size.width * .04,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .04,
              vertical: MediaQuery.of(context).size.height * .01,
            ),
            decoration: BoxDecoration(
              border: widget.message.type == Type.image
                  ? Border.all(
                      color: const Color.fromARGB(255, 235, 250, 254),
                    )
                  : Border.all(color: Colors.orange),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              color: widget.message.type == Type.image
                  ? const Color.fromARGB(255, 235, 250, 254)
                  : const Color.fromARGB(255, 247, 251, 201),
            ),
            child: widget.message.type == Type.text
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.message.msg,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.message.read.isNotEmpty)
                            const Icon(
                              Icons.done_all_rounded,
                              color: Colors.blue,
                              size: 21,
                            ),
                          if (widget.message.read.isEmpty)
                            const Icon(
                              Icons.done_rounded,
                              color: Colors.grey,
                              size: 21,
                            ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            MyDate.getFormatedTime(
                                context: context, time: widget.message.sent),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Clrs.mainColor.withOpacity(.4),
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.height * .04,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.height * .036,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: widget.message.msg,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.image,
                              size: 60,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (widget.message.read.isNotEmpty)
                            const Icon(
                              Icons.done_all_rounded,
                              color: Colors.blue,
                              size: 21,
                            ),
                          if (widget.message.read.isEmpty)
                            const Icon(
                              Icons.done_rounded,
                              color: Colors.grey,
                              size: 21,
                            ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            MyDate.getFormatedTime(
                                context: context, time: widget.message.sent),
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}

class _OptionItem extends StatelessWidget {
  const _OptionItem(
      {required this.icon, required this.name, required this.ontap});
  final Icon icon;
  final String name;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.height * .04,
            top: MediaQuery.of(context).size.height * .015,
            bottom: MediaQuery.of(context).size.height * .02),
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 12,
            ),
            Flexible(
                child: Text(
              name,
              style: const TextStyle(
                color: Colors.black54,
                letterSpacing: 0.5,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
