// Flutter imports:
// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_and_app/core/res/images.dart';

class ImageNetwork extends StatelessWidget {
  final String? imageUrl;
  final ImageWidgetBuilder imageBuilder;
  final AssetImage? placeholder;
  const ImageNetwork(
      {Key? key, this.imageUrl, required this.imageBuilder, this.placeholder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl == null
        ? imageBuilder.call(context, placeholder ?? AppImages.notPhoto)
        : CachedNetworkImage(
            imageUrl: imageUrl!,
            imageBuilder: imageBuilder,
            fadeOutDuration: Duration.zero,
            fadeInDuration: Duration.zero,
            placeholder: (context, url) =>
                imageBuilder.call(context, placeholder ?? AppImages.notPhoto),
            errorWidget: (context, url, error) =>
                imageBuilder.call(context, placeholder ?? AppImages.notPhoto),
          );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestPage'),
      ),
      body: ImageNetwork(
        placeholder: AppImages.notPhoto,
        imageUrl: "https://randomuser.me/api/portraits/women/72.jpg",
        imageBuilder: (context, imageProvider) {
          return Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          );
        },
      ),
    );
  }
}
