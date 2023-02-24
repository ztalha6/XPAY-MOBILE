import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

class ImageUtil {
  static final ImageUtil _singleton = ImageUtil._internal();

  factory ImageUtil() {
    return _singleton;
  }

  ImageUtil._internal();
  MemoryImage imageFromBase64String(String base64String) {
    return MemoryImage(base64Decode(base64String));
  }

  Uint8List fromBase64(String base64String) {
    return base64Decode(base64String);
  }

  String toBase64(Uint8List data) {
    return base64Encode(data);
  }

  Future<List<String>> getPathsFromEncodedImages(
    List<String> encodedImages,
  ) async {
    final List<String> paths = [];
    for (int i = 0; i < encodedImages.length; i++) {
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = tempDir.path;
      final Uint8List bytes = fromBase64(encodedImages[i]);
      final File file = File(
        "$tempPath/${DateTime.now().millisecondsSinceEpoch}.png",
      );
      await file.writeAsBytes(bytes);
      paths.add(file.path);
    }
    return paths;
  }

  // static List<MediaModel> getImageAndVideoPaths(Post post) {
  //   List<MediaModel>? videos = post.postMedia?.video
  //           ?.map((e) => MediaModel(
  //               isVideo: true,
  //               imagePath: e.thumbNail ?? '',
  //               videoUrl: e.videoURL ?? ''))
  //           .toList() ??
  //       [];

  //   List<String>? images =
  //       post.postMedia?.image?.map((e) => e.image ?? '').toList() ?? [];

  //   List<MediaModel> mediaModelList = [];

  //   //add images
  //   for (int i = 0; i < images.length; i++) {
  //     mediaModelList
  //         .add(MediaModel(isVideo: false, imagePath: images[i], videoUrl: ''));
  //   }

  //   videos.removeWhere((element) => element.imagePath.isEmpty);

  //   mediaModelList.addAll(videos);

  //   return mediaModelList;
  // }

}
