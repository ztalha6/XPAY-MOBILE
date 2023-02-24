import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    Key? key,
    required this.imgList,
    this.onPageChanged,
    required this.currentIndex,
    required this.activeDotColor,
    this.autoPlay = true,
    this.showDots = false,
  }) : super(key: key);
  final List<String> imgList;
  final Function(int, CarouselPageChangedReason)? onPageChanged;
  final int currentIndex;
  final Color activeDotColor;
  final bool autoPlay;
  final bool showDots;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: imgList.length,
          options: CarouselOptions(
            enableInfiniteScroll: false,
            initialPage: 1,
            autoPlay: autoPlay,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayCurve: Curves.linearToEaseOut,
            onPageChanged: onPageChanged,
          ),
          itemBuilder: (
            BuildContext context,
            int itemIndex,
            int pageViewIndex,
          ) =>
              Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imgList[itemIndex],
                fit: BoxFit.cover,
                width: 1000,
              ),
            ),
          ),
        ),
        if (showDots)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map(
              (image) {
                final int index = imgList.indexOf(image);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 2.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index
                        ? activeDotColor
                        : Colors.grey.shade300,
                  ),
                );
              },
            ).toList(),
          ),
      ],
    );
  }
}
