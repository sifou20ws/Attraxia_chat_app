import 'package:attraxia_chat_app/core/app_export.dart';

// ignore_for_file: must_be_immutable
class CostumeTextField extends StatelessWidget {
  CostumeTextField({
    this.controller,
    this.height = 48,
    this.width = 320,
    this.keyboardType = TextInputType.text,
    this.hint,
    this.textInputAction,
    this.obscureText = false,
    this.suffix,
    this.inputFormatters,
    this.onChanged,
    this.maxLines =1,
    this.initialValue,
    this.enabled =true,
  });
  TextEditingController? controller;
  List<TextInputFormatter>? inputFormatters ;
  final double height , width ;
  final TextInputType keyboardType;
  String? hint ;
  TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? suffix ;
  Function(String)? onChanged;
  int maxLines ;
  String? initialValue ;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      // decoration: BoxDecoration(
      //   boxShadow: [
      //     BoxShadow(
      //       color: const Color(0xFF404040).withOpacity(0.06),
      //       spreadRadius: 0,
      //       blurRadius: 2.h,
      //       offset:  Offset(0,0), // changes position of shadow
      //     ),
      //     BoxShadow(
      //       color: const Color(0xFF404040).withOpacity(0.02),
      //       spreadRadius: 0,
      //       blurRadius: 6.h,
      //       offset: Offset(-3,0.h), // changes position of shadow
      //     ),
      //   ],
      // ),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        initialValue: initialValue,
        // focusNode: focusNode ?? FocusNode(),
        // autofocus: autofocus!,
        onChanged: onChanged,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
          color: zinc700,
          fontFamily: 'Urbanist',
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        inputFormatters:inputFormatters,
        maxLines: maxLines,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: zinc400,
            fontFamily: 'Urbanist',
          ),
          isDense: true,
          fillColor:white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            // borderSide: BorderSide.none,
            borderSide: BorderSide(
              color: gray300,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            // borderSide: BorderSide.none,
            borderSide: BorderSide(
              color: gray300,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            // borderSide: BorderSide.none,
            borderSide: BorderSide(
              color: gray300,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            // borderSide: BorderSide.none,
            borderSide: BorderSide(
              color: gray300,
              width: 1,
            ),
          ),
          suffixIcon: suffix ,
          suffixIconConstraints : BoxConstraints(maxHeight: 42.h),
          suffixStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
            color: zinc900,
            fontFamily: 'Urbanist',
          ),
        ),
        // validator: validator,
      ),
    );
  }
}
