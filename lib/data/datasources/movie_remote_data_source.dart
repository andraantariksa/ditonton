import 'dart:convert';

import 'package:ditonton/data/datasources/themoviedb_service.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_overview_model.dart';
import 'package:ditonton/data/models/movies_overview_model.dart';
import 'package:ditonton/common/exception.dart';
import 'package:http/http.dart' as http;

abstract class MovieRemoteDataSource {
  Future<List<MovieOverviewModel>> getNowPlayingMovies();
  Future<List<MovieOverviewModel>> getPopularMovies();
  Future<List<MovieOverviewModel>> getTopRatedMovies();
  Future<MovieDetailModel> getMovieDetail(int id);
  Future<List<MovieOverviewModel>> getMovieRecommendations(int id);
  Future<List<MovieOverviewModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieOverviewModel>> getNowPlayingMovies() async {
    final response =
        await client.get(Uri.parse('${TheMovieDBService.BASE_URL}/movie/now_playing?${TheMovieDBService.API_KEY}'));

    if (response.statusCode == 200) {
      return MoviesOverviewModel.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final response =
        await client.get(Uri.parse('${TheMovieDBService.BASE_URL}/movie/$id?${TheMovieDBService.API_KEY}'));

    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieOverviewModel>> getMovieRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('${TheMovieDBService.BASE_URL}/movie/$id/recommendations?${TheMovieDBService.API_KEY}'));

    if (response.statusCode == 200) {
      return MoviesOverviewModel.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieOverviewModel>> getPopularMovies() async {
    final response =
        await client.get(Uri.parse('${TheMovieDBService.BASE_URL}/movie/popular?${TheMovieDBService.API_KEY}'));

    if (response.statusCode == 200) {
      return MoviesOverviewModel.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieOverviewModel>> getTopRatedMovies() async {
    final response =
        await client.get(Uri.parse('${TheMovieDBService.BASE_URL}/movie/top_rated?${TheMovieDBService.API_KEY}'));

    if (response.statusCode == 200) {
      return MoviesOverviewModel.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieOverviewModel>> searchMovies(String query) async {
    final response = await client
        .get(Uri.parse('${TheMovieDBService.BASE_URL}/search/movie?${TheMovieDBService.API_KEY}&query=$query'));

    if (response.statusCode == 200) {
      return MoviesOverviewModel.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }
}
