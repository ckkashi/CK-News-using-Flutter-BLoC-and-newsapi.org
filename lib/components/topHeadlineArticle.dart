import 'package:flutter/material.dart';
import 'package:news_app/Model/NewsModel.dart';
import 'package:sizer/sizer.dart';

class TopHeadlineArticle extends StatelessWidget {
  final newsData;
  const TopHeadlineArticle(this.newsData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.sp),
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
          boxShadow: [
            BoxShadow(
                blurRadius: 2,
                color: Colors.black.withOpacity(0.8),
                spreadRadius: 0.1)
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
                width: 100.w,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    newsData.name,
                    style: TextStyle(color: Colors.white, fontSize: 15.sp),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.sp),
                      topRight: Radius.circular(4.sp),
                      bottomLeft: Radius.circular(4.sp),
                      bottomRight: Radius.circular(4.sp)),
                  color: Colors.black,
                )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            child: Text(
              newsData.description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                  color: Colors.black87),
            ),
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
                      newsData.category.toString().toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
