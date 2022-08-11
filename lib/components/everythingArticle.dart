import 'package:flutter/material.dart';
import 'package:news_app/Model/NewsEverythingModel.dart';
import 'package:news_app/Model/NewsModel.dart';
import 'package:news_app/components/everytingDetailArticle.dart';
import 'package:sizer/sizer.dart';

class EverythingArticle extends StatelessWidget {
  final Articles newsData;
  EverythingArticle(this.newsData, {Key? key}) : super(key: key);
  late DateTime date = DateTime.parse(newsData.publishedAt.toString());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => EverythingDetailArticle(newsData))));
      },
      child: Container(
        width: 95.w,
        height: 30.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.sp),
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(newsData.urlToImage.toString()),
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
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  width: 100.w,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      newsData.title.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 15.sp),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    color: Colors.black,
                  )),
            ),
            Row(
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
                        '${date.hour}:${date.minute} | ${date.day}-${date.month}-${date.year}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
