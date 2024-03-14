import 'package:attraxia_chat_app/controllers/home_controller.dart';
import 'package:attraxia_chat_app/core/utils/image_constant.dart';
import 'package:attraxia_chat_app/models/chat_model.dart';
import 'package:attraxia_chat_app/models/messages_list_model.dart';
import 'package:attraxia_chat_app/presentation/home_screen/home_screen.dart';
import 'package:attraxia_chat_app/presentation/user_one_screen/user_one_screen.dart';
import 'package:attraxia_chat_app/presentation/user_two_page/user_two_page.dart';
import 'package:attraxia_chat_app/routes/app_routes.dart';
import 'package:attraxia_chat_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:attraxia_chat_app/widgets/app_bar/appbar_title.dart';
import 'package:attraxia_chat_app/widgets/app_bar/custom_app_bar.dart';
import 'package:attraxia_chat_app/widgets/custom_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore_for_file: must_be_immutable
class UserContainerScreen extends StatelessWidget {
  UserContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  HomeController homeCntrl = Get.find();
  ChatModel? chat;

  List<MessageModel> _messagesList = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection("Messages")
          .doc(homeCntrl.selectedChatId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          chat = ChatModel.fromJson(snapshot.data!.data()!);
          homeCntrl.updateUser1Count(count: chat!.user1Count);
          homeCntrl.updateUser2Count(count: chat!.user2Count);
        }
        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("Messages")
              .doc(homeCntrl.selectedChatId)
              .collection('Messages_list')
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _messagesList = [];
              for (QueryDocumentSnapshot<Map<String, dynamic>> doc
                  in snapshot.data!.docs) {
                _messagesList.add(MessageModel.fromJson(doc.data()));
              }
              homeCntrl.updateMsgList(messages: _messagesList);
            }
            return SafeArea(
              child: Scaffold(
                appBar: _buildAppBar(context),
                body: Navigator(
                  key: navigatorKey,
                  // initialRoute: AppRoutes.userOnePage,
                  onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name!),
                    transitionDuration: Duration(seconds: 0),
                  ),
                ),
                bottomNavigationBar: CustomBottomBar(
                  onChanged: (BottomBarEnum type) {
                    print('object');
                    Navigator.pushReplacementNamed(
                      navigatorKey.currentContext!,
                      getCurrentRoute(type),
                    );
                    // Get.off(getCurrentPage(getCurrentRoute(type)));
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 39.w,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        onTap: () {
          Get.off(()=>HomeScreen());
        },
      ),
      centerTitle: true,
      title: AppbarTitle(text: homeCntrl.selectedChatName),
      actions: [],
    );
  }

  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.User1:
        return AppRoutes.userOnePage;
      case BottomBarEnum.User2:
        return AppRoutes.userTwoPage;
      default:
        return "/";
    }
  }

  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.userOnePage:
        return UserOneScreen();
      case AppRoutes.userTwoPage:
        return UserTwoScreen();
      default:
        return UserOneScreen();
    }
  }
}
