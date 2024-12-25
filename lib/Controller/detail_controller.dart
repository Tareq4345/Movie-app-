import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:movie_app/Constant/const.dart';
import 'package:movie_app/Model/movie_detail.dart';
import 'package:movie_app/Service/api_service.dart';
import 'package:video_player/video_player.dart';
// import 'package:http/http.dart' as http;

class DetailController extends GetxController {
  Rx<MovieDetail> _movieDetail = MovieDetail().obs;
  MovieDetail get movieDetail => _movieDetail.value;
  Rx<VideoPlayerController?> videoController = Rx<VideoPlayerController?>(null);
  RxBool isVideoInitialized = false.obs;
  @override
  void onInit() {
    // getMovieDetail(558449);
    super.onInit();
  }

  void getMovieDetail(int movieId) async {
    debugPrint("Calling");
    try {
      String url = Constant.movieDetailsUrl(movieId);
      var response = await ApiService().getRequestForData(url);
      debugPrint('+++++++++++++++++++++in controller${response?.body}');

      if (response != null) {
        _movieDetail.value = MovieDetail.fromJson(jsonDecode(response.body));
        if (_movieDetail.value.homepage != null &&
            _movieDetail.value.homepage!.isNotEmpty) {
          initializeVideoPlayer(_movieDetail.value.homepage!);
        }
      } else {
        debugPrint("nothinng");
      }

      debugPrint(
          '+++++++++++++++++++++after ${_movieDetail.value.originalLanguage.toString()}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void initializeVideoPlayer(String videoUrl) {
    videoController.value =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    videoController.value?.initialize().then((_) {
      isVideoInitialized.value = true;
      videoController.value?.play();
    }).catchError((error) {
      debugPrint("Video initialization failed: $error");
    });
  }
}
