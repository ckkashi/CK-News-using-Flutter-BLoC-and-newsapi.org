import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/components/everythingNews.dart';
import 'package:news_app/components/topheadlinesNews.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/screens/favourite_news.dart';
import 'package:news_app/screens/sign_in.dart';
import 'package:news_app/screens/sign_up.dart';
import 'package:news_app/screens/user_profile.dart';
import 'package:news_app/services/Blocs/NewsBloc/news_bloc.dart';
import 'package:news_app/services/Blocs/NewsBloc/news_events.dart';
import 'package:news_app/services/Blocs/NewsBloc/news_states.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List catNames = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology'
  ];
  var catValue = 'general';

  List dropDownItems = ['Top-headlines', 'Everything'];

  var dropDownValue = 'Top-headlines';

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  var drawerPages = [SignIn(), SignUp(), FavouriteNews(), UserProfile()];
  int drawerIndex = -1;

  void changeUsername(String newUsername) {
    username = newUsername;
  }

  bool userLoggedIn = false;

  FirebaseAuth authInstance = FirebaseAuth.instance;
  User? userr;
  String? username = 'Not signed in.';
  String? email = '';
  String? profileImgUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authInstance = FirebaseAuth.instance;
    authInstance.idTokenChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          userLoggedIn = true;
          userr = user;
          username = userr!.displayName!;
          email = userr!.email!;
          profileImgUrl = userr!.photoURL;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: PreferredSize(
        preferredSize: Size(100.w, 7.h),
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: IconButton(
                            onPressed: () {
                              _key.currentState!.openDrawer();
                            },
                            icon: Icon(Icons.menu_outlined)),
                        flex: 1,
                      ),
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            Constants.APP_TITLE,
                            style: TextStyle(
                                fontSize: 25.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 5,
                          child: Visibility(
                            visible: drawerIndex == -1,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  underline: null,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp),
                                  iconEnabledColor:
                                      Colors.black.withOpacity(0.8),
                                  iconSize: 20.sp,
                                  value: dropDownValue,
                                  items: dropDownItems
                                      .map((element) => DropdownMenuItem(
                                          value: element, child: Text(element)))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      dropDownValue = value.toString();
                                    });
                                  }),
                            ),
                          ))
                    ],
                  ),
                ),
                flex: 2,
              ),
            ],
          ),
        ),
      ),
      drawer: customDrawer(context),
      body: drawerIndex == -1 ? newsContainer() : drawerPages[drawerIndex],
    );
  }

  SafeArea customDrawer(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 70.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(7.0),
                  ),
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.3,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 20.w,
                  child: profileImgUrl == null
                      ? Icon(
                          Icons.person_off_sharp,
                          color: Colors.black,
                          size: 30.sp,
                        )
                      : Image.network('$profileImgUrl'),
                  foregroundImage: profileImgUrl == null || profileImgUrl == ''
                      ? NetworkImage(
                          'https://www.brookes.ac.uk/assets/0/1425/1426/2147484565/b4ba6acc-f7ff-4a13-9f21-0e83f8c3c9e3.png')
                      : NetworkImage(profileImgUrl.toString()),
                  backgroundColor: Colors.white,
                ),
                accountName: Text(username!),
                accountEmail: Text(email!)),
            ListTile(
              onTap: () {
                setState(() {
                  drawerIndex = -1;
                });
                Navigator.pop(context);
              },
              selected: drawerIndex == -1,
              selectedColor: Colors.black,
              style: ListTileStyle.list,
              leading: Icon(Icons.home_rounded),
              title: Text('Home'),
            ),
            Visibility(
              visible: !userLoggedIn,
              child: ListTile(
                onTap: () {
                  setState(() {
                    drawerIndex = 0;
                  });
                  Navigator.pop(context);
                },
                selected: drawerIndex == 0,
                selectedColor: Colors.black,
                style: ListTileStyle.list,
                leading: Icon(Icons.login_rounded),
                title: Text('Login'),
              ),
            ),
            Visibility(
              visible: !userLoggedIn,
              child: ListTile(
                onTap: () {
                  setState(() {
                    drawerIndex = 1;
                  });
                  Navigator.pop(context);
                },
                selected: drawerIndex == 1,
                selectedColor: Colors.black,
                style: ListTileStyle.list,
                leading: Icon(Icons.person_add_rounded),
                title: Text('Register'),
              ),
            ),
            Visibility(
              visible: userLoggedIn,
              child: ListTile(
                onTap: () {
                  setState(() {
                    drawerIndex = 3;
                  });
                  Navigator.pop(context);
                },
                selected: drawerIndex == 3,
                selectedColor: Colors.black,
                style: ListTileStyle.list,
                leading: Icon(Icons.person_rounded),
                title: Text('Profile'),
              ),
            ),
            Visibility(
              visible: userLoggedIn,
              child: ListTile(
                onTap: () {
                  setState(() {
                    drawerIndex = 2;
                  });
                  Navigator.pop(context);
                },
                selected: drawerIndex == 2,
                selectedColor: Colors.black,
                style: ListTileStyle.list,
                leading: Icon(Icons.favorite),
                title: Text('Favourites'),
              ),
            ),
            Visibility(
              visible: userLoggedIn,
              child: ListTile(
                onTap: () async {
                  await authInstance.signOut();
                  authInstance.idTokenChanges().listen((User? user) {
                    if (user == null) {
                      setState(() {
                        username = 'Not signed in.';
                        email = '';
                        userLoggedIn = false;
                        drawerIndex = -1;
                      });
                    }
                  });

                  Navigator.pop(context);
                },
                style: ListTileStyle.list,
                leading: Icon(Icons.logout_rounded),
                title: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget newsContainer() {
    return Container(
      width: 100.w,
      // color: Colors.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // color: Colors.blue,
            width: 100.w,
            height: 9.h,
            child: Center(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: catNames.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            catValue = catNames[index];
                          });
                          BlocProvider.of<NewsBloc>(context)
                              .add(NewsLoadEvent(dropDownValue, catValue));
                        },
                        child: Container(
                          // width: 40.w,
                          height: 7.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.sp),
                            color: Colors.black,
                            // boxShadow: [
                            //   BoxShadow(
                            //       blurRadius: 1,
                            //       color: Colors.black.withOpacity(1),
                            //       spreadRadius: 1)
                            // ]
                          ),
                          child: Center(
                              child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              '${catNames[index][0].toUpperCase()}${catNames[index].substring(1)}',
                              style: TextStyle(
                                letterSpacing: 1,
                                fontSize: 15.sp,
                                color: Colors.white,
                              ),
                            ),
                          )),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          dropDownValue == 'Top-headlines'
              ? TopheadlinesNews(catValue)
              : EverythingNews(catValue),
        ],
      ),
    );
  }
}
