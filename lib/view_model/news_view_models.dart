import 'package:news_app/models/NewsCategory.dart';
import 'package:news_app/models/News_chanals_Model.dart';
import 'package:news_app/models/News_chanals_headlines.dart';
import 'package:news_app/repositroy/news_repository.dart';

class NewsViewModel{
  final _rep = NewsRepositry();
  final _sub = NewsRepositry();
  Future<NewsChanalsHeadlinesModels> FeathcNewsHeadlineApi() async{
    final response = await _rep.FeathcNewsHeadlineApi();
    return response;
}
  Future<NewsChanalsModels> FeathcNewsApi() async{
    final response = await _sub.FeathcNewsApi();
    return response;
}
  Future<NewsCategoryModels> FeatchCategoryApi(String category) async{
    final response = await _sub.FeathcNewsCategory(category);
    return response;
}
}
