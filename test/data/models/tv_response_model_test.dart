import 'dart:convert';

import 'package:ditonton/data/models/tv_overview_model.dart';
import 'package:ditonton/data/models/tvs_overview_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTVModel = TVOverviewModel(
    backdropPath: "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
    genreIds: [18, 9648],
    id: 31917,
    originalName: "Pretty Little Liars",
    overview:
        'Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name "A" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.',
    popularity: 47.432451,
    posterPath: "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
    firstAirDate: "2010-06-08",
    name: "Pretty Little Liars",
    voteAverage: 5.04,
    voteCount: 133,
  );
  final tMovieResponseModel =
      TVsOverviewModel(tvList: <TVOverviewModel>[tTVModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv/on_the_air.json'));
      // act
      final result = TVsOverviewModel.fromJson(jsonMap);
      // assert
      expect(result, tMovieResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tMovieResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "poster_path": "/vC324sdfcS313vh9QXwijLIHPJp.jpg",
            "popularity": 47.432451,
            "id": 31917,
            "backdrop_path": "/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg",
            "vote_average": 5.04,
            "overview":
                "Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.",
            "first_air_date": "2010-06-08",
            "genre_ids": [18, 9648],
            "vote_count": 133,
            "name": "Pretty Little Liars",
            "original_name": "Pretty Little Liars"
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
