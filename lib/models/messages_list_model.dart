import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final Timestamp time;
  final String message ,messageId;
  final String sender;
  final bool read;

  MessageModel({
    required this.time,
    required this.message,
    required this.messageId,
    required this.sender,
    required this.read,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      time: json['time'] ?? Timestamp(0, 0),
      message: json['message'] ?? '',
      messageId: json['message_id'] ?? '',
      sender: json['sender'] ?? '',
      read: json['read'] ?? false,
    );
  }
}
