import 'package:attraxia_chat_app/core/constants/colors.dart';
import 'package:attraxia_chat_app/core/utils/image_constant.dart';
import 'package:attraxia_chat_app/models/chat_model.dart';
import 'package:attraxia_chat_app/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ChatWidget extends StatelessWidget {
  ChatWidget({Key? key, required this.chat}) : super(key: key);

  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 70.h,
      width: 338.w,
      decoration: BoxDecoration(
        color: deepPurpleA200.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h , horizontal: 20.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.chatName,
                    style: TextStyle(
                      color: black900,
                      fontSize: 18.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                    )
                  ),
                  Text(
                      'Created at : ' +chat.created.toDate().toString(),
                      style: TextStyle(
                        color: zinc500,
                        fontSize: 16.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                      )
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            CustomImageView(
              imagePath: ImageConstant.imgSave,
              color: black900,
              // height: 20.h,
              width: 30.w,
            )
          ],
        ),
      ),
    );
  }
}
