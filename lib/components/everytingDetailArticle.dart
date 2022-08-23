import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Model/NewsEverythingModel.dart';
import 'package:news_app/Model/NewsModel.dart';
import 'package:sizer/sizer.dart';

class EverythingDetailArticle extends StatefulWidget {
  final newsData;
  EverythingDetailArticle(this.newsData, {Key? key}) : super(key: key);

  @override
  State<EverythingDetailArticle> createState() =>
      _EverythingDetailArticleState();
}

class _EverythingDetailArticleState extends State<EverythingDetailArticle> {
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: 100.w,
                  height: 43.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                      color: Colors.white,
                      image: DecorationImage(
                        image:
                            NetworkImage(widget.newsData.urlToImage.toString()),
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
                                        bool dataAvail =
                                            await checkNewsAlreadyExist(
                                                firebaseAuth.currentUser!.uid,
                                                widget.newsData.title
                                                    .toString());

                                        if (!dataAvail) {
                                          CollectionReference favNewsRef =
                                              firebaseFirestore
                                                  .collection('usersFavPosts');
                                          favNewsRef.add({
                                            "uid": firebaseAuth.currentUser!.uid
                                                .toString(),
                                            "title": widget.newsData.title
                                                .toString(),
                                            "urlToImage": widget
                                                .newsData.urlToImage
                                                .toString(),
                                            "description": widget
                                                .newsData.description
                                                .toString(),
                                            "content": widget.newsData.content
                                                .toString(),
                                            "author": widget.newsData.author
                                                .toString(),
                                            "url":
                                                widget.newsData.url.toString()
                                          }).then((value) {
                                            print(value);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'News added to favourite list.'),
                                              backgroundColor: Colors.green,
                                            ));
                                          }).catchError((error) {
                                            print(error);
                                          });
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                'News already exist in your favourite list.'),
                                            backgroundColor: Colors.red,
                                          ));
                                        }
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
                                  icon: Icon(Icons.favorite_border_outlined,
                                      size: 20.sp,
                                      color: Colors.white.withOpacity(1.0))),
                            ),
                          ),
                        ],
                      ),
                      headingBadge(widget.newsData.source!.name.toString()),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 55.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
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
                        headingBadge('Title'),
                        detailsText(widget.newsData.title.toString()),
                        headingBadge('Description'),
                        detailsText(widget.newsData.description.toString()),
                        headingBadge('Content'),
                        detailsText(widget.newsData.content.toString()),
                        headingBadge('Author'),
                        detailsText(widget.newsData.author.toString()),
                        headingBadge('Article url'),
                        detailsText(widget.newsData.url.toString()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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

  Row headingBadge(String heading) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.sp),
              color: Colors.black,
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
