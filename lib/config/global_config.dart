import 'package:flutter/material.dart';

class GlobalConfig {
  const GlobalConfig._();
  static GlobalConfig? _instance;

  static late TextStyle _fontFamily;
  static TextStyle get fontFamily => _fontFamily;

  static late String _svgAssetFolderPath;
  static String get svgAssetFolderPath => _svgAssetFolderPath;

  static late String _imgAssetFolderPath;
  static String get imgAssetFolderPath => _imgAssetFolderPath;

  static late int _networkImageCachedWidth;
  static int get networkImageCachedWidth => _networkImageCachedWidth;

  static late int _networkImageCachedHeight;
  static int get networkImageCachedHeight => _networkImageCachedHeight;

  static GlobalConfig ensureDlutterStarted({
    TextStyle? fontFamily,
    String? svgAssetFolderPath,
    String? imgAssetFolderPath,
    int? networkImgCachedWidth,
    int? networkImgCachedHeight,
  }) {
    _instance ??= const GlobalConfig._();
    _fontFamily = fontFamily ?? const TextStyle();
    _svgAssetFolderPath = svgAssetFolderPath ?? 'assets/svg_images/';
    _imgAssetFolderPath = imgAssetFolderPath ?? 'assets/images/';
    _networkImageCachedWidth = networkImgCachedWidth ?? 500;
    _networkImageCachedHeight = networkImgCachedHeight ?? 800;
    return _instance!;
  }
}
