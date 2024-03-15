import 'package:attraxia_chat_app/core/app_export.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ChatWidget extends StatelessWidget {
  ChatWidget({Key? key, required this.chat, required this.onTap}) : super(key: key);

  final ChatModel chat;
  final Function() onTap ;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            flex: 2,
            onPressed: (context) => deleteChat(chat.chatId),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 338.w,
          decoration: BoxDecoration(
            color: Purple.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(chat.chatName,
                          style: TextStyle(
                            color: black,
                            fontSize: 18.sp,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                          )),
                      Text(
                        'Created on : ' + timeStampToDate(chat.created),
                        style: TextStyle(
                          color: zinc500,
                          fontSize: 16.sp,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                CustomImageView(
                  imagePath: ImageConstant.imgSend,
                  color: blueGray,
                  width: 30.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  deleteChat(String chatId) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(10.w),
      middleText: 'Are you sure you want to delete this chat?',
      middleTextStyle: TextStyle(
        color: blueGray,
        fontSize: 18.sp,
        fontFamily: 'Urbanist',
        fontWeight: FontWeight.w600,
      ),
      confirm: CustomElevatedButton(
        width: 100.w,
        text: 'Yes',
        onTap: () async {
          FireStoreServices services = FireStoreServices();
          await services.deleteChat(chatId: chatId);
          Get.back();
        },
        color: blueGray,
      ),
      cancel: CustomElevatedButton(
        width: 100.w,
        text: 'Cancel',
        textStyle: TextStyle(color: blueGray),
        onTap: () {
          Get.back();
        },
        color: Colors.white,
      ),
    );
  }
}
