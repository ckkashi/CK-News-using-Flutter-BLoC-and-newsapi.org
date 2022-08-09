import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/constants.dart';
import 'package:sizer/sizer.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushNamedAndRemoveUntil(
            context, '/connectivity', (route) => false,
            arguments: {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        child: Stack(
          children: [
            SizedBox(
                width: 100.w,
                height: 100.h,
                child: Image.asset(
                  'assets/background.jpg',
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                )),
            Container(
              color: Colors.black.withOpacity(0.75),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        'CK\nNews',
                        // style: GoogleFonts.lato(
                        //     textStyle: TextStyle(
                        //         color: Constants.TEXT_COLOR, fontSize: 50.sp)),
                        style: TextStyle(
                            color: Constants.TEXT_COLOR, fontSize: 50.sp),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        width: 30.w,
                        height: 30.w,
                        child: SpinKitFadingCube(color: Constants.TEXT_COLOR),
                      )
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
