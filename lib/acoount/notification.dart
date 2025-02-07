import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';

import '../constant_widgets/app_color.dart';

final travelTipBoolProvider= StateProvider<List<bool>>((ref)=>List.filled(2, false));

final accountActivitiesBoolProvider= StateProvider<List<bool>>((ref)=>List.filled(4, false));

class NotificationPage extends ConsumerWidget {
  NotificationPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final readTravelTipBool=ref.watch(travelTipBoolProvider);
    final readAccountBool=ref.watch(accountActivitiesBoolProvider);
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(text: "Notification",isBold: true,),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(text: "Travel tips and offers",isBold: true,fontSize: 20,),
            const TextWidget(text: "Give you latest tips and offers recommendation for your awesome holiday in everyday"),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  List<String> list = [
                    "Travel article and ideas",
                    "Discount, offers, and promotions",
                  ];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(text: list[index], isBold: true),
                      Switch(
                        value: readTravelTipBool[index],
                        onChanged: (val) {
                          ref.read(travelTipBoolProvider.notifier).state = [
                            ...readTravelTipBool.sublist(0, index),
                            !readTravelTipBool[index],
                            ...readTravelTipBool.sublist(index + 1),
                          ];

                        },
                        activeColor: Colors.white,
                        inactiveThumbColor: Colors.white,
                        activeTrackColor: MyAppColor.buttonColor,
                        inactiveTrackColor: const Color(0xffC4C5D3),
                      ),
                    ],
                  );
                }),
            const TextWidget(text: "Account activities",isBold: true,fontSize: 20,),
            const TextWidget(text: "Receive all notification from our App such as related from your account, price notofication, and order status"),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  List<String> list = [
                    "Account activities",
                    "Price notification",
                    "Order status and payment",
                    "Reviews"
                  ];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(text: list[index], isBold: true),
                      Switch(
                        value: readAccountBool[index],
                        onChanged: (val) {
                          ref.read(accountActivitiesBoolProvider.notifier).state = [
                            ...readAccountBool.sublist(0, index),
                            !readAccountBool[index],
                            ...readAccountBool.sublist(index + 1),
                          ];
                        },
                        activeColor: Colors.white,
                        inactiveThumbColor: Colors.white,
                        activeTrackColor: MyAppColor.buttonColor,
                        inactiveTrackColor: const Color(0xffC4C5D3),
                      ),
                    ],
                  );
                }),

          ],
        ),
      ),
    );
  }
}
