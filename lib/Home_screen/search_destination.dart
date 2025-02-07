import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Home_screen/home_screen.dart';
import 'package:travel_app/Home_screen/hotel_details.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';

class SearchDestination extends ConsumerWidget {
  const SearchDestination({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    List<String> buttonList = [
      "Singapore", "Bali", "Rome", "Paris", "Torino", "Lombok", "Hanci", "Nha Trang", "Hawai"
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 100.0, top: 10.0),
      child: Column(
        spacing: 10.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(text: "Recommendation for you", isBold: true, fontSize: 20),
          const TextWidget(text: "There are many places that you can visit with your family"),
          Wrap(
            spacing: 5.0, // Space between buttons horizontally
            children: buttonList.map((buttonText) {
              return OutlinedButton(
                onPressed: () {

               ref.read(textEditingControllerProvider).text=buttonText;
                },
                child: Text(buttonText, style: const TextStyle(color: Colors.black)),
              );
            }).toList(),
          ),
          lineWidget(),
          const TextWidget(text: "Long holiday to enjoy your life", isBold: true, fontSize: 18),
          const TextWidget(text: "There are many places that you can visit with your family"),
          Container(width: double.infinity,
            height: MediaQuery.sizeOf(context).height*0.6,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                  width: double.infinity,
                  child: Row(
                    children: [
                      const ImageContainer(height: 150, width: 160, isRadius: true, imageUrl: "assets/images/Rectangle29.png"),
                      const SizedBox(width: 10), // Add space between the image and the column
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ButtonWidget(
                            color: Colors.redAccent,
                            width: 100,
                            height: 30,
                            radius: 6.0,
                            title: "Restaurant",
                            onPress: () {},
                          ),
                          const TextWidget(text: "Ling-Ling's Bali", isBold: true),
                          Row(
                            children: [
                              for (var i = 0; i < 5; i++) const Icon(Icons.star, color: Colors.black, size: 15),
                              const SizedBox(width: 10),
                              const TextWidget(text: "(500)"),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
