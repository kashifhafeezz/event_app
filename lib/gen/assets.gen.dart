/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/agenda.png
  AssetGenImage get agenda => const AssetGenImage('assets/images/agenda.png');

  /// File path: assets/images/ask_questions.png
  AssetGenImage get askQuestions =>
      const AssetGenImage('assets/images/ask_questions.png');

  /// File path: assets/images/badge.png
  AssetGenImage get badge => const AssetGenImage('assets/images/badge.png');

  /// File path: assets/images/brand_innovation.png
  AssetGenImage get brandInnovation =>
      const AssetGenImage('assets/images/brand_innovation.png');

  /// File path: assets/images/brand_videos.png
  AssetGenImage get brandVideos =>
      const AssetGenImage('assets/images/brand_videos.png');

  /// File path: assets/images/cme.png
  AssetGenImage get cme => const AssetGenImage('assets/images/cme.png');

  /// File path: assets/images/empty-folder.png
  AssetGenImage get emptyFolder =>
      const AssetGenImage('assets/images/empty-folder.png');

  /// File path: assets/images/home.png
  AssetGenImage get home => const AssetGenImage('assets/images/home.png');

  /// File path: assets/images/ldb_me_logo.png
  AssetGenImage get ldbMeLogo =>
      const AssetGenImage('assets/images/ldb_me_logo.png');

  /// File path: assets/images/lldd.png
  AssetGenImage get lldd => const AssetGenImage('assets/images/lldd.png');

  /// File path: assets/images/more.png
  AssetGenImage get more => const AssetGenImage('assets/images/more.png');

  /// File path: assets/images/no_image_available.webp
  AssetGenImage get noImageAvailable =>
      const AssetGenImage('assets/images/no_image_available.webp');

  /// File path: assets/images/riyadh-loreal.png
  AssetGenImage get riyadhLoreal =>
      const AssetGenImage('assets/images/riyadh-loreal.png');

  /// File path: assets/images/snapchat.png
  AssetGenImage get snapchat =>
      const AssetGenImage('assets/images/snapchat.png');

  /// File path: assets/images/social_media.png
  AssetGenImage get socialMedia =>
      const AssetGenImage('assets/images/social_media.png');

  /// File path: assets/images/speakers.png
  AssetGenImage get speakers =>
      const AssetGenImage('assets/images/speakers.png');

  /// File path: assets/images/survey.png
  AssetGenImage get survey => const AssetGenImage('assets/images/survey.png');

  /// File path: assets/images/venue.png
  AssetGenImage get venue => const AssetGenImage('assets/images/venue.png');

  /// File path: assets/images/voting.png
  AssetGenImage get voting => const AssetGenImage('assets/images/voting.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    agenda,
    askQuestions,
    badge,
    brandInnovation,
    brandVideos,
    cme,
    emptyFolder,
    home,
    ldbMeLogo,
    lldd,
    more,
    noImageAvailable,
    riyadhLoreal,
    snapchat,
    socialMedia,
    speakers,
    survey,
    venue,
    voting,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
