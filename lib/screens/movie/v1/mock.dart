import 'dart:convert';

import 'package:http/http.dart' as http;

import 'detail.dart';
import 'movie.dart';
import 'constants.dart';

late Future<Movie> futureDiscoverMovie;

Future<Movie> fetchDiscoverMovie() async {
  final response = await http.get(
    Uri.parse(
      baseUrl + 'discover/movie?api_key=' + apiKey + '&sort_by=popularity.desc',
    ),
  );

  if (response.statusCode == 200) {
    return Movie.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Movie');
  }
}

late Future<Movie> futureTrendingMovie;

Future<Movie> fetchTrendingMovie() async {
  final response = await http.get(
    Uri.parse(
      baseUrl + 'trending/movie/day?api_key=' + apiKey,
    ),
  );

  if (response.statusCode == 200) {
    return Movie.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Movie');
  }
}

late Future<Movie> futureSpecialMovie;

Future<Movie> fetchSpecialMovie() async {
  final response = await http.get(
    Uri.parse(
      baseUrl + 'movie/now_playing?api_key=' + apiKey,
    ),
  );

  if (response.statusCode == 200) {
    return Movie.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Movie');
  }
}

late Future<Details> futureMovieDetails;

Future<Details> fetchMovieDetails(int id) async {
  final response = await http.get(
    Uri.parse(
      baseUrl + 'movie/' + id.toString() + '?api_key=' + apiKey,
    ),
  );

  if (response.statusCode == 200) {
    return Details.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Movie');
  }
}

late Future<Movie> futureSearchMovie;

Future<Movie> fetchSearchMovie(String query) async {
  final response = await http.get(
    Uri.parse(
      baseUrl + 'search/movie?api_key=' + apiKey + '&query=' + query,
    ),
  );

  if (response.statusCode == 200) {
    return Movie.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Movie');
  }
}