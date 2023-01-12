import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_extensions.dart';
import 'package:movies/Commons/kf_functions.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:movies/Components/kf_header_image_stream_component.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class KFHeaderCarouselFragment extends StatefulWidget {
  const KFHeaderCarouselFragment({super.key, required this.isMovie});
  final bool isMovie;

  @override
  State<KFHeaderCarouselFragment> createState() =>
      _KFHeaderCarouselFragmentState();
}

class _KFHeaderCarouselFragmentState extends State<KFHeaderCarouselFragment> {
  late bool isMovie = widget.isMovie;

  int _activeIndex = 0;
  int get activeIndex => _activeIndex;

  get _autoPlayAnimationDuration => const Duration(milliseconds: 600);

  @override
  Widget build(BuildContext context) {
    final height = getScreenContraints(context).height * 0.3;
    return Column(
      children: [
        _buildCarousel(height),
        _buildIndicator().paddingSymmetric(vertical: 8),
      ],
    );
  }

  Widget _buildIndicator() => AnimatedSmoothIndicator(
      effect: const JumpingDotEffect(
          dotColor: Colors.white38,
          activeDotColor: Colors.white,
          dotHeight: 10),
      duration: _autoPlayAnimationDuration,
      activeIndex: activeIndex,
      count: widget.isMovie
          ? kfPopularMoviesIDs.length
          : kfPopularSeriesIDs.length);

  Widget _buildCarousel(double height) => CarouselSlider.builder(
      itemCount: widget.isMovie
          ? kfPopularMoviesIDs.length
          : kfPopularSeriesIDs.length,
      itemBuilder: (context, index, realIndex) =>
          KFHeaderImageStreamComponent(index: index, isMovie: widget.isMovie),
      options: CarouselOptions(
          height: height,
          viewportFraction: 1,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: _autoPlayAnimationDuration,
          onPageChanged: ((index, reason) =>
              setState(() => _activeIndex = index)))).paddingOnly(top: 5);
}
