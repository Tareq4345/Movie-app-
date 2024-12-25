import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/Constant/const.dart';
import 'package:movie_app/Model/movie_model.dart';
import 'package:movie_app/Model/tv_model.dart';

class ApiService extends GetxController {
  Constant constant = Constant();

  Future<MovieModel?> getDataApi(String category) async {
    String url = constant.baseurl + category + constant.apiKey;
    try {
      var response = await http.get(Uri.parse(url));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        return MovieModel.fromJson(data);
      } else {}
      {}
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieModel?> getDataApiTrending() async {
    var load =
        'https://api.themoviedb.org/3/trending/movie/week?api_key=98a009235bc6ca303df7c782c158fd6a';
    try {
      var response = await http.get(Uri.parse(load));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        return MovieModel.fromJson(data);
      } else {}
      {}
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<TvModel?> getDataApiTv(String category) async {
    final tvUrl = Constant().baseurltv + category + Constant().apiKey;

    try {
      final response = await http.get(Uri.parse(tvUrl));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        return TvModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> getMovieDetail(String url) async {
    try {
      var response = await http.get(Uri.parse(url));

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response?> getRequestForData(String url) async {
    http.Response? response;
    try {
      response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMjJkYmVmYjU3NjY3Y2Y0NTI3Mzk1M2Q0NGNjNjQ3NiIsIm5iZiI6MTczNDkzMzUzMy45NDcsInN1YiI6IjY3NjhmYzFkMWM1NGViZmVkNWM0ZDlkZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.P1B8yY8iW7gIG6dwSmKbacwyq4pC_8YwYAwXtzuFykw',
        },
      );
      debugPrint(response.body);
      final responseDecode = jsonDecode(response.body);
      debugPrint(responseDecode.toString());
      debugPrint('++++++++++++++++++++++++++++${response.statusCode}');
      if (response.statusCode == 200) {
        return response;
      }
      // if (responseDecode['success']) {
      //   log(response.headers.toString());
      //   log(response.statusCode.toString());
      //   log(response.body.toString());
      //   return response;
      // }
      return null;
    } catch (e) {
      return null;
    }
  }
}
