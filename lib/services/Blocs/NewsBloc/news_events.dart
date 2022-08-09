abstract class NewsEvents {}

class NewsLoadEvent extends NewsEvents {
  String pageName;
  String cat;
  NewsLoadEvent(this.pageName, this.cat);
}
