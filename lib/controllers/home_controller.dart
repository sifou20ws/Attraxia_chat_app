import 'package:attraxia_chat_app/core/app_export.dart';

class HomeController extends GetxController {
  
  String _selectedChatId = '' ;
  String get selectedChatId => _selectedChatId;
  void updateChatId({required String chatId}){
    _selectedChatId = chatId ;
    update();
  }

  String _selectedChatName = '' ;
  String get selectedChatName => _selectedChatName;
  void updateChatName({required String chatName}){
    _selectedChatName = chatName ;
    update();
  }

  int _user1Count = 0 ;
  int get user1Count => _user1Count ;
  void updateUser1Count({required int count}){
    _user1Count = count ;
    update();
  }

  int _user2Count = 0;
  int get user2Count => _user2Count ;
  void updateUser2Count({required int count}){
    _user2Count = count ;
    update();
  }


  List<MessageModel> _messagesList = [];
  List<MessageModel> get  messagesList => _messagesList;
  void updateMsgList({required List<MessageModel> messages }){
    _messagesList = messages ;
    update();
  }
  void clearMsgList(){
    _messagesList = [] ;
  }

  bool _loading = false ;
  bool get loading => _loading;
  void updateLoading(bool value){
    _loading = value ;
    // update();
  }
  // List<MessageBubble> _chats =[];
  // List<MessageBubble> get chats => _chats;
  // void updateChats({required MessageBubble chat }){
  //   _chats.add(chat);
  //   update();
  // }
}