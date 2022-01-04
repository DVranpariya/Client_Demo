import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:future_contract/Resource/CommonWidgets.dart';
import 'package:future_contract/Resource/Constant.dart';
import 'package:future_contract/View/HomeScreen.dart';
import 'package:future_contract/View/SignInScreen.dart';
import 'package:sizer/sizer.dart';

class EnterScreen extends StatefulWidget {
  const EnterScreen({Key? key}) : super(key: key);

  @override
  State<EnterScreen> createState() => _EnterScreenState();
}

class _EnterScreenState extends State<EnterScreen> {
  TextEditingController cardNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Center(
              child: AppTextBold(
                "Sign in",
                fontSize: 20.sp,
              ),
            ),
            Center(
              child: AppText(
                "Enter the OTP ",
                fontSize: 8.sp,
                color: kGreyColor,
              ),
            ),
            SizedBox(height: 5.h),
            CustomTextField(
              input: TextInputType.number,
              preftext: "",
              controller: cardNumber,

              hintText: '000000',
              // labelHorizontalPadding: 10,
              // inputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CustomInputFormatter(),
                LengthLimitingTextInputFormatter(6)
              ],
              onChanged: (number) {
                print(number);
                setState(() {
                  cardNumber
                    ..text = number
                    ..selection =
                        TextSelection.collapsed(offset: cardNumber.text.length);
                });
              },
            ),
            SizedBox(height: 1.h),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: "Did not receive a code? ",
                      style: TextStyle(
                          color: kGreyColor,
                          fontFamily: "Regular",
                          fontSize: 8.sp)),
                  TextSpan(
                      text: 'Resend OTP',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontFamily: "Regular",
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp)),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                  },
                  child: Container(
                    height: 6.h,
                    decoration: BoxDecoration(
                        color: Color(0xffF7f7f7),
                        border: Border.all(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(child: AppText("Change number")),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Container(
                    height: 6.h,
                    decoration: BoxDecoration(
                        color: Color(0xffF7f7f7),
                        border: Border.all(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(child: AppText("Sign in")),
                  ),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 6 == 0 && nonZeroIndex != text.length) {
        buffer.write(' ');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}
