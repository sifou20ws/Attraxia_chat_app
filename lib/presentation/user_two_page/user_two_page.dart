import 'package:attraxia_chat_app/core/app_export.dart';

// ignore_for_file: must_be_immutable
class UserTwoScreen extends StatelessWidget {
  UserTwoScreen({Key? key}) : super(key: key);

  TextEditingController messageController = TextEditingController();
  HomeController homeCntrl = Get.find();

  List<MessageBubble> messages = [];

  List<Widget> messageBubbles = [];
  List<MessageModel> _messagesList = [];

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection("Messages")
            .doc(homeCntrl.selectedChatId)
            .collection('Messages_list')
            .orderBy('time', descending: true)
            .snapshots(), // strean to listen to the collection of messages of the selected chat
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            homeCntrl.updateLoading(true);
          }
          if (snapshot.hasData) {
            // if there is data store it in the message list
            _messagesList = [];
            for (QueryDocumentSnapshot<Map<String, dynamic>> doc
            in snapshot.data!.docs) {
              _messagesList.add(MessageModel.fromJson(doc.data()));
            }
            // and update the variable in the getX controller to access it from the users pages
            homeCntrl.updateMsgList(messages: _messagesList);
            homeCntrl.updateLoading(false);
            messageBubbles=[];
            updateReadStatus();
          }
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 3.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: messageBubbles.isEmpty
                          ? homeCntrl.loading
                              ? ChatSkeltonWidget()
                              : Center(
                                  child: Text(
                                    'Start by writing your first message',
                                    style: TextStyle(
                                      color: blueGray,
                                      fontSize: 16.sp,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                          : ListView(
                              reverse: true,
                              children: messageBubbles,
                            ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  _buildMessageBlock(context),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  void updateReadStatus() {
    print('----------------------------------------');
    // A function to update the read status of unread messages
    // and group the messages by date

    // A map to group the messages by date
    // each date will have a list of messages
    Map<String, List<MessageModel>> groupedMessages = {};

    DocumentReference document = FirebaseFirestore.instance
        .collection('Messages')
        .doc(homeCntrl.selectedChatId);

    for (int i = 0; i < homeCntrl.messagesList.length; i++) {

      if (homeCntrl.messagesList[i].sender == 'user1' &&
          !homeCntrl.messagesList[i].read) {
        // If the message is from user 2 and it is marked as unread,
        // update it to read
        document
            .collection('Messages_list')
            .doc(homeCntrl.messagesList[i].messageId)
            .update({'read': true});
      }

      String date = timeStampToDate(homeCntrl.messagesList[i].time);
      groupedMessages.putIfAbsent(date, () => []);
      groupedMessages[date]!.add(homeCntrl.messagesList[i]);
    }

    groupedMessages.forEach(
      (date, messages) {
        messageBubbles.addAll(
          messages.map(
            (message) => MessageBubble(
              message: message.message,
              time: timeStampToTime(message.time),
              user: message.sender == 'user2',
              read: message.read,
            ),
          ),
        );
        messageBubbles.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Center(
              child: Text(
                date,
                style: TextStyle(
                  color: blueGray.withOpacity(0.5),
                  fontSize: 14.sp,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );

    // Update the user count to 0 (No unread messages).
    document.update({'user2_count': 0});
  }

  Widget _buildMessageBlock(BuildContext context) {
    return MessageBlock(
      messageController: messageController,
      onTap: () async {
        if (messageController.text.isNotEmpty) {
          FireStoreServices services = FireStoreServices();
          services.sendMessage(
            message: messageController.text,
            sender: 'user2',
            selectedChat: homeCntrl.selectedChatId,
            userCount: homeCntrl.user1Count,
            userCountN: 'user1_count',
          );
          messageController.clear();
        }
      },
    );
  }
}
