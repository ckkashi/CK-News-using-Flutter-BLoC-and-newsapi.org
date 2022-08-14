import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:news_app/screens/user_profile.dart';
import 'package:sizer/sizer.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  bool emailValidator(String email) =>
      RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(email);

  bool userLoggedIn = false;

  FirebaseAuth authInstance = FirebaseAuth.instance;

  bool loadingIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authInstance = FirebaseAuth.instance;
    authInstance.idTokenChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          userLoggedIn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.text = '';
    passController.text = '';
  }

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
        !userLoggedIn ? form(context) : UserProfile(),
      ],
    );
  }

  Positioned form(BuildContext context) {
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
              GestureDetector(
                onTap: () async {
                  String email = emailController.text;
                  String password = passController.text;
                  if (email.isNotEmpty && emailValidator(email)) {
                    // print('email is valid');
                    if (password.length > 7) {
                      print('pass is valid');
                      setState(() {
                        loadingIn = true;
                      });
                      try {
                        var credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email, password: password);
                        print({"user": credential.user});
                        await authInstance
                            .idTokenChanges()
                            .listen((User? user) {
                          if (user != null) {
                            setState(() {
                              userLoggedIn = true;
                            });
                          }
                        });
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/connectivity', (route) => false);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('User successfully logged in.'),
                          backgroundColor: Colors.green,
                        ));
                        setState(() {
                          loadingIn = false;
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                          setState(() {
                            loadingIn = false;
                          });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('No user found for that email.'),
                            backgroundColor: Colors.red,
                          ));
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                          setState(() {
                            loadingIn = false;
                          });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text('Wrong password provided for that user.'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Please enter password of atleast 8 or more character'),
                        backgroundColor: Colors.red,
                      ));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please enter valid email address'),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 23.sp,
                  child: loadingIn
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20.sp,
                          color: Colors.white,
                        ),
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
