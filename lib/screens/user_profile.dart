import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool swtichVal = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void updateUsername() {
    print('updating username');
  }

  void updatePhone() {
    print('updating phone no');
  }

  FirebaseAuth authInstance = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authInstance = FirebaseAuth.instance;
    authInstance.idTokenChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          usernameController.text = user.displayName!;
          phoneController.text = user.phoneNumber!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.black),
              child: ListTile(
                // tileColor: Colors.black,
                title: Text(
                  'User profile',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2.sp),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: ListTile(
              title: Text(
                'Update profile',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.2.sp),
              ),
              trailing: Switch(
                  value: swtichVal,
                  activeColor: Colors.black,
                  onChanged: (val) {
                    setState(() {
                      swtichVal = val;
                    });
                  }),
            ),
          ),
          dataField('Username', usernameController, false, updateUsername),
          SizedBox(height: 1.5.h),
          dataField('Phone no', phoneController, false, updatePhone)
        ],
      ),
    );
  }

  Container dataField(String fieldName, TextEditingController controller,
      bool password, void func()) {
    return Container(
      width: 90.w,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        child: TextFormField(
          enabled: swtichVal,
          controller: controller,
          obscureText: password,
          cursorColor: Colors.black,
          cursorHeight: 18.sp,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
          ),
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    func();
                  },
                  icon: Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.black,
                  )),
              border: InputBorder.none,
              hintText: 'Update $fieldName',
              hintStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
