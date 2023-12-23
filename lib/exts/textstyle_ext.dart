import 'package:flutter/material.dart';

extension TextStyleExt on TextStyle {
  /// font size
  TextStyle fsize(double fz) => copyWith(fontSize: fz);

  /// font color
  TextStyle fcolor(Color c) => copyWith(color: c);

  /// weight style
  TextStyle fweight(FontWeight w) => copyWith(fontWeight: w);
  TextStyle get normal => copyWith(fontWeight: FontWeight.w400);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  /// italic style
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  /// truncate style
  TextStyle get ellipsis => copyWith(overflow: TextOverflow.ellipsis);
  TextStyle get clip => copyWith(overflow: TextOverflow.clip);
  TextStyle get fade => copyWith(overflow: TextOverflow.fade);
}
