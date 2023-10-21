import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/NewsCategory.dart';
import 'package:news_app/models/News_chanals_Model.dart';
import 'package:news_app/models/News_chanals_headlines.dart';
class NewsRepositry{
  Future<NewsChanalsHeadlinesModels> FeathcNewsHeadlineApi() async{
    String uri = 'https://newsapi.org/v2/everything?q=apple&from=2023-09-29&to=2023-09-29&sortBy=popularity&apiKey=0b026a2b917d4f98b10343d19bca62ae';
    final response = await http.get(Uri.parse(uri));
    if (kDebugMode) {
      print(response.body);
    }

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return NewsChanalsHeadlinesModels.fromJson(body);
    }throw Exception('error');
  }
  Future<NewsChanalsModels> FeathcNewsApi() async{
    String uri = 'https://newsapi.org/v2/everything?q=apple&from=2023-09-29&to=2023-09-29&sortBy=popularity&apiKey=0b026a2b917d4f98b10343d19bca62ae';
    final response = await http.get(Uri.parse(uri));
    if (kDebugMode) {
      print(response.body);
    }

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return NewsChanalsModels.fromJson(body);
    }throw Exception('error');
  }
  Future<NewsCategoryModels> FeathcNewsCategory(String category) async{
    String uri = 'https://newsapi.org/v2/everything?q=${category}&apiKey=0b026a2b917d4f98b10343d19bca62ae';
    final response = await http.get(Uri.parse(uri));
    if (kDebugMode) {
      print(response.body);
    }

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return NewsCategoryModels.fromJson(body);
    }throw Exception('error');
  }
}