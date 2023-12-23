import 'package:flutter/material.dart';

import 'number_ext.dart';
import 'string_ext.dart';
import 'widget_ext.dart';

extension ListExt<T> on List<T> {
  /// [horizontal, vertical] respectively
  EdgeInsets toEdgePaddingSymmetric() {
    if (length == 0 || length != 2) {
      return EdgeInsets.zero;
    }

    assert(this is List<num>, 'toEdgePaddingSymmetric need a list of number');
    final nList = this as List<num>;
    return EdgeInsets.symmetric(
      horizontal: nList.first.toDouble(),
      vertical: nList.last.toDouble(),
    );
  }

  /// [top, left, bottom, right] respectively
  EdgeInsets toEdgePaddingOnly() {
    if (length == 0 || length != 4) {
      return EdgeInsets.zero;
    }

    assert(this is List<num>, 'toEdgePaddingOnly need a list of number');
    final nList = this as List<num>;
    return EdgeInsets.only(
      top: nList.first.toDouble(),
      left: nList[1].toDouble(),
      bottom: nList[2].toDouble(),
      right: nList.last.toDouble(),
    );
  }

  /// [topRight, bottomRight, topLeft, bottomLeft] respectively
  BorderRadius toBorderRadius() {
    if (length == 0 || length != 4) {
      return BorderRadius.zero;
    }

    assert(this is List<num>, 'toBorderRadius need a list of number');
    final nList = this as List<num>;
    return BorderRadius.only(
      topRight: nList.first.toRadius(),
      bottomRight: nList[1].toRadius(),
      topLeft: nList[2].toRadius(),
      bottomLeft: nList.last.toRadius(),
    );
  }

  Widget toRow({
    MainAxisAlignment mainAlign = MainAxisAlignment.start,
    MainAxisSize mainSize = MainAxisSize.max,
    CrossAxisAlignment crossAlign = CrossAxisAlignment.center,
  }) {
    assert(this is List<Widget>, 'toRow need a list of widget');
    return Row(
      mainAxisAlignment: mainAlign,
      mainAxisSize: mainSize,
      crossAxisAlignment: crossAlign,
      children: map((e) => e as Widget).toList(),
    );
  }

  Widget toColumn({
    MainAxisAlignment mainAlign = MainAxisAlignment.start,
    CrossAxisAlignment crossAlign = CrossAxisAlignment.center,
    MainAxisSize mainSize = MainAxisSize.max,
    Key? key,
  }) {
    assert(this is List<Widget>, 'toColumn need a list of widget');
    return Column(
      key: key,
      mainAxisAlignment: mainAlign,
      crossAxisAlignment: crossAlign,
      mainAxisSize: mainSize,
      children: map((e) => e as Widget).toList(),
    );
  }

  Widget toStack({AlignmentGeometry? alignment, bool? clipOutside}) {
    assert(this is List<Widget>, 'toStack need a list of widget');
    return Stack(
      alignment: alignment ?? Alignment.topCenter,
      clipBehavior: (clipOutside ?? true) ? Clip.hardEdge : Clip.none,
      children: map((e) => e as Widget).toList(),
    );
  }

  Widget toRichText({int? lines, TextAlign textAlign = TextAlign.left}) {
    assert(this is List<InlineSpan>, 'toRichText need a list of InlineSpan');

    return Text.rich(
      TextSpan(children: map((e) => e as InlineSpan).toList()),
      overflow: lines != null ? TextOverflow.ellipsis : null,
      maxLines: lines,
      textAlign: textAlign,
    );
  }

  /// [Widget? leading, String title, List<Widget>? actions] respectively
  PreferredSizeWidget toAppBar(
    BuildContext ctx, {
    Color? bgColor,
    Color? titleColor,
    Color? navBackColor,
    VoidCallback? overrideTapBack,
    PreferredSizeWidget? bottom,
  }) {
    assert(length == 3, 'toAppBar need exactly 3 items to run properly');
    assert(first is Widget?, 'toAppBar need first object is a Widget?');
    assert(this[1] is String, 'toAppBar need second object is a String');
    assert(last is List<Widget>?, 'toAppBar need last object is a List<Widget>?');

    final leading = (first as Widget?) ??
        'Back-Lg.svg'
            .toSVGImage(square: 24, color: navBackColor)
            .toIconButton(onTap: overrideTapBack ?? () => Navigator.of(ctx).pop());

    final title = (this[1] as String).toText(size: 18, color: titleColor ?? Colors.black);
    final actions = last as List<Widget>?;

    return AppBar(
      backgroundColor: bgColor ?? Colors.white,
      elevation: 0,
      leading: leading,
      title: title,
      centerTitle: true,
      actions: actions,
      bottom: bottom,
    );
  }
}
