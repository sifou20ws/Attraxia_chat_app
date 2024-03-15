import 'package:attraxia_chat_app/core/app_export.dart';

class MessageBlock extends StatelessWidget {
  const MessageBlock({
    Key? key,
    required this.messageController,
    required this.onTap,
  }) : super(key: key);

  final TextEditingController messageController;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
            onTap: onTap,
            height: 53.h,
            width: 53.w,
            padding: EdgeInsets.all(15.w),
            child: CustomImageView(imagePath: ImageConstant.imgSend),
          ),
        )
      ],
    );
  }
}
