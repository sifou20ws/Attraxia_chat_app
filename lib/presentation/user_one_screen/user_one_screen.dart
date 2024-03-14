import 'package:attraxia_chat_app/controllers/home_controller.dart';
import 'package:attraxia_chat_app/core/utils/image_constant.dart';
import 'package:attraxia_chat_app/models/messages_list_model.dart';
import 'package:attraxia_chat_app/presentation/home_screen/home_screen.dart';
import 'package:attraxia_chat_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:attraxia_chat_app/widgets/app_bar/appbar_title.dart';
import 'package:attraxia_chat_app/widgets/app_bar/custom_app_bar.dart';
import 'package:attraxia_chat_app/widgets/custom_icon_button.dart';
import 'package:attraxia_chat_app/widgets/custom_image_view.dart';
import 'package:attraxia_chat_app/widgets/custom_text_form_field.dart';
import 'package:attraxia_chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore_for_file: must_be_immutable
class UserOneScreen extends StatelessWidget {
  UserOneScreen({Key? key}) : super(key: key);

  TextEditingController messageController = TextEditingController();

  HomeController homeCntrl = Get.find();

  @override
  Widget build(BuildContext context) {
    List<MessageBubble> messages = [];

    for (int i = 0; i < homeCntrl.messagesList.length; i++) {
      if (homeCntrl.messagesList[i].sender == 'user2' &&
          !homeCntrl.messagesList[i].read ) {
        FirebaseFirestore.instance
            .collection('Messages')
            .doc(homeCntrl.selectedChatId)
            .collection('Messages_list')
            .doc(homeCntrl.messagesList[i].messageId)
            .update({'read': true});
      }
      MessageBubble chat = MessageBubble(
        message: homeCntrl.messagesList[i].message,
        time:
            '${homeCntrl.messagesList[i].time.toDate().hour}:${homeCntrl.messagesList[i].time.toDate().minute}',
        user: homeCntrl.messagesList[i].sender == 'user1',
        read: homeCntrl.messagesList[i].read,
      );
      messages.add(chat);
    }

    FirebaseFirestore.instance
        .collection('Messages')
        .doc(homeCntrl.selectedChatId)
        .update({'user1_count': 0});

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
                  child: messages.isEmpty
                      ? Center(
                          child: Text('Start by writing your first message'))
                      : ListView(
                          reverse: true,
                          children: messages,
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

  Widget _buildMessageBlock(BuildContext context) {
    return Row(children: [
      Expanded(
        child: CostumeTextField(
          controller: messageController,
          hint: "Type a message ...",
          textInputAction: TextInputAction.done,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: CustomIconButton(
          onTap: () async {
            if (messageController.text.isNotEmpty) {
              DocumentReference doc = await FirebaseFirestore.instance
                  .collection('Messages')
                  .doc(homeCntrl.selectedChatId)
                  .collection('Messages_list')
                  .add(
                {
                  'message': messageController.text,
                  'sender': 'user1',
                  'time': DateTime.now(),
                  'read': false,
                  'message_id': '',
                },
              );
              await FirebaseFirestore.instance
                  .collection('Messages')
                  .doc(homeCntrl.selectedChatId)
                  .collection('Messages_list')
                  .doc(doc.id)
                  .update({'message_id': doc.id});

              await FirebaseFirestore.instance
                  .collection('Messages')
                  .doc(homeCntrl.selectedChatId)
                  .update(
                {
                  'user2_count': homeCntrl.user2Count + 1,
                },
              );
              messageController.clear();
            }
          },
          height: 53.h,
          width: 53.w,
          padding: EdgeInsets.all(15.w),
          child: CustomImageView(imagePath: ImageConstant.imgSave),
        ),
      )
    ]);
  }
}