import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  TextInputType keyboardType;
  bool obscureText;
  bool? isUser;
  Widget? suffix;
  double? size;
  CustomTextField(
      {super.key,
      this.isUser,
      this.size,
      this.suffix,
      required this.controller,
      required this.hintText,
      required this.keyboardType,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: TextFormField(
        validator: (value) {
          if (hintText == 'رقم الهاتف') {
            if (value!.length! < 10) {
              return 'الرجاء ادخال رقم صحيح';
            }
            return null;
          } else {
            if (value!.length < 3) {
              return 'الرجاء ادخال اسم مستخدم صحيح';
            }
            return null;
          }
        },
        // inputFormatters: isUser == null
        //     ? null
        //     : <TextInputFormatter>[
        //         FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))
        //       ],
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(color: Colors.indigo, fontSize: 15.sp),
        decoration: InputDecoration(
          errorStyle: const TextStyle(fontFamily: 'Almarai'),
          contentPadding: EdgeInsets.symmetric(vertical: 3.w, horizontal: 10.w),

          constraints: BoxConstraints(maxHeight: size ?? 60.w, maxWidth: 340.w),

          filled: true,
          //   focusColor: AppColors.orange,

          fillColor: Colors.white,
          //  iconColor: AppColors.orange,
          //  labelStyle: TextStyle(color: AppColors.orange),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(
              color: Colors.indigo,
            ),
          ),
          suffixIcon: suffix,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.indigo,
            ),
            borderRadius: BorderRadius.circular(15.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(
              color: Colors.indigo,
            ),
          ),

          hintText: hintText,
        ),
      ),
    );
  }
}
