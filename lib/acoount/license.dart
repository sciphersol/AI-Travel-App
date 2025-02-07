import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Home_screen/hotel_details.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant_widgets/app_color.dart';
import 'login_security.dart';

class PageWidget extends ConsumerWidget {
  PageWidget({super.key});

 final List<DataClass> data=[
   DataClass(title: "Photo", subTitle: "Photo Licensed Attribution", message: "Follow this link to see our photo resources"),
   DataClass(title: "Illustration", subTitle: "Illustration Licensed Attribution", message: "Follow this link to see our photo resources")

 ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(text: "kkkk"),
      ),
      body: Padding(padding: const EdgeInsets.all(10.0),
      child: Column(
          children: [
            ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black12.withOpacity(0.05)
                    ),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(text: data[index].title,fontSize: 16,isBold: true,),
                        TextWidget(text: data[index].subTitle,fontSize: 14,isBold: true,),
                        Row(
                          children: [
                            Expanded(child: TextWidget(text: data[index].message,fontSize: 14,)),
                            const Icon(Icons.navigate_next),
                            InkWell(
                              onTap: ()async {
                                final Uri url = Uri.parse("https://www.linkedin.com/feed/");

                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url, mode: LaunchMode.externalApplication);
                                } else {
                                  // Fallback: Open in WebView if external app/browser is not available
                                  await launchUrl(url, mode: LaunchMode.inAppWebView);
                                }
                              },
                              child: const Text(
                                'Visit link',
                                style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
                              ),
                            )

                          ],
                        )
                      ],
                    ),
                  );
                })
        ],
      ),
      ),
    );
  }
}
