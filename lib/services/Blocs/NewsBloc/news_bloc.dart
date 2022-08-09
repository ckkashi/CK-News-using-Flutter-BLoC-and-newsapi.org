import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/services/APIS/NewsApi.dart';
import 'package:news_app/services/Blocs/NewsBloc/news_events.dart';
import 'package:news_app/services/Blocs/NewsBloc/news_states.dart';

class NewsBloc extends Bloc<NewsEvents, NewsStates> {
  NewsApi _newsApi = NewsApi();

  NewsBloc() : super(NewsInitialState()) {
    on<NewsLoadEvent>((event, emit) async {
      emit(NewsInitialState());
      var res;
      if (event.pageName.toLowerCase() == 'top-headlines') {
        res = await _newsApi.loadTopHeadlineNews(
            event.pageName.toLowerCase(), event.cat.toLowerCase());
        print('getting headline');
        emit(NewsLoadedState(res));
      } else {
        res = await _newsApi.loadEverythingNews(
            event.pageName.toLowerCase(), event.cat.toLowerCase());
        print('getting everything');
        emit(NewsLoadedState1(res));
      }
      // print(res);
    });
  }
}
