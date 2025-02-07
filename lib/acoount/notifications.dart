import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/constant_widgets/app_color.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';

class Notifications extends ConsumerWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(text: "Notification"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: MyAppColor.textFieldColor,
                        ),
                        child: const Icon(Icons.notifications, color: MyAppColor.buttonColor),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: "Finish your payment",
                              isBold: true,
                              fontSize: 16,
                            ),
                            Text(
                              "Finish your payment right now! so you can enjoy waiting for your holiday",
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            TextWidget(
                              text: "Jan 25, 2023",
                              isBold: true,
                              fontSize: 14,
                            )
                          ],
                        ),
                      ),
                      const Icon(Icons.circle, color: MyAppColor.buttonColor, size: 15),
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
