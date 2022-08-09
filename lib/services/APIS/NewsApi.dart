import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/Model/NewsEverythingModel.dart';
import 'package:news_app/Model/NewsModel.dart';
import 'package:news_app/constants.dart';

class NewsApi {
  String baseUrl = 'https://newsapi.org/v2/';
  String key = Constants.API_KEY;
  Future loadTopHeadlineNews(String pageName, String category) async {
    String uri = '$baseUrl$pageName/sources?category=$category&apiKey=$key';
    var data = await LoadNews(uri, pageName, category);
    var res = NewsModel.fromJson(data);
    return res;
  }

  Future loadEverythingNews(String pageName, String category) async {
    String uri = '$baseUrl$pageName?q=$category&lang=en&apiKey=$key';

    var data = await LoadNews(uri.toLowerCase(), pageName, category);
    var res = NewsEverythingModel.fromJson(data);
    return res;
  }

  Future LoadNews(String uri, String pageName, String category) async {
    http.Response data = await http.get(Uri.parse(uri));
    print(uri);
    return jsonDecode(data.body);
  }
}
