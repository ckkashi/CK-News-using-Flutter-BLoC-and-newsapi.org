import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Model/NewsEverythingModel.dart';
import 'package:news_app/components/everythingArticle.dart';
import 'package:sizer/sizer.dart';

import '../screens/loading.dart';
import '../services/Blocs/NewsBloc/news_bloc.dart';
import '../services/Blocs/NewsBloc/news_events.dart';
import '../services/Blocs/NewsBloc/news_states.dart';

class EverythingNews extends StatefulWidget {
  final String category;
  EverythingNews(this.category, {Key? key}) : super(key: key);

  @override
  State<EverythingNews> createState() => _EverythingNewsState();
}

class _EverythingNewsState extends State<EverythingNews> {
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NewsBloc>(context)
        .add(NewsLoadEvent('everything', widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 80.h,
      child: BlocBuilder<NewsBloc, NewsStates>(builder: ((context, state) {
        if (state is NewsInitialState) {
          return const Loading();
        } else if (state is NewsLoadedState1) {
          return ListView.builder(
              itemCount: state.data.articles!.length,
              itemBuilder: (context, index) {
                NewsEverythingModel data = state.data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: EverythingArticle(state.data.articles![index]),
                );
              });
        } else {
          return Text('Something went wrong');
        }
      })),
    );
  }
}
