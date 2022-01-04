import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:future_contract/Resource/CommonWidgets.dart';
import 'package:future_contract/Resource/Constant.dart';
import 'package:future_contract/Resource/PrefManager.dart';
import 'package:future_contract/Resource/controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'HomeScreen.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StateChange _stateChange = Get.find();
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  final nameController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  String countryCode = '+44';

  String? verificationId;

  bool showLoading = false;

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
    otpController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: SingleChildScrollView(
        child: Container(
          child: showLoading
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  ),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileEnterOtpWidget(context)
                  : getOtpFormWidget(context),
          padding: EdgeInsets.all(16),
        ),
      ),
    );
  }

  ///
  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
      _stateChange.isOtpSend.value = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
        _stateChange.isOtpSend.value = false;
      });

      if (authCredential.user != null) {
        PrefManager.setName(name: nameController.text);

        PrefManager.setMobileNumber(name: phoneController.text);

        Get.offAll(HomeScreen());
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
      );
    }
  }

  ///
  getMobileEnterOtpWidget(context) {
    return Column(
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
          preftext: "",
          controller: nameController,
          hintText: "Name",
          label: "Name ",
        ),
        SizedBox(height: 2.h),
        CustomTextField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          controller: phoneController,
          preftext: "",
          input: TextInputType.number,
          prefexIcon: CountryCodePicker(
            onChanged: (val) {
              countryCode = val.dialCode!;
              setState(() {});
              print('--dial code--$countryCode');
            },
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
            onPressed: () async {
              if (nameController.text.isNotEmpty) {
                if (phoneController.text.isNotEmpty) {
                  setState(() {
                    showLoading = true;
                  });
                  print('--------country $countryCode');

                  await _auth.verifyPhoneNumber(
                    phoneNumber: countryCode + phoneController.text,
                    verificationCompleted: (phoneAuthCredential) async {
                      setState(() {
                        showLoading = false;
                      });
                      // signInWithPhoneAuthCredential(phoneAuthCredential);
                    },
                    verificationFailed: (verificationFailed) async {
                      _globalKey.currentState!.showSnackBar(
                        SnackBar(
                          content: Text(verificationFailed.message!),
                        ),
                      );
                    },
                    codeSent: (verificationId, resendingToken) async {
                      setState(() {
                        showLoading = false;
                        currentState =
                            MobileVerificationState.SHOW_OTP_FORM_STATE;
                        this.verificationId = verificationId;
                      });
                    },
                    codeAutoRetrievalTimeout: (verificationId) async {},
                  );
                } else {
                  _globalKey.currentState!.showSnackBar(
                    SnackBar(
                      content: Text('Mobile Number Is Required'),
                    ),
                  );
                }
              } else {
                _globalKey.currentState!.showSnackBar(
                  SnackBar(
                    content: Text('Name Is Required'),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  ///
  getOtpFormWidget(context) {
    return Column(
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
          controller: otpController,

          hintText: '000000',
          // labelHorizontalPadding: 10,
          // inputType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            LengthLimitingTextInputFormatter(6)
          ],
        ),
        SizedBox(height: 5.h),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
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
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: verificationId!,
                        smsCode: otpController.text);
                print('--------oth------${phoneAuthCredential.token}');
                signInWithPhoneAuthCredential(phoneAuthCredential);
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
        ]),
      ],
    );
  }
}
