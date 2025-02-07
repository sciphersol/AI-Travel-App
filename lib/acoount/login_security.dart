import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/constant_widgets/app_color.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';
import 'package:travel_app/view_model/local_auth_controller.dart';

import '../riverpord/riverpord.dart';

class LoginSecurity extends ConsumerWidget {
  LoginSecurity({super.key});

  final List<DataClass> data = [
    DataClass(
        title: "Biometric",
        subTitle: "Actived Biometric Feature",
        message:
        "For fast login & safe with fingerprint or face recognition"),
    DataClass(
        title: "PIN",
        subTitle: "Create PIN",
        message:
        "Use 6 digits PIN verification so that your security account more guaranteed"),
    DataClass(
        title: "Account",
        subTitle: "Deleted Account",
        message:
        "If the account deleted, you can’t enjoy the benefits anymore"),
  ];

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(text: "Login & Security"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:   Column(
      children: [
      ListView.builder(
      itemCount: data.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black12.withOpacity(0.05),
            ),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: data[index].title,
                  fontSize: 16,
                  isBold: true,
                ),
                TextWidget(
                  text: data[index].subTitle,
                  fontSize: 14,
                  isBold: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextWidget(
                        text: data[index].message,
                        fontSize: 14,
                      ),
                    ),
                    if (index == 0)
                      Consumer(
                        builder:(context,ref,child){
                          return  Switch(
                            value: ref.watch(isAuthenticatedProvider),
                            onChanged: (val) async {
                              ref.read(localAuthControllerProvider.notifier).authenticateWithBiometrics(context,);
                            },
                            activeColor: Colors.white,
                            inactiveThumbColor: Colors.white,
                            activeTrackColor: MyAppColor.buttonColor,
                            inactiveTrackColor: const Color(0xffC4C5D3),
                          );
                          
                        }
                      ),
                    if (index != 0) const Icon(Icons.navigate_next),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      ],
    ),
      ),
    );
  }
}

class DataClass {
  String title;
  String subTitle;
  String message;
  DataClass({
    required this.title,
    required this.subTitle,
    required this.message,
  });
}
