import 'package:attraxia_chat_app/controllers/home_controller.dart';
import 'package:attraxia_chat_app/core/constants/colors.dart';
import 'package:attraxia_chat_app/presentation/user_container_screen/user_container_screen.dart';
import 'package:attraxia_chat_app/widgets/custom_elevated_button.dart';
import 'package:attraxia_chat_app/widgets/custom_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

import 'package:get/get.dart';

// ignore_for_file: must_be_immutable
class AddChatDialogue extends StatefulWidget {
  AddChatDialogue({Key? key}) : super(key: key);

  @override
  State<AddChatDialogue> createState() => _AddChatDialogueState();
}

class _AddChatDialogueState extends State<AddChatDialogue> {
  HomeController homeCntrl = Get.find();

  TextEditingController nameController = TextEditingController();
  bool loading = false ;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
            sigmaX: 10, sigmaY: 10, tileMode: TileMode.decal),
        child: Container(
          width: 336.w,
          height: 200.h,
          margin: EdgeInsets.symmetric(
            horizontal: 27.w,
            vertical: 260.h,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 28.w,
            vertical: 20.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.w),
            boxShadow: [
              BoxShadow(
                color: grey40.withOpacity(0.04),
                spreadRadius: 2.h,
                blurRadius: 2.h,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 24.h,
                child: FittedBox(
                  child: Text(
                    'Add chat',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: zinc500,
                      fontFamily: 'Urbanist',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              CostumeTextField(
                width: 280.w,
                height: 42.h,
                controller: nameController,
                hint: "Chat name",
                onChanged: (value) {},
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 25.h),
              CustomElevatedButton(
                height: 38.h,
                text: "Create chat",
                color: blueGray700,
                loading:loading,
                onTap: () async {
                  loading = true ;
                  setState(() {});
                  DocumentReference doc = await FirebaseFirestore.instance.collection("Messages").add({
                    'chat_name': nameController.text,
                    'user1_count': 0,
                    'user2_count': 0,
                    'created': DateTime.now(),
                    'updated': DateTime.now(),
                    'chat_id' : '',
                  });
                  await FirebaseFirestore.instance.collection("Messages").doc(doc.id).update({
                    'chat_id': doc.id ,
                  });
                  homeCntrl.updateChatId(chatId: doc.id);
                  homeCntrl.updateChatName(chatName: nameController.text);
                  Get.to(UserContainerScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
