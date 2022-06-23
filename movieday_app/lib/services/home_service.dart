import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movieday_app/models/movieModel.dart';
import 'package:movieday_app/models/movie_actor.dart';
import 'package:movieday_app/models/movie_detail_model.dart';


const baseUrl = 'https://api.themoviedb.org/3/movie/';
const baseImageUrl = 'https://image.tmdb.org/t/p/w300';
const APIKEY = '6fd76393eacd04ed102f64ec12258cbf';
const nowPlayingUrl = '${baseUrl}now_playing?api_key=$APIKEY&language=es-MX';
const comingSoonUrl = '${baseUrl}upcoming?api_key=$APIKEY&language=es-MX';
const popularUrl = '${baseUrl}popular?api_key=$APIKEY&language=es-MX';

Future<Welcome> searchMovies(String query)async{
  var url = "https://api.themoviedb.org/3/search/movie?api_key=6fd76393eacd04ed102f64ec12258cbf&query=$query";
  var response  = await http.get(Uri.parse(url));
  var decodeJson = await jsonDecode(response.body);
  Welcome peliculas = Welcome.fromJson(decodeJson);
  return peliculas;
}

Future<Welcome> getNowPlayingMovies() async{
  var url = "https://8d0eg7kzy7.execute-api.us-east-1.amazonaws.com/Test/movies?tipo=right_now";
  var response = await http.get(Uri.parse(nowPlayingUrl));
  var decodeJson = await jsonDecode(response.body);
  Welcome peliculas = Welcome.fromJson(decodeJson);
  return peliculas;
}

Future<Welcome> getComingSoonMovies() async{
  var url = "https://8d0eg7kzy7.execute-api.us-east-1.amazonaws.com/Test/movies?tipo=upcoming";
  var response = await http.get(Uri.parse(url));
  var decodeJson = await jsonDecode(response.body);
  Welcome peliculas = Welcome.fromJson(decodeJson);
  return peliculas;
}

Future<Welcome> getPopularMovies() async{
  var url = "https://8d0eg7kzy7.execute-api.us-east-1.amazonaws.com/Test/movies?tipo=popular";
  var response = await http.get(Uri.parse(url));
  var decodeJson = await jsonDecode(response.body);
  Welcome peliculas = Welcome.fromJson(decodeJson);
  return peliculas;
}

/*******************MOVIE DETAILS*********************/
Future<MovieDetailModel> getMovieDetail(String id) async{
  //var movieDetailUrl = '${baseUrl}${id}?api_key=$APIKEY&language=es-MX';
  var url = "https://8d0eg7kzy7.execute-api.us-east-1.amazonaws.com/Test/movies/details?id=$id";
  var response = await http.get(Uri.parse(url));
  var decodeJson = await jsonDecode(response.body);
  // print(decodeJson);
  MovieDetailModel movie = MovieDetailModel.fromJson(decodeJson);
  return movie;
}

Future<MovieActor> getMovieActor(String id) async{
  var movieDetailUrl = '${baseUrl}${id}/credits?api_key=$APIKEY&language=es-MX';
  var response = await http.get(Uri.parse(movieDetailUrl));
  var decodeJson = await jsonDecode(response.body);
  MovieActor movie = MovieActor.fromJson(decodeJson);
  return movie;
}