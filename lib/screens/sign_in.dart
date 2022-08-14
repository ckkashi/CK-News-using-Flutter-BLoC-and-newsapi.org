import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:sizer/sizer.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 81.h,
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: ClipPath(
              clipper: WaveClipperTwo(flip: false, reverse: true),
              child: Container(
                width: 100.w,
                height: 9.h,
                color: Colors.black.withOpacity(1.0),
              ),
            ),
          ),
        ),
        Positioned(
          top: 79.h,
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: ClipPath(
              clipper: WaveClipperTwo(flip: false, reverse: true),
              child: Container(
                width: 100.w,
                height: 11.h,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ),
        ),
        Positioned(
          top: 77.h,
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: ClipPath(
              clipper: WaveClipperTwo(flip: false, reverse: true),
              child: Container(
                width: 100.w,
                height: 13.h,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
        ),
        form(),
      ],
    );
  }

  Positioned form() {
    return Positioned(
      top: 20.h,
      left: 0,
      right: 0,
      child: Container(
        width: 100.w,
        // height: 90.h,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'LOGIN',
                  style:
                      TextStyle(fontSize: 45.sp, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 2.h),
              dataField('E-mail', emailController, false),
              SizedBox(height: 1.5.h),
              dataField('Password', passController, true),
              SizedBox(height: 1.5.h),
              CircleAvatar(
                backgroundColor: Colors.black,
                radius: 23.sp,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20.sp,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container dataField(
      String fieldName, TextEditingController controller, bool password) {
    return Container(
      width: 90.w,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        child: TextFormField(
          controller: controller,
          obscureText: password,
          cursorColor: Colors.black,
          cursorHeight: 18.sp,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
          ),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter $fieldName',
              hintStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
