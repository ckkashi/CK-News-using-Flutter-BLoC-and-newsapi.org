import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/components/everythingNews.dart';
import 'package:news_app/components/topheadlinesNews.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/screens/favourite_news.dart';
import 'package:news_app/screens/sign_in.dart';
import 'package:news_app/screens/sign_up.dart';
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

  var drawerPages = [SignIn(), SignUp(), const FavouriteNews()];
  int drawerIndex = -1;

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
        width: 80.w,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const UserAccountsDrawerHeader(
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
                accountName: Text('data'),
                accountEmail: Text('data@mail.com')),
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
            ListTile(
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
            ListTile(
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
            ListTile(
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
            ListTile(
              onTap: () {
                print('Logout');
                Navigator.pop(context);
              },
              style: ListTileStyle.list,
              leading: Icon(Icons.logout_rounded),
              title: Text('Logout'),
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
