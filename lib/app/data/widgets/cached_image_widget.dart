import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serveeasy_app/core/constants/asset_constants.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholderFadeInDuration: 3.seconds,
      imageUrl: url,
      placeholder: (context, url) => Image.asset(
        shopIcon,
      ),
      errorWidget: (
        context,
        url,
        error,
      ) =>
          ClipRRect(
        borderRadius: BorderRadius.circular(
          8,
        ),
        child: SizedBox(
          height: 50,
          width: 40,
          child: Image.asset(
            dummyFoodImage,
          ),
        ),
      ),
    );
  }
}
