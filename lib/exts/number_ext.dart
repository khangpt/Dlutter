import 'package:flutter/material.dart';

extension NumberExt on num {
  Widget toHPadding() => SizedBox(width: toDouble());
  Widget toVPadding() => SizedBox(height: toDouble());

  EdgeInsets toEdgePaddingAll() => EdgeInsets.all(toDouble());
  EdgeInsets toEdgePaddingHorizontal() => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets toEdgePaddingVertical() => EdgeInsets.symmetric(vertical: toDouble());
  EdgeInsets toEdgePaddingTop() => EdgeInsets.only(top: toDouble());
  EdgeInsets toEdgePaddingRight() => EdgeInsets.only(right: toDouble());
  EdgeInsets toEdgePaddingBottom() => EdgeInsets.only(bottom: toDouble());
  EdgeInsets toEdgePaddingLeft() => EdgeInsets.only(left: toDouble());

  BorderRadius toBorderRadiusAll() => BorderRadius.circular(toDouble());
  BorderRadius toBorderRadiusTopSide() => BorderRadius.vertical(top: toRadius());
  BorderRadius toBorderRadiusBottomSide() => BorderRadius.vertical(bottom: toRadius());
  BorderRadius toBorderRadiusLeftSide() => BorderRadius.horizontal(left: toRadius());
  BorderRadius toBorderRadiusRightSide() => BorderRadius.horizontal(right: toRadius());

  Radius toRadius() => Radius.circular(toDouble());
}
