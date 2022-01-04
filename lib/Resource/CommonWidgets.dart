import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import 'Constant.dart';

class AppText extends StatelessWidget {
  final String text, fontFamily;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final double? letterSpacing;
  final double? height;
  final TextDecoration textDecoration;
  final TextAlign textAlign;
  final int maxLines;
  final FontStyle fontStyle;

  AppText(
    this.text, {
    this.fontSize = 14,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w500,
    this.fontFamily = 'Regular',
    this.letterSpacing,
    this.textDecoration = TextDecoration.none,
    this.textAlign = TextAlign.start,
    this.height = 1.4,
    this.maxLines = 100,
    this.fontStyle = FontStyle.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        height: height,
        color: color,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        decoration: textDecoration,
      ),
    );
  }
}

class AppTextBold extends StatelessWidget {
  final String text, fontFamily;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final double? letterSpacing;
  final double? height;
  final TextDecoration textDecoration;
  final TextAlign textAlign;
  final int maxLines;
  final FontStyle fontStyle;

  AppTextBold(
    this.text, {
    this.fontSize = 14,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w300,
    this.fontFamily = 'Sbold',
    this.letterSpacing,
    this.textDecoration = TextDecoration.none,
    this.textAlign = TextAlign.start,
    this.height = 1.4,
    this.maxLines = 100,
    this.fontStyle = FontStyle.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        height: height,
        color: color,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        decoration: textDecoration,
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  CustomTextField({
    this.controller,
    this.input,
    this.label = '',
    this.right_lable = '',
    this.maxLines,
    this.fieldHeight = 50,
    this.focusNode,
    this.hintText,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.initialValue,
    this.readOnly = false,
    this.suffix,
    this.prefixIcon = '',
    this.suffixVisibility = false,
    this.obscureText = false,
    this.img_suffix = '',
    this.enable = true,
    this.preftext,
    this.minLine,
    this.prefexIcon,
  });

  final TextEditingController? controller;
  final TextInputType? input;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? label;
  final String? right_lable;
  final String? prefixIcon;
  final int? maxLines;
  final double fieldHeight;
  final FocusNode? focusNode;
  final String? hintText;
  final Function()? onTap;
  final String? initialValue;
  final bool readOnly;
  final Widget? suffix;
  final Widget? prefexIcon;
  final String? img_suffix;
  final String? preftext;
  final int? minLine;
  bool suffixVisibility;
  bool obscureText;
  bool enable;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  toggle() {
    setState(() {
      widget.obscureText = !widget.obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(widget.label!,
                color: kGreyColor,
                fontWeight: FontWeight.w400,
                fontSize: 8.sp,
                fontFamily: 'Regular'),
            AppText(widget.right_lable!,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 8.sp,
                fontFamily: 'Regular'),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          height: widget.fieldHeight,
          child: TextField(
            minLines: widget.minLine,
            obscureText: widget.obscureText,
            obscuringCharacter: '*',
            readOnly: widget.readOnly,
            cursorColor: Color(0xffAFAFAF),
            focusNode: widget.focusNode,
            //maxLines: widget.maxLines,
            controller: widget.controller,
            keyboardType: widget.input,
            onChanged: widget.onChanged,
            enabled: widget.enable,
            onTap: widget.onTap,
            inputFormatters: widget.inputFormatters,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Regular',
                fontSize: 13,
                decoration: TextDecoration.none),
            decoration: InputDecoration(
              prefixIcon: widget.prefexIcon,
              border: InputBorder.none,
              suffix: widget.suffixVisibility == true
                  ? GestureDetector(
                      child: widget.obscureText
                          ? Image.asset("assets/icons/ic_hide.png", scale: 4.8)
                          : Image.asset(
                              "assets/icons/ic_show.png",
                              scale: 6,
                            ),
                      onTap: toggle,
                    )
                  : AppText('${widget.preftext}'),
              filled: true,
              fillColor: Color(0xffF7f7f7),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  color: kPrimaryColor, fontFamily: 'Regular', fontSize: 13),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              focusedBorder: kOutlineInputBorder,
              enabledBorder: kOutlineInputBorder,
              disabledBorder: kOutlineInputBorder,
              errorBorder: kOutlineInputBorder,
              focusedErrorBorder: kOutlineInputBorder,
            ),
          ),
        ),
      ],
    );
  }
}

class BottomButton extends StatelessWidget {
  final String title;
  final String icon;
  final double height;
  final Color color;
  final double borderRadius;
  final Color textcolor;
  final onPressed;

  const BottomButton(
      {this.title = '',
      this.onPressed,
      this.icon = '',
      this.height = 50,
      this.borderRadius = 16.0,
      required this.color,
      required this.textcolor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width, height),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: kPrimaryColor)),
      ),
      onPressed: onPressed,
      child: icon == ''
          ? AppText(title,
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
              fontFamily: 'Sbold',
              color: textcolor)
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('$ICON_URL/$icon', height: 18.h, width: 18.w),
                  AppText(title,
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp,
                      fontFamily: 'Sbold',
                      color: textcolor),
                  SizedBox(width: 20),
                ],
              ),
            ),
    );
  }
}
