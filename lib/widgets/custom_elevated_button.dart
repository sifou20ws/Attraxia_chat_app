import 'package:attraxia_chat_app/core/app_export.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    this.width = 276,
    this.height = 42,
    required this.onTap,
    this.text = "Se connecter",
    this.color ,
    this.elevation = true,
    this.loading = false,
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      color: white,
      fontFamily: 'Urbanist',
    ),
    this.raduis=8,
  });

  final double width, height;
  final Function()? onTap;

  final String text;
  final Color? color;

  final bool elevation;
  final TextStyle textStyle;
  final double raduis;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: elevation ? null : 0,
        ),
        onPressed: onTap,
        child: !loading
            ? SizedBox(
                height: 20.h,
                child: FittedBox(
                  child: Text(
                    text,
                    style: textStyle,
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: white,
                ),
              ),
      ),
    );
  }
}
