import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:future_contract/Resource/CommonWidgets.dart';
import 'package:future_contract/Resource/Constant.dart';
import 'package:future_contract/View/EnterOTPScreen.dart';
import 'package:sizer/sizer.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                AppTextBold(
                  "Sign in",
                  fontSize: 20.sp,
                ),
                AppText(
                  "Sign in to continue",
                  fontSize: 8.sp,
                  color: kGreyColor,
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  prefexIcon: CountryCodePicker(
                    onChanged: (val) {},
                    initialSelection: 'GB',
                    favorite: ['+44', 'GB'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                  ),
                  hintText: "Enter mobile number",
                  label: "Mobile number",
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: BottomButton(
                    color: kPrimaryColor,
                    textcolor: Colors.white,
                    title: "Generate OTP",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EnterScreen()));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
