import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtimechatapp/ChatDb.dart';
import 'package:realtimechatapp/EditDailog.dart';
import 'package:realtimechatapp/Messages.dart';
import 'package:realtimechatapp/PopumMenu.dart';
import 'package:realtimechatapp/state/user/UserCubit.dart';
import 'package:intl/intl.dart';
import "dart:developer";

class ChatMessage extends StatefulWidget {
  ChatMessage(
      {super.key,
      required this.message,
      required this.chatId,
      required this.prevMessage,
      required this.scrollController});
  dynamic message;
  String chatId;
  String prevMessage;
  ScrollController scrollController;

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  late Messages message;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted == true) {
      setState(() {
        message = ChatDb().getMessage(widget.message);
        loading = false;
      });
    }
  }

  void selected(String value) {
    if (value == "edit") {
      showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
                child: EditDailog(
                  prevText: message.message,
                  chatId: widget.chatId,
                  messageId: message.id,
                  chatLastMessage: widget.prevMessage,
                ),
              ));
    } else if (value == "delete") {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Delete Message'),
          content: Text("the message ${message.message} will be deleted"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                bool data = await ChatDb().deleteMessage(
                    widget.chatId,
                    message.id,
                    context.read<UserCubit>().state!.id,
                    widget.prevMessage,
                    message.message);
                Navigator.pop(context, 'ok');

                if (data == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("message deleted")));
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _scrollToBottom() {
    widget.scrollController
        .jumpTo(widget.scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? const CircularProgressIndicator()
        : Align(
            alignment: message.senderId == context.read<UserCubit>().state!.id
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: message.senderId == context.read<UserCubit>().state!.id
                ? CustomPopumMenu(
                    icon: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          color: message.senderId ==
                                  context.read<UserCubit>().state!.id
                              ? Colors.green
                              : Theme.of(context).cardTheme.color,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              message.deleted == true
                                  ? "Message Was Deleted"
                                  : message.edited
                                      ? "${message.message} (edited)"
                                      : message.message,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 5),
                                child: Text(
                                  DateFormat("MM-dd HH:mm")
                                      .format(message.created_at.toDate()),
                                  style: const TextStyle(fontSize: 12),
                                )),
                            message.senderId ==
                                    context.read<UserCubit>().state!.id
                                ? message.seen
                                    ? Container(
                                        margin: const EdgeInsets.only(
                                            right: 5, left: 5),
                                        child: const Icon(
                                          Icons.remove_red_eye_sharp,
                                          size: 12,
                                        ),
                                      )
                                    : Container(
                                        margin: const EdgeInsets.only(
                                            right: 5, left: 5),
                                        child: const Icon(
                                          Icons.check,
                                          size: 12,
                                        ),
                                      )
                                : const SizedBox()
                          ],
                        )
                      ],
                    ),
                    fun: selected,
                    data: const [
                      PopupMenuItem(
                        value: "edit",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.edit),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Edit"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "delete",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.delete),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Delete"),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        color: message.senderId ==
                                context.read<UserCubit>().state!.id
                            ? Colors.green
                            : Theme.of(context).cardTheme.color,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4)),
                          child: Text(
                            message.deleted == true
                                ? "Message Was Deleted"
                                : message.edited
                                    ? "${message.message} (edited)"
                                    : message.message,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                DateFormat("MM-dd HH:mm")
                                    .format(message.created_at.toDate()),
                                style: TextStyle(fontSize: 12),
                              )),
                          message.senderId ==
                                  context.read<UserCubit>().state!.id
                              ? message.seen
                                  ? Container(
                                      child: Icon(
                                        Icons.remove_red_eye_sharp,
                                        size: 12,
                                      ),
                                      margin:
                                          EdgeInsets.only(right: 5, left: 5),
                                    )
                                  : Container(
                                      child: Icon(
                                        Icons.check,
                                        size: 12,
                                      ),
                                      margin:
                                          EdgeInsets.only(right: 5, left: 5),
                                    )
                              : SizedBox()
                        ],
                      )
                    ],
                  ),
          );
  }
}
