// import 'package:attraxia_chat_app/core/app_export.dart';
//
// // ignore_for_file: must_be_immutable
// class UserContainerScreen extends StatelessWidget {
//   UserContainerScreen({Key? key}) : super(key: key);
//
//   GlobalKey<NavigatorState> navigatorKey = GlobalKey();
//   HomeController homeCntrl = Get.find();
//   ChatModel? chat;
//
//   List<MessageModel> _messagesList = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//       stream: FirebaseFirestore.instance
//           .collection("Messages")
//           .doc(homeCntrl.selectedChatId) // id of the selected chat
//           .snapshots(), // stream to listen to changes in the selected chat (listening for number of unread messages for both users)
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           // is there is data, store itin the chat model
//           chat = ChatModel.fromJson(snapshot.data!.data()!);
//           // and then updat the user1 and user2 count whish represent the number of unread messages
//           homeCntrl.updateUser1Count(count: chat!.user1Count);
//           homeCntrl.updateUser2Count(count: chat!.user2Count);
//         }
//         return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//           stream: FirebaseFirestore.instance
//               .collection("Messages")
//               .doc(homeCntrl.selectedChatId)
//               .collection('Messages_list')
//               .orderBy('time', descending: true)
//               .snapshots(), // strean to listen to the collection of messages of the selected chat
//           builder: (context, snapshot) {
//             if(snapshot.connectionState == ConnectionState.waiting){
//               homeCntrl.updateLoading(true);
//             }
//             if (snapshot.hasData) {
//               // if there is data store it in the message list
//               _messagesList = [];
//               for (QueryDocumentSnapshot<Map<String, dynamic>> doc
//                   in snapshot.data!.docs) {
//                 _messagesList.add(MessageModel.fromJson(doc.data()));
//               }
//               // and update the variable in the getX controller to access it from the users pages
//               homeCntrl.updateMsgList(messages: _messagesList);
//               homeCntrl.updateLoading(false);
//             }
//             return SafeArea(
//               child: Scaffold(
//                 appBar: _buildAppBar(context),
//                 body: Navigator(
//                   key: navigatorKey,
//                   onGenerateRoute: (routeSetting) => PageRouteBuilder(
//                     pageBuilder: (ctx, ani, ani1) =>
//                         getCurrentPage(routeSetting.name!),
//                     transitionDuration: Duration(seconds: 0),
//                   ),
//                 ),
//                 bottomNavigationBar: CustomBottomBar(
//                   onChanged: (BottomBarEnum type) {
//                     Navigator.pushReplacementNamed(
//                       navigatorKey.currentContext!,
//                       getCurrentRoute(type),
//                     );
//                   },
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     // app bar to display the chat name and a back button
//     return CustomAppBar(
//       leadingWidth: 39.w,
//       leading: AppbarLeadingImage(
//         imagePath: ImageConstant.imgArrowLeft,
//         margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
//         onTap: () {
//           Get.off(()=>ShowCaseWidget(
//             builder: Builder(
//               builder: (context) => HomeScreen(),
//             ),
//           ));
//         },
//       ),
//       centerTitle: true,
//       title: AppbarTitle(text: homeCntrl.selectedChatName),
//       actions: [],
//     );
//   }
//
//   String getCurrentRoute(BottomBarEnum type) {
//     switch (type) {
//       case BottomBarEnum.User1:
//         return AppRoutes.userOnePage;
//       case BottomBarEnum.User2:
//         return AppRoutes.userTwoPage;
//       default:
//         return "/";
//     }
//   }
//
//   Widget getCurrentPage(String currentRoute) {
//     switch (currentRoute) {
//       case AppRoutes.userOnePage:
//         return UserOneScreen();
//       case AppRoutes.userTwoPage:
//         return UserTwoScreen();
//       default:
//         return UserOneScreen();
//     }
//   }
//
// }


import 'package:attraxia_chat_app/core/app_export.dart';

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
          .doc(homeCntrl.selectedChatId) // id of the selected chat
          .snapshots(),
      // stream to listen to changes in the selected chat (listening for number of unread messages for both users)
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // is there is data, store itin the chat model
          chat = ChatModel.fromJson(snapshot.data!.data()!);
          // and then updat the user1 and user2 count whish represent the number of unread messages
          homeCntrl.updateUser1Count(count: chat!.user1Count);
          homeCntrl.updateUser2Count(count: chat!.user2Count);
        }
        return SafeArea(
          child: Scaffold(
            appBar: _buildAppBar(context),
            body: Navigator(
              key: navigatorKey,
              onGenerateRoute: (routeSetting) => PageRouteBuilder(
                pageBuilder: (ctx, ani, ani1) =>
                    getCurrentPage(routeSetting.name!),
                transitionDuration: Duration(seconds: 0),
              ),
            ),
            bottomNavigationBar: CustomBottomBar(
              onChanged: (BottomBarEnum type) {
                Navigator.pushReplacementNamed(
                  navigatorKey.currentContext!,
                  getCurrentRoute(type),
                );
              },
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    // app bar to display the chat name and a back button
    return CustomAppBar(
      leadingWidth: 39.w,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        onTap: () {
          Get.off(() => ShowCaseWidget(
            builder: Builder(
              builder: (context) => HomeScreen(),
            ),
          ));
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