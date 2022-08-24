import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Model/NewsEverythingModel.dart';
import 'package:news_app/components/everythingArticle.dart';
import 'package:news_app/components/favArticle.dart';
import 'package:news_app/screens/loading.dart';
import 'package:sizer/sizer.dart';

class FavouriteNews extends StatefulWidget {
  FavouriteNews({Key? key}) : super(key: key);

  @override
  State<FavouriteNews> createState() => _FavouriteNewsState();
}

class _FavouriteNewsState extends State<FavouriteNews> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   firebaseAuth = FirebaseAuth.instance;
  //   String uid = firebaseAuth.currentUser!.uid.toString();
  //   Future<QuerySnapshot<Map<String, dynamic>>> snapshot = firebaseFirestore
  //       .collection('usersFavPosts')
  //       .where('uid', isEqualTo: uid)
  //       .get();

  //   snapshot.then((data) {
  //     print(data.docs[0].toString());
  //   });
  // }

  final Stream<QuerySnapshot> _favPostsStream = FirebaseFirestore.instance
      .collection('usersFavPosts')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _favPostsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('something went wrong'),
            );
          }
          if (!snapshot.hasData) {
            return Loading();
          }

          List<QueryDocumentSnapshot<Object?>> dataList = snapshot.data!.docs;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Center(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12.0),
                            child: Text(
                              'Favourites',
                              style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                flex: 2,
              ),
              Expanded(
                flex: 18,
                child: SizedBox(
                  width: 100.w,
                  height: 87.h,
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data =
                            dataList[index].data()! as Map<String, dynamic>;
                        String docID = dataList[index].id.toString();
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FavArticle(data, docID),
                        );
                        // return ListTile(
                        //   title: Text(data['title']),
                        //   subtitle: Text(data['content']),
                        // );
                      }),
                ),
              ),
            ],
          );
        });
  }
}
