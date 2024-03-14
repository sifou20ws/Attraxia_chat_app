import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final int user2Count;
  final Timestamp created;
  final int user1Count;
  final Timestamp updated;
  final String chatName;
  final String chatId;

  ChatModel({
    required this.user2Count,
    required this.created,
    required this.user1Count,
    required this.updated,
    required this.chatName,
    required this.chatId,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      user2Count: json['user2_count'] ?? 0,
      created: json['created'] ?? Timestamp(0, 0),
      user1Count: json['user1_count'] ?? 0,
      updated: json['updated'] ?? Timestamp(0, 0),
      chatName: json['chat_name'] ?? '',
      chatId: json['chat_id'] ?? '',
    );
  }
}
