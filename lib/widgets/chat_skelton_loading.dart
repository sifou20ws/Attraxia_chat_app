import 'package:attraxia_chat_app/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChatSkeltonWidget extends StatelessWidget {
  ChatSkeltonWidget({this.height = 188});

  final double height;

  List<MessageBubble> messages = [
    MessageBubble(
        message: '                   ', time: '', user: true, read: true),
    MessageBubble(
        message: '                           ',
        time: '',
        user: false,
        read: true),
    MessageBubble(
        message:
        '                \n                                                    ',
        time: '',
        user: true,
        read: true),
    MessageBubble(
        message: '                   ', time: '', user: false, read: true),
    MessageBubble(
        message: '                  ', time: '', user: true, read: true),
    MessageBubble(
        message: '                                             ',
        time: '',
        user: false,
        read: true),
    MessageBubble(
        message:
        '                \n                                                    ',
        time: '',
        user: true,
        read: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView(
        reverse: true,
        children: messages,
      ),
    );
  }
}
