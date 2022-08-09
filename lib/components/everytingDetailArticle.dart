import 'package:flutter/material.dart';
import 'package:news_app/Model/NewsEverythingModel.dart';
import 'package:news_app/Model/NewsModel.dart';
import 'package:sizer/sizer.dart';

class EverythingDetailArticle extends StatelessWidget {
  final Articles newsData;
  const EverythingDetailArticle(this.newsData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 100.w,
          height: 100.h,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                      width: 100.w,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  child: Center(
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                        )),
                                  ),
                                )),
                            Expanded(
                              flex: 9,
                              child: Text(
                                newsData.title.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        color: Colors.black,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100.w,
                    height: 25.h,
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        headingBadge(newsData.source!.name.toString()),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 55.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.sp),
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
                          headingBadge('Description'),
                          detailsText(newsData.description.toString()),
                          headingBadge('Content'),
                          detailsText(newsData.content.toString()),
                          headingBadge('Author'),
                          detailsText(newsData.author.toString()),
                          headingBadge('Article url'),
                          detailsText(newsData.url.toString()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
