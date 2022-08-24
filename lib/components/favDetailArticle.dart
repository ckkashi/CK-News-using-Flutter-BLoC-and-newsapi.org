import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Model/NewsEverythingModel.dart';
import 'package:news_app/Model/NewsModel.dart';
import 'package:sizer/sizer.dart';

class FavDetailArticle extends StatefulWidget {
  final newsData;
  final newsID;
  FavDetailArticle(this.newsData, this.newsID, {Key? key}) : super(key: key);

  @override
  State<FavDetailArticle> createState() => _FavDetailArticleState();
}

class _FavDetailArticleState extends State<FavDetailArticle> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  bool userAvail = false;

  @override
  void dispose() {
    firebaseFirestore.clearPersistence();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    firebaseAuth.idTokenChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          userAvail = true;
        });
      } else {
        userAvail = false;
      }
    });
  }

  Future<bool> checkNewsAlreadyExist(String uid, String newsTitle) async {
    print({uid, newsTitle});
    QuerySnapshot snapshot = await firebaseFirestore
        .collection('usersFavPosts')
        .where('title', isEqualTo: newsTitle + "")
        .where('uid', isEqualTo: uid)
        .get();
    print(snapshot.docs.length > 0);
    return snapshot.docs.length > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: 100.w,
                  height: 43.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(widget.newsData['urlToImage']),
                        fit: BoxFit.cover,
                        opacity: 0.8,
                      ),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.8),
                            spreadRadius: 0.1)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 4.h),
                            width: 6.h,
                            height: 6.h,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                shape: BoxShape.circle),
                            child: Center(
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.arrow_back_rounded,
                                      size: 20.sp,
                                      color: Colors.white.withOpacity(1.0))),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 4.h),
                            width: 6.h,
                            height: 6.h,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                shape: BoxShape.circle),
                            child: Center(
                              child: IconButton(
                                  onPressed: () async {
                                    print('Add to fav');

                                    if (userAvail == true) {
                                      try {
                                        await firebaseFirestore
                                            .collection('usersFavPosts')
                                            .doc(widget.newsID)
                                            .delete();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              'News remove from favourite list.'),
                                          backgroundColor: Colors.red,
                                        ));
                                        Navigator.pop(context);
                                      } on FirebaseException catch (e) {
                                        print(e.toString());
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('User is not signed in.'),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                  },
                                  icon: Icon(Icons.delete_outline_outlined,
                                      size: 20.sp,
                                      color: Colors.white.withOpacity(1.0))),
                            ),
                          ),
                        ],
                      ),
                      headingBadge('', Colors.red),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 37.h,
              bottom: 1.h,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 100.w,
                  height: 55.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.8),
                            spreadRadius: 0.1)
                      ]),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // headingBadge(widget.newsData.source!.name.toString(),
                        //     Colors.black.withOpacity(0.5)),
                        headingBadge('Title', Colors.black),
                        detailsText(widget.newsData['title']),
                        headingBadge('Description', Colors.black),
                        detailsText(widget.newsData['description']),
                        headingBadge('Content', Colors.black),
                        detailsText(widget.newsData['content']),
                        headingBadge('Author', Colors.black),
                        detailsText(widget.newsData['author']),
                        headingBadge('Article url', Colors.black),
                        detailsText(widget.newsData['url']),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding detailsText(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      child: Text(
        text == 'null' ? 'Not defined' : text,
        textAlign: TextAlign.justify,
        style: TextStyle(
            letterSpacing: 0.1,
            fontWeight: FontWeight.w300,
            fontSize: 16.sp,
            color: Colors.black.withOpacity(0.85)),
      ),
    );
  }

  Row headingBadge(String heading, Color color) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.sp),
              color: color,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                heading,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
