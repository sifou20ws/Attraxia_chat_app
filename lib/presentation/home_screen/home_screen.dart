import 'widgets/chat_widget.dart';
import 'package:attraxia_chat_app/core/app_export.dart';

class HomeScreen extends StatefulWidget {


  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeCntrl = Get.put(HomeController());

  List<ChatModel> chats = [];

  final GlobalKey _floatingButtonnKey = GlobalKey();
  final GlobalKey _chatListKey = GlobalKey();
  final GlobalKey _chatWidgetKey = GlobalKey();

  void checkFirstUse() async {
    // a function to check if the user is using the app for the first time
    // if true show a tutorial using the ShowCase package.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? firstTime = prefs.getBool('first_time');
    if (firstTime == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          ShowCaseWidget.of(context).startShowCase(
              [_floatingButtonnKey, _chatListKey, _chatWidgetKey]));
      await prefs.setBool('first_time', false);
    }
  }

  @override
  void initState() {
    checkFirstUse();
    super.initState();
  }

  @override
  void dispose() {
    _floatingButtonnKey.currentState?.dispose();
    _chatWidgetKey.currentState?.dispose();
    _chatListKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection("Messages")
          .orderBy("created", descending: true)
          .snapshots(), // the stream that listen for the chats,
      builder: (context, snapshot) {
        homeCntrl.clearMsgList();
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
              padding: EdgeInsets.all(22.h),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  CustomImageView(
                    imagePath: ImageConstant.logo,
                    width: 190.w,
                  ),
                  if (chats.isNotEmpty)
                    Expanded(child: _buildChatList(context)),
                  if (chats.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          'Welcome to attracis chat app! \nStart by creating your first chat using the button below',
                          style: urbanist(16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            floatingActionButton: Showcase(
              key: _floatingButtonnKey,
              description: 'Use this button to create a new chat',
              title: 'Chat Button',
              titleTextStyle: urbanist(16),
              descTextStyle: urbanist(14),
              child: Container(
                margin: EdgeInsets.all(10.w),
                child: FloatingActionButton(
                  backgroundColor: blueGray,
                  tooltip: 'Start a new chat',
                  onPressed: () async {
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
          ),
        );
      },
    );
  }

  Widget _buildChatList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 40.h),
        Text("Chat List", style: urbanist(18)),
        SizedBox(height: 10.h),
        Expanded(
          child: Showcase(
            key: _chatListKey,
            description: 'Select your chat from this list',
            title: 'Chat List',
            titleTextStyle: urbanist(16),
            descTextStyle: urbanist(14),
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10.h);
              },
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return index == 0
                    ? Showcase(
                        key: _chatWidgetKey,
                        description:
                            'Swipe this widget to the left to delete the chat',
                        title: 'Delete chat',
                        titleTextStyle: urbanist(16),
                        descTextStyle: urbanist(14),
                        child: ChatWidget(
                          chat: chats[index],
                          onTap: () {
                            // when a chat is selected update the chat name and chat id in the getX controller
                            // to use it in the next screen
                            homeCntrl.updateChatId(chatId: chats[index].chatId);
                            homeCntrl.updateChatName(
                              chatName: chats[index].chatName,
                            );
                            Get.to(() => UserContainerScreen());
                          },
                        ),
                      )
                    : ChatWidget(
                        chat: chats[index],
                        onTap: () {
                          // when a chat is selected update the chat name and chat id in the getX controller
                          // to use it in the next screen
                          homeCntrl.updateChatId(chatId: chats[index].chatId);
                          homeCntrl.updateChatName(
                              chatName: chats[index].chatName,
                          );
                          Get.to(() => UserContainerScreen());
                        },
                      );
              },
            ),
          ),
        ),
      ],
    );
  }

  TextStyle urbanist(double fSize) {
    return TextStyle(
      color: blueGray,
      fontSize: fSize.sp,
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w600,
    );
  }
}
