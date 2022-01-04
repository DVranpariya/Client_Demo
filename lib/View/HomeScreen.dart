import 'package:flutter/material.dart';
import 'package:future_contract/Resource/CommonWidgets.dart';
import 'package:future_contract/Resource/Constant.dart';
import 'package:future_contract/Resource/PrefManager.dart';
import 'package:future_contract/Resource/Timer-Helper.dart';
import 'package:future_contract/View/Sigin-Screen.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic mil = {
    "problems": [
      {
        "Diabetes": [
          {
            "medications": [
              {
                "medicationsClasses": [
                  {
                    "className": [
                      {
                        "associatedDrug": [
                          {"name": "asprin", "dose": "", "strength": "500 mg"}
                        ],
                        "associatedDrug#2": [
                          {
                            "name": "somethingElse",
                            "dose": "",
                            "strength": "500 mg"
                          }
                        ]
                      }
                    ],
                    "className2": [
                      {
                        "associatedDrug": [
                          {"name": "asprin", "dose": "", "strength": "500 mg"}
                        ],
                        "associatedDrug#2": [
                          {
                            "name": "somethingElse",
                            "dose": "",
                            "strength": "500 mg"
                          }
                        ]
                      }
                    ]
                  }
                ]
              }
            ],
            "labs": [
              {"missing_field": "missing_value"}
            ]
          }
        ],
        "Asthma": [{}]
      }
    ]
  };

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: [
                Center(
                  child: Column(
                    children: [
                      AppText(
                        '${TimerHelper.greeting(DateTime.now())}',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      AppText(
                        PrefManager.getMobileNumber(),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              '${PrefManager.getName().isEmpty ? '' : PrefManager.getName()}'),
          backgroundColor: kPrimaryColor,
          actions: [
            Center(
                child: InkWell(
                    onTap: () {
                      PrefManager.clearAllPrefDb();
                      Get.offAll(LoginScreen());
                    },
                    child: Text('Log Out ')))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Center(
            child: Container(
              height: 20.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: kPrimaryColor),
                  color: Color(0xffAFAFAF)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                      "Medicine Name:- ${mil['problems'][0]['Diabetes'][0]['medications'][0]['medicationsClasses'][0]['className'][0]['associatedDrug'][0]['name']}"),
                  AppText(
                      "Strength:- ${mil['problems'][0]['Diabetes'][0]['medications'][0]['medicationsClasses'][0]['className'][0]['associatedDrug'][0]['strength']}"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
