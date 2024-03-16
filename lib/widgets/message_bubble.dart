import 'package:attraxia_chat_app/core/app_export.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({required this.message,required this.time,required this.user,required this.read});

  final String message, time;

  final bool user, read;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: 250.w,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: user ? gray200 :  Purple,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.h),
              topRight: Radius.circular(15.h),
              bottomRight: Radius.circular(user ? 0 : 15.h),
              bottomLeft:  Radius.circular(user ?15.h:0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 4.h),
              Text(
                message,
                style: TextStyle(
                  color: user ? Colors.black : Colors.white,
                  fontSize: 16.sp,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      color: user? Colors.black45 : Colors.white60,
                      fontSize: 11.sp,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if(user)
                    Text(
                      read ?' • Read' : ' • Sent',
                      style: TextStyle(
                        color: user? Colors.black45 : Colors.white60,
                        fontSize: 11.sp,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
