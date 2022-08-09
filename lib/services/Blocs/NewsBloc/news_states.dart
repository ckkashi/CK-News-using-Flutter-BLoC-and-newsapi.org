import 'package:news_app/Model/NewsEverythingModel.dart';
import 'package:news_app/Model/NewsModel.dart';

abstract class NewsStates {}

class NewsLoadState extends NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsErrorState extends NewsStates {
  final String error;
  NewsErrorState(this.error);
}

class NewsLoadedState extends NewsStates {
  NewsModel data;

  NewsLoadedState(this.data);
}

class NewsLoadedState1 extends NewsStates {
  NewsEverythingModel data;

  NewsLoadedState1(this.data);
}
