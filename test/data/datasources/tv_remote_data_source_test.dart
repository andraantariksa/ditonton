import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/themoviedb_service.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tvs_overview_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late TVRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TVRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing TVs', () {
    final tTVList = TVsOverviewModel.fromJson(
            json.decode(readJson('dummy_data/tv/on_the_air.json')))
        .tvList;

    test('should return list of TV Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '${TheMovieDBService.BASE_URL}/tv/on_the_air?${TheMovieDBService.API_KEY}')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv/on_the_air.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getOnTheAirTVs();
      // assert
      expect(result, equals(tTVList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '${TheMovieDBService.BASE_URL}/tv/on_the_air?${TheMovieDBService.API_KEY}')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnTheAirTVs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TVs', () {
    final tTVList = TVsOverviewModel.fromJson(
            json.decode(readJson('dummy_data/tv/popular.json')))
        .tvList;

    test('should return list of TVs when response is success (200)', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '${TheMovieDBService.BASE_URL}/tv/popular?${TheMovieDBService.API_KEY}')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv/popular.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getPopularTVs();
      // assert
      expect(result, tTVList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '${TheMovieDBService.BASE_URL}/tv/popular?${TheMovieDBService.API_KEY}')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTVs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated TVs', () {
    final tTVList = TVsOverviewModel.fromJson(
            json.decode(readJson('dummy_data/tv/top_rated.json')))
        .tvList;

    test('should return list of TVs when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '${TheMovieDBService.BASE_URL}/tv/top_rated?${TheMovieDBService.API_KEY}')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv/top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTVs();
      // assert
      expect(result, tTVList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '${TheMovieDBService.BASE_URL}/tv/top_rated?${TheMovieDBService.API_KEY}')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTVs();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get TV detail', () {
    final tId = 1;
    final tTVDetail = TVDetailModel.fromJson(
        json.decode(readJson('dummy_data/tv/detail.json')));

    test('should return TV detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '${TheMovieDBService.BASE_URL}/tv/$tId?${TheMovieDBService.API_KEY}')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv/detail.json'), 200));
      // act
      final result = await dataSource.getTVDetail(tId);
      // assert
      expect(result, equals(tTVDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '${TheMovieDBService.BASE_URL}/tv/$tId?${TheMovieDBService.API_KEY}')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get TV recommendations', () {
    final tTVList = TVsOverviewModel.fromJson(
            json.decode(readJson('dummy_data/tv/recommendations.json')))
        .tvList;
    final tId = 1;

    test('should return list of TV Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '${TheMovieDBService.BASE_URL}/tv/$tId/recommendations?${TheMovieDBService.API_KEY}')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv/recommendations.json'), 200));
      // act
      final result = await dataSource.getTVRecommendations(tId);
      // assert
      expect(result, equals(tTVList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '${TheMovieDBService.BASE_URL}/tv/$tId/recommendations?${TheMovieDBService.API_KEY}')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search TVs', () {
    final tSearchResult = TVsOverviewModel.fromJson(
            json.decode(readJson('dummy_data/tv/search_family_guy_tv.json')))
        .tvList;
    final tQuery = 'Spiderman';

    test('should return list of TVs when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '${TheMovieDBService.BASE_URL}/search/tv?${TheMovieDBService.API_KEY}&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv/search_family_guy_tv.json'), 200));
      // act
      final result = await dataSource.searchTVs(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '${TheMovieDBService.BASE_URL}/search/tv?${TheMovieDBService.API_KEY}&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTVs(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
