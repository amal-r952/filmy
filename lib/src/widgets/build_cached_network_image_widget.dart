import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmy/src/utils/utils.dart';
import 'package:filmy/src/widgets/build_loading_widget.dart';
import 'package:flutter/material.dart';

class BuildCachedNetworkImageWidget extends StatelessWidget {
  final BorderRadius? borderRadius;
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final String imageUrl;
  final BoxShape? boxShape;
  final Widget? placeHolder;

  const BuildCachedNetworkImageWidget({
    Key? key,
    required this.imageUrl,
    this.boxShape,
    this.borderRadius,
    this.placeHolder,
    this.boxFit,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? screenWidth(context),
      height: height ?? screenHeight(context),
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        shape: boxShape ?? BoxShape.rectangle,
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            shape: boxShape ?? BoxShape.rectangle,
            image: DecorationImage(
              image: imageProvider,
              fit: boxFit ?? BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) =>
            placeHolder ??
            const Center(
              child: BuildLoadingWidget(),
            ),
        errorWidget: (context, url, error) => const Center(
          child: Icon(
            Icons.error,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
