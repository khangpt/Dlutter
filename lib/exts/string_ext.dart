import 'package:cached_network_image/cached_network_image.dart';
import 'package:dlutter/config/global_config.dart';
import 'package:dlutter/exts/textstyle_ext.dart';
import 'package:dlutter/exts/widget_ext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension StringExt on String {
  Text toText({
    double size = 16,
    FontWeight weight = FontWeight.w600,
    Color color = Colors.white,
    int? lines,
    TextOverflow? overflow,
    TextAlign? align,
  }) =>
      Text(
        this,
        style: GlobalConfig.fontFamily.fsize(size).fweight(weight).fcolor(color),
        maxLines: lines,
        overflow: overflow,
        textAlign: align,
      );

  Widget toSVGImage({
    double? width,
    double? height,
    double? square,
    Color? color,
  }) =>
      SvgPicture.asset(
        '${GlobalConfig.svgAssetFolderPath}/$this',
        width: square ?? width,
        height: square ?? height,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      );

  Widget toJPGImage({
    double? width,
    double? height,
    double? square,
    BoxFit? fit,
    BorderRadius? borderRadius,
    bool isNetwork = false,
  }) =>
      ClipRRect(
        clipBehavior: borderRadius != null ? Clip.hardEdge : Clip.none,
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: isNetwork
            ? CachedNetworkImage(
                imageUrl: this,
                placeholder: (context, url) =>
                    const Icon(Icons.image, color: Colors.white, size: 30),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.white, size: 30),
                width: square ?? width,
                height: square ?? height,
                fit: fit ?? BoxFit.cover,
                maxWidthDiskCache: GlobalConfig.networkImageCachedWidth,
                maxHeightDiskCache: GlobalConfig.networkImageCachedHeight)
            : Image.asset(
                'assets/images/$this',
                width: square ?? width,
                height: square ?? height,
                fit: fit ?? BoxFit.cover,
              ),
      );

  InlineSpan toTextSpan({
    double size = 16,
    FontWeight weight = FontWeight.w600,
    Color color = Colors.white,
    VoidCallback? onTap,
  }) =>
      TextSpan(
          text: this,
          style: GlobalConfig.fontFamily.fsize(size).fweight(weight).fcolor(color),
          recognizer: onTap != null ? (TapGestureRecognizer()..onTap = onTap) : null);

  Widget toTitleButton({
    double? titleSize,
    Color? titleColor,
    VoidCallback? onTap,
    Color? bgEnableColor,
    Color? bgDisableColor,
  }) =>
      toText(
        size: titleSize ?? 14,
        color: titleColor ?? Colors.white,
      ).toTitleButton(
        onTap: onTap,
        bgEnableColor: bgEnableColor,
        bgDisableColor: bgDisableColor,
      );

  Widget toOutlinedButton({
    double? titleSize,
    Color titleColor = Colors.black,
    VoidCallback? onTap,
    Color? bgEnableColor,
    Color? bgDisableColor,
  }) =>
      toText(
        size: titleSize ?? 14,
        color: onTap != null ? titleColor : Colors.grey,
      ).toOutlinedButton(
        onTap: onTap,
        bgEnableColor: bgEnableColor,
        bgDisableColor: bgDisableColor,
        borderColor: titleColor,
      );

  Widget toTextField(
    BuildContext ctx, {
    double? width,
    double? height,
    FocusNode? focusNode,
    ValueChanged<String>? onChanged,
    VoidCallback? onCompleted,
    TextEditingController? controller,
    String? hintText,
    String? errorText,
    bool? enable,
    bool? password,
    TextInputAction? inputAction,
    TextInputType? keyboardType,
    TextAlign? textAlign,
    int? minLines,
    int? maxLines,
    double? textSize,
    FontWeight? textWeight,
    Color? textColor,
    Color? hintColor,
    BoxConstraints? prefixConstraints,
    BoxConstraints? suffixConstraints,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? fillColor,
    Color? borderColor,
    double? borderRadius,
    EdgeInsets? contentPadding,
    bool? filled,
    List<TextInputFormatter>? inputFormatter,
    Key? key,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        width: width,
        height: height,
        child: TextFormField(
          key: key,
          enableInteractiveSelection: true,
          textAlignVertical: TextAlignVertical.center,
          focusNode: focusNode,
          onChanged: onChanged,
          controller: controller,
          initialValue: controller != null ? null : this,
          enabled: enable ?? true,
          minLines: minLines ?? 1,
          maxLines: maxLines ?? 1,
          textInputAction: inputAction ?? TextInputAction.done,
          keyboardType: keyboardType ?? TextInputType.text,
          onEditingComplete: onCompleted,
          obscureText: password ?? false,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          style: GlobalConfig.fontFamily
              .fsize(textSize ?? 14)
              .fweight(textWeight ?? FontWeight.w400)
              .fcolor(textColor ?? Colors.black),
          textAlign: textAlign ?? TextAlign.left,
          inputFormatters: inputFormatter,
          decoration: InputDecoration(
            prefixIconConstraints: prefixConstraints,
            suffixIconConstraints: suffixConstraints,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: GlobalConfig.fontFamily
                .fsize(textSize ?? 14)
                .fweight(textWeight ?? FontWeight.w400)
                .fcolor(hintColor ?? Colors.grey),
            fillColor: fillColor ?? Colors.white,
            filled: filled ?? true,
            contentPadding: contentPadding,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            // OutlineInputBorder(
            //   borderSide: BorderSide(color: borderColor ?? ctx.theme.cSecondary, width: 1),
            //   borderRadius: BorderRadius.circular(borderRadius ?? 8.mb),
            // ),
            focusedBorder: InputBorder.none,
            // OutlineInputBorder(
            //   borderSide: BorderSide(color: borderColor ?? ctx.theme.cHighlightRed, width: 2.mb),
            //   borderRadius: BorderRadius.circular(borderRadius ?? 8.mb),
            // ),
          ),
        ),
      ),
      // if (errorText != null) ...[
      //   SizedBox(height: 5.mb),
      //   toTextOneLine(style: ctx.theme.sHighlightRed(12.mb).ellipsis.italic),
      // ],
    ]);
  }
}
