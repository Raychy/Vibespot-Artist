import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class CachedImage extends StatelessWidget  {
  final String url;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Widget? placeholder;
  final Alignment? alignment;
  final String? hash;
  const CachedImage({
    Key? key,
    required this.url,
    this.height = 60,
    this.width = 60,
    this.fit = BoxFit.contain,
    this.errorWidget,
    this.alignment,
    this.placeholder,
    this.hash,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      url,
      width: width,
      height: height,
      gaplessPlayback: true,
      fit: fit,
      cache: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Container(
                width: width,
                // fit: fit,
                height: height,
                child: placeholder ??
                    BlurHash(hash: hash ?? 'LGF5]+Yk^6#M@-5c,1J5@[or[Q6.'));
          case LoadState.completed:
            return ExtendedRawImage(
                image: state.extendedImageInfo?.image,
                width: width,
                fit: fit,
                height: height);
          case LoadState.failed:
            return errorWidget ??
                BlurHash(hash: hash ?? 'LGF5]+Yk^6#M@-5c,1J5@[or[Q6.');
        }
      },
    );
  }
}

 