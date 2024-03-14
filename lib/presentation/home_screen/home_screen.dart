import 'package:attraxia_chat_app/controllers/home_controller.dart';
import 'package:attraxia_chat_app/core/constants/colors.dart';
import 'package:attraxia_chat_app/core/utils/image_constant.dart';
import 'package:attraxia_chat_app/models/chat_model.dart';
import 'package:attraxia_chat_app/presentation/home_screen/widgets/add_chat_dialog.dart';
import 'package:attraxia_chat_app/presentation/user_container_screen/user_container_screen.dart';
import 'package:attraxia_chat_app/routes/app_routes.dart';
import 'package:attraxia_chat_app/widgets/custom_image_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'widgets/accueil_item_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  HomeController homeCntrl = Get.put(HomeController());

  List<ChatModel> chats = [];

  @override
  Widget build(BuildContext context) {
    homeCntrl.updateMsgList(messages: []);
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection("Messages")
          .orderBy("created", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          chats = [];
          List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
              snapshot.data!.docs;
          for (QueryDocumentSnapshot<Map<String, dynamic>> doc in data) {
            chats.add(ChatModel.fromJson(doc.data()));
          }
        }
        return SafeArea(
          child: Scaffold(
            body: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 25.w,
                vertical: 22.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CustomImageView(
                      imagePath: ImageConstant.logo,
                      width: 190.w,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text("Chat List",
                      style: TextStyle(
                        color: blueGray70001,
                        fontSize: 18.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(height: 5.h),
                  Expanded(child: _buildAccueil(context)),
                ],
              ),
            ),
            floatingActionButton: Container(
              margin: EdgeInsets.all(10.w),
              child: FloatingActionButton(
                backgroundColor: blueGray700,
                tooltip: 'Start a new chat',
                onPressed: () async {
                  // Navigator.pushNamed(context, AppRoutes.userContainerPage);
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Material(
                        color: Colors.transparent,
                        child: StatefulBuilder(builder:
                            (BuildContext context, StateSetter myState) {
                          return Container(
                            color: Colors.transparent,
                            child: AddChatDialogue(),
                          );
                        }),
                      );
                    },
                  );
                },
                child: const Icon(Icons.chat, color: Colors.white, size: 28),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAccueil(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return SizedBox(height: 10.h);
      },
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            homeCntrl.updateChatId(chatId: chats[index].chatId);
            homeCntrl.updateChatName(chatName: chats[index].chatName);
            // Navigator.pushNamed(context, AppRoutes.userContainerPage);
            Get.to(() => UserContainerScreen());
          },
          child: ChatWidget(chat: chats[index]),
        );
      },
    );
  }
}
