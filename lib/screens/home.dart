import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/components/everythingNews.dart';
import 'package:news_app/components/topheadlinesNews.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/services/Blocs/NewsBloc/news_bloc.dart';
import 'package:news_app/services/Blocs/NewsBloc/news_events.dart';
import 'package:news_app/services/Blocs/NewsBloc/news_states.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List catNames = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology'
  ];
  var catValue = 'general';

  List dropDownItems = ['Top-headlines', 'Everything'];

  var dropDownValue = 'Top-headlines';

  Map<String, Object> data = {
    "status": "ok",
    "sources": [
      {
        "id": "bbc-sport",
        "name": "BBC Sport",
        "description":
            "The home of BBC Sport online. Includes live sports coverage, breaking news, results, video, audio and analysis on Football, F1, Cricket, Rugby Union, Rugby League, Golf, Tennis and all the main world sports, plus major events such as the Olympic Games.",
        "url": "http://www.bbc.co.uk/sport",
        "category": "sports",
        "language": "en",
        "country": "gb"
      },
      {
        "id": "bleacher-report",
        "name": "Bleacher Report",
        "description":
            "Sports journalists and bloggers covering NFL, MLB, NBA, NHL, MMA, college football and basketball, NASCAR, fantasy sports and more. News, photos, mock drafts, game scores, player profiles and more!",
        "url": "http://www.bleacherreport.com",
        "category": "sports",
        "language": "en",
        "country": "us"
      },
      {
        "id": "espn",
        "name": "ESPN",
        "description":
            "ESPN has up-to-the-minute sports news coverage, scores, highlights and commentary for NFL, MLB, NBA, College Football, NCAA Basketball and more.",
        "url": "http://espn.go.com",
        "category": "sports",
        "language": "en",
        "country": "us"
      },
      {
        "id": "espn-cric-info",
        "name": "ESPN Cric Info",
        "description":
            "ESPN Cricinfo provides the most comprehensive cricket coverage available including live ball-by-ball commentary, news, unparalleled statistics, quality editorial comment and analysis.",
        "url": "http://www.espncricinfo.com/",
        "category": "sports",
        "language": "en",
        "country": "us"
      },
      {
        "id": "football-italia",
        "name": "Football Italia",
        "description":
            "Italian football news, analysis, fixtures and results for the latest from Serie A, Serie B and the Azzurri.",
        "url": "http://www.football-italia.net",
        "category": "sports",
        "language": "en",
        "country": "it"
      },
      {
        "id": "four-four-two",
        "name": "FourFourTwo",
        "description":
            "The latest football news, in-depth features, tactical and statistical analysis from FourFourTwo, the UK&#039;s favourite football monthly.",
        "url": "http://www.fourfourtwo.com/news",
        "category": "sports",
        "language": "en",
        "country": "gb"
      },
      {
        "id": "fox-sports",
        "name": "Fox Sports",
        "description":
            "Find live scores, player and team news, videos, rumors, stats, standings, schedules and fantasy games on FOX Sports.",
        "url": "http://www.foxsports.com",
        "category": "sports",
        "language": "en",
        "country": "us"
      },
      {
        "id": "lequipe",
        "name": "L'equipe",
        "description":
            "Le sport en direct sur L'EQUIPE.fr. Les informations, résultats et classements de tous les sports. Directs commentés, images et vidéos à regarder et à partager !",
        "url": "https://www.lequipe.fr",
        "category": "sports",
        "language": "fr",
        "country": "fr"
      },
      {
        "id": "marca",
        "name": "Marca",
        "description":
            "La mejor información deportiva en castellano actualizada minuto a minuto en noticias, vídeos, fotos, retransmisiones y resultados en directo.",
        "url": "http://www.marca.com",
        "category": "sports",
        "language": "es",
        "country": "es"
      },
      {
        "id": "nfl-news",
        "name": "NFL News",
        "description":
            "The official source for NFL news, schedules, stats, scores and more.",
        "url": "http://www.nfl.com/news",
        "category": "sports",
        "language": "en",
        "country": "us"
      },
      {
        "id": "nhl-news",
        "name": "NHL News",
        "description":
            "The most up-to-date breaking hockey news from the official source including interviews, rumors, statistics and schedules.",
        "url": "https://www.nhl.com/news",
        "category": "sports",
        "language": "en",
        "country": "us"
      },
      {
        "id": "talksport",
        "name": "TalkSport",
        "description":
            "Tune in to the world's biggest sports radio station - Live Premier League football coverage, breaking sports news, transfer rumours &amp; exclusive interviews.",
        "url": "http://talksport.com",
        "category": "sports",
        "language": "en",
        "country": "gb"
      },
      {
        "id": "the-sport-bible",
        "name": "The Sport Bible",
        "description":
            "TheSPORTbible is one of the largest communities for sports fans across the world. Send us your sporting pictures and videos!",
        "url": "https://www.thesportbible.com",
        "category": "sports",
        "language": "en",
        "country": "gb"
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(100.w, 7.h),
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            Constants.APP_TITLE,
                            style: TextStyle(
                                fontSize: 25.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                underline: null,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp),
                                iconEnabledColor: Colors.black.withOpacity(0.8),
                                iconSize: 20.sp,
                                value: dropDownValue,
                                items: dropDownItems
                                    .map((element) => DropdownMenuItem(
                                        value: element, child: Text(element)))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    dropDownValue = value.toString();
                                  });
                                }),
                          ))
                    ],
                  ),
                ),
                flex: 2,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: 100.w,
        // color: Colors.amber,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // color: Colors.blue,
              width: 100.w,
              height: 9.h,
              child: Center(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: catNames.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              catValue = catNames[index];
                            });
                            BlocProvider.of<NewsBloc>(context)
                                .add(NewsLoadEvent(dropDownValue, catValue));
                          },
                          child: Container(
                            // width: 40.w,
                            height: 7.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                              color: Colors.black,
                              // boxShadow: [
                              //   BoxShadow(
                              //       blurRadius: 1,
                              //       color: Colors.black.withOpacity(1),
                              //       spreadRadius: 1)
                              // ]
                            ),
                            child: Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                '${catNames[index][0].toUpperCase()}${catNames[index].substring(1)}',
                                style: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            dropDownValue == 'Top-headlines'
                ? TopheadlinesNews(catValue)
                : EverythingNews(catValue),
          ],
        ),
      ),
    );
  }
}
