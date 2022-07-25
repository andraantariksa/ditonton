import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/themoviedb_service.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_overview_model.dart';
import 'package:ditonton/data/models/tvs_overview_model.dart';
import 'package:http/http.dart' as http;

abstract class TVRemoteDataSource {
  Future<List<TVOverviewModel>> getOnTheAirTVs();
  Future<List<TVOverviewModel>> getPopularTVs();
  Future<List<TVOverviewModel>> getTopRatedTVs();
  Future<TVDetailModel> getTVDetail(int id);
  Future<List<TVOverviewModel>> getTVRecommendations(int id);
  Future<List<TVOverviewModel>> searchTVs(String query);
}

class TVRemoteDataSourceImpl implements TVRemoteDataSource {
  final http.Client client;

  TVRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TVOverviewModel>> getOnTheAirTVs() async {
    final response =
        await client.get(Uri.parse('${TheMovieDBService.BASE_URL}/tv/on_the_air?${TheMovieDBService.API_KEY}'));

    if (response.statusCode == 200) {
      return TVsOverviewModel.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVOverviewModel>> getPopularTVs() async {
    final response =
        await client.get(Uri.parse('${TheMovieDBService.BASE_URL}/tv/popular?${TheMovieDBService.API_KEY}'));

    if (response.statusCode == 200) {
      return TVsOverviewModel.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVDetailModel> getTVDetail(int id) async {
    final response =
        await client.get(Uri.parse('${TheMovieDBService.BASE_URL}/tv/$id?${TheMovieDBService.API_KEY}'));

    if (response.statusCode == 200) {
      return TVDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVOverviewModel>> getTVRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('${TheMovieDBService.BASE_URL}/tv/$id/recommendations?${TheMovieDBService.API_KEY}'));

    if (response.statusCode == 200) {
      return TVsOverviewModel.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVOverviewModel>> getTopRatedTVs() async {
    final response =
    await client.get(Uri.parse('${TheMovieDBService.BASE_URL}/tv/top_rated?${TheMovieDBService.API_KEY}'));

    if (response.statusCode == 200) {
      return TVsOverviewModel.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVOverviewModel>> searchTVs(String query) async {
    final response = await client
        .get(Uri.parse('${TheMovieDBService.BASE_URL}/search/tv?${TheMovieDBService.API_KEY}&query=$query'));

    if (response.statusCode == 200) {
      return TVsOverviewModel.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

}