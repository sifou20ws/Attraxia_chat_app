import 'package:attraxia_chat_app/core/app_export.dart';

class AppRoutes {
  static const String homeScreen = '/home_screen';

  static const String userOnePage = '/user_one_screen';

  static const String userTwoPage = '/user_two_page';

  static const String userContainerPage = '/user_container_page';

  static Map<String, WidgetBuilder> routes = {
    homeScreen: (context) => ShowCaseWidget(
          builder: Builder(
            builder: (context) => HomeScreen(),
          ),
        ),
    userOnePage: (context) => UserOneScreen(),
    userTwoPage: (context) => UserTwoScreen(),
    userContainerPage: (context) => UserContainerScreen(),
  };
}
