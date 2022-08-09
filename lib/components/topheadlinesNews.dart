import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Model/NewsModel.dart';
import 'package:news_app/components/topHeadlineArticle.dart';
import 'package:news_app/screens/loading.dart';
import 'package:news_app/services/Blocs/NewsBloc/news_bloc.dart';
import 'package:news_app/services/Blocs/NewsBloc/news_events.dart';
import 'package:news_app/services/Blocs/NewsBloc/news_states.dart';
import 'package:sizer/sizer.dart';

class TopheadlinesNews extends StatefulWidget {
  final String category;
  const TopheadlinesNews(this.category, {Key? key}) : super(key: key);

  @override
  State<TopheadlinesNews> createState() => _TopheadlinesNewsState();
}

class _TopheadlinesNewsState extends State<TopheadlinesNews> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NewsBloc>(context)
        .add(NewsLoadEvent('top-headlines', widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 80.h,
      child: BlocBuilder<NewsBloc, NewsStates>(builder: ((context, state) {
        if (state is NewsInitialState) {
          return const Loading();
        } else if (state is NewsLoadedState) {
          return ListView.builder(
              itemCount: state.data.sources!.length,
              itemBuilder: (context, index) {
                NewsModel data = state.data;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  child: TopHeadlineArticle(data.sources![index]),
                );
              });
        } else {
          return Text('Something went wrong');
        }
      })),
    );
    ;
  }
}
