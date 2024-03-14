import 'package:attraxia_chat_app/presentation/home_screen/home_screen.dart';
import 'package:attraxia_chat_app/presentation/user_container_screen/user_container_screen.dart';
import 'package:attraxia_chat_app/presentation/user_one_screen/user_one_screen.dart';
import 'package:attraxia_chat_app/presentation/user_two_page/user_two_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String homeScreen = '/home_screen';

  static const String userOnePage = '/user_one_screen';

  static const String userTwoPage = '/user_two_page';

  static const String userContainerPage = '/user_container_page';

  // static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    homeScreen: (context) => HomeScreen(),
    userOnePage: (context) => UserOneScreen(),
    userTwoPage: (context) => UserTwoScreen(),
    userContainerPage: (context) => UserContainerScreen(),
  };
}
