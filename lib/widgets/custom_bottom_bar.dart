import 'package:attraxia_chat_app/controllers/home_controller.dart';
import 'package:attraxia_chat_app/core/constants/colors.dart';
import 'package:attraxia_chat_app/core/utils/image_constant.dart';
import 'package:attraxia_chat_app/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;
  HomeController homeCntrl = Get.find();

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      title: "User 1",
      type: BottomBarEnum.User1,
      count: 5,
    ),
    BottomMenuModel(
      title: "User 2",
      count: 0,
      type: BottomBarEnum.User2,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.h,
      decoration: BoxDecoration(
        color: gray50,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Badge(
                  // isLabelVisible: bottomMenuList[index].count !=0,
                  isLabelVisible: index == 0
                      ? homeCntrl.user1Count != 0
                      : homeCntrl.user2Count != 0,
                  label: Text(
                    index==0 ? "${homeCntrl.user1Count}" : "${homeCntrl.user2Count}" ,
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: blueGray700,
                  child: Icon(
                    Icons.person_outline,
                    color: blueGray70001,
                    size: 30.w,
                  ),
                ),
                Text(
                  bottomMenuList[index].title,
                  style: TextStyle(
                    color: blueGray70001,
                    fontSize: 14.sp,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Badge(
                  // isLabelVisible: bottomMenuList[index].count != 0,
                  isLabelVisible: index == 0
                      ? homeCntrl.user1Count != 0
                      : homeCntrl.user2Count != 0,
                  label: Text(
                    index==0 ? "${homeCntrl.user1Count}" : "${homeCntrl.user2Count}" ,
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: blueGray700,
                  child: Icon(
                    Icons.person,
                    color: blueGray700,
                    size: 30.w,
                  ),
                ),
                Text(
                  bottomMenuList[index].title,
                  style: TextStyle(
                    color: blueGray700,
                    fontSize: 18.sp,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

enum BottomBarEnum {
  User1,
  User2,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.title,
    required this.type,
    required this.count,
  });

  String title;
  int count;
  BottomBarEnum type;
}
