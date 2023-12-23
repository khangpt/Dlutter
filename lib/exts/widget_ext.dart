import 'dart:ui';

import 'package:dlutter/exts/list_extension.dart';
import 'package:dlutter/exts/number_ext.dart';
import 'package:flutter/material.dart';
import 'string_ext.dart';

typedef WidgetTransform = Widget Function(Widget);

extension WidgetExt on Widget {
  Widget toSizedBox([double? width, double? height]) =>
      SizedBox(width: width, height: height, child: this);

  Widget toCenter() => Center(child: this);

  /// create a decorated container (without size altered)
  Widget toDecoratedBox({
    Color? bgColor,
    ImageProvider<Object>? bgImage,
    BoxShape? boxShape,
    BorderRadius? borderRadius,
    Border? border,
    bool? inFrontOfChild,
    bool? hasShadow,
  }) =>
      DecoratedBox(
        decoration: BoxDecoration(
            color: bgColor,
            image: bgImage != null ? DecorationImage(image: bgImage, fit: BoxFit.cover) : null,
            shape: boxShape ?? BoxShape.rectangle,
            borderRadius: borderRadius,
            border: border,
            boxShadow: (hasShadow ?? false)
                ? [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 3,
                        spreadRadius: 0.5,
                        offset: const Offset(0, 3))
                  ]
                : null),
        position: (inFrontOfChild ?? false)
            ? DecorationPosition.foreground
            : DecorationPosition.background,
        child: this,
      );

  Widget toExpanded([bool? tight]) => tight ?? true ? Expanded(child: this) : Flexible(child: this);

  Widget toScrollableView({
    Axis? direction,
    bool scrollable = true,
    ScrollController? controller,
    ScrollPhysics? scrollPhysics,
    Key? key,
  }) =>
      SingleChildScrollView(
        key: key,
        scrollDirection: direction ?? Axis.vertical,
        physics: !scrollable ? const NeverScrollableScrollPhysics() : scrollPhysics,
        controller: controller,
        child: this,
      );

  Widget toPadding([EdgeInsets? padding]) => Padding(
        padding: padding ?? EdgeInsets.zero,
        child: this,
      );

  Widget toInkWell({bool hasEffect = false, VoidCallback? onTap}) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: !hasEffect ? Colors.transparent : null,
          highlightColor: !hasEffect ? Colors.transparent : null,
          child: this,
        ),
      );

  /// do blur filter for a Container widget
  Widget toBlurFilter() => this is Container
      ? ClipRRect(
          clipBehavior: Clip.hardEdge,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: this,
          ),
        )
      : this;

  Widget toClipRRect({BorderRadius radius = BorderRadius.zero}) => ClipRRect(
        borderRadius: radius,
        clipBehavior: Clip.hardEdge,
        child: this,
      );

  Widget toClipOval() => ClipOval(clipBehavior: Clip.hardEdge, child: this);

  Widget toTitleButton({
    VoidCallback? onTap,
    Color? bgEnableColor,
    Color? bgDisableColor,
    BorderRadiusGeometry? borderRadius,
  }) =>
      ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgEnableColor ?? Colors.blue,
          disabledBackgroundColor: bgDisableColor ?? Colors.grey,
          padding: [12, 8].toEdgePaddingSymmetric(),
          shape: RoundedRectangleBorder(borderRadius: borderRadius ?? 8.toBorderRadiusAll()),
          shadowColor: Colors.transparent,
          elevation: 0.5,
        ),
        child: this,
      );

  Widget toOutlinedButton({
    VoidCallback? onTap,
    Color? bgEnableColor,
    Color? bgDisableColor,
    Color? borderColor,
  }) =>
      OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: bgEnableColor ?? Colors.transparent,
          disabledBackgroundColor: bgDisableColor ?? Colors.transparent,
          padding: [12, 8].toEdgePaddingSymmetric(),
          shape: RoundedRectangleBorder(borderRadius: 8.toBorderRadiusAll()),
          side: BorderSide(
            color: onTap != null ? (borderColor ?? Colors.black) : Colors.grey,
            width: 1.3,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          shadowColor: Colors.transparent,
          elevation: 0.5,
        ),
        child: this,
      );

  Widget toIconButton({VoidCallback? onTap, EdgeInsets? padding}) => IconButton(
        onPressed: onTap,
        padding: padding ?? 0.toEdgePaddingAll(),
        icon: this,
      );

  InlineSpan toWidgetSpan() => WidgetSpan(
        child: this,
        alignment: PlaceholderAlignment.middle,
      );

  Widget toPositioned({
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
  }) =>
      Positioned(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
          width: width,
          height: height,
          child: this);

  Widget withBadge(
    String value, {
    VoidCallback? onBadgeTap,
    Color textColor = Colors.white,
    Color bgColor = Colors.red,
    Alignment align = Alignment.topLeft,
  }) =>
      [
        this,
        value
            .toText(size: 12, color: textColor)
            .toCenter()
            .toSizedBox(24, 24)
            .toDecoratedBox(bgColor: bgColor)
            .toClipOval()
            .toInkWell(onTap: onBadgeTap)
            .toPositioned(
                left: align == Alignment.topLeft ? 5 : null,
                top: 0,
                right: align == Alignment.topRight ? 5 : null),
      ].toStack(alignment: Alignment.center, clipOutside: false);

  Widget transform(WidgetTransform transform, {ValueGetter<bool>? satisfied}) {
    return (satisfied?.call() ?? false) ? transform(this) : this;
  }
}
