import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constant_widgets/app_color.dart';
import '../constant_widgets/custom_icons.dart';
import '../constant_widgets/widget_ui_components.dart';
import '../firebase/model/hotel_class.dart';
import 'hotel_details.dart';

class AttractionScreen extends StatelessWidget {
  AttractionScreen({
    super.key,
    required this.imageUrl,
    required this.hotel,
  });
  final String imageUrl;
  final Hotel hotel;
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 300,
                  child: PageView.builder(
                      controller: controller,
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        List<IconData> iconList = [
                          Icons.arrow_back,
                          Icons.share,
                          Icons.share,
                          Icons.favorite_border,
                        ];
                        List<Function> functionList = [
                          () => Navigator.pop(context),
                          () => null,
                          () => null,
                              () => null,
                        ];
                        return ImageContainer(
                          imageUrl: imageUrl,
                          width: MediaQuery.sizeOf(context).width,
                          isRadius: false,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  spacing: 10,
                                  children: List.generate(iconList.length, (index) {
                                    if (index == 1) {
                                      return const Spacer();  // Directly using Spacer when index is 1
                                    }
                                    return Container(
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          functionList[index]();
                                        },
                                        child: Icon(iconList[index]),
                                      ),
                                    );
                                  }),
                                ),
                                SmoothPageIndicator(
                                  controller: controller,
                                  count: 5,
                                  effect: const ExpandingDotsEffect(
                                    expansionFactor: 1.1,
                                    activeDotColor: MyAppColor.buttonColor,
                                    dotColor: Colors.grey,
                                    dotHeight: 10.0,
                                    dotWidth: 10.0,
                                    spacing: 10.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                TextWidget(text: hotel.name,fontSize: 24,isBold: true,),
                const Row(
                  spacing: 10,
                  children: [
                    Icon(Icons.location_on),
                    TextWidget(text: "Pecatu, South Kuta, Badung Regency, Bali")
                  ],
                ),
                const Row(
                  spacing: 10,
                  children: [
                    Icon(
                      Icons.access_time_filled,
                    ),
                    TextWidget(text: "Open. Sun, 07:00 pm - 07:00 pm"),
                    Spacer(),
                    Icon(Icons.navigate_next)
                  ],
                ),
                 OutlineButtonWidget(rating: hotel.rating,noReviews: hotel.reviewCount,),
                const TextWidget(
                  text: "Buy your ticket",
                  isBold: true,
                  fontSize: 20,
                ),
                Container(
                  height: 90,
                  padding: const EdgeInsets.all(5.0),
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dateList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          // height: 30,
                          margin: const EdgeInsets.only(right: 5.0),
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey, // Border color
                              width: 1.5, // Border width
                            ),
                            borderRadius:
                                BorderRadius.circular(8), // Rounded corners
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidget(text: dayList[index]),
                              index == 0
                                  ? const Icon(Icons.calendar_today_outlined)
                                  : TextWidget(
                                      text: dateList[index],
                                      isBold: true,
                                    )
                            ],
                          ),
                        );
                      }),
                ),
                OfferWidget(
                  iconList: iconList,
                  textList: textList,
                  ticketType: tickets,
                ),
                Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextWidget(
                          text: "What they said about us",
                          isBold: true,
                          fontSize: 20,
                        ),
                        const TextWidget(
                          text:
                              "Lorem ipsum dolor sit amet consectetur. Eu interdum sed pretium nulla",
                          fontSize: 12,
                        ),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 250,
                                  margin: const EdgeInsets.all(5.0),
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey, // Border color
                                      width: 0.5, // Border width
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        8), // Rounded corners
                                  ), // Space inside the border
                                  child: Column(
                                    children: [
                                      Row(
                                        children: List.generate(
                                          5, // Number of stars
                                          (index) => const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 15.0,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8), // Add spacing
                                      const TextWidget(
                                        text:
                                            "Lorem ipsum dolor sit amet consectetur. Eu interdum sed pretium nulla neque purus velit quis massa.",
                                        fontSize: 9,
                                      ),
                                      const SizedBox(height: 12), // Add spacing
                                      ListTileWidget(
                                        title: "Susan Cole",
                                        subtitle: "Tokyo, Japan",
                                        leadingWidget: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            image: const DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                "https://thumbs.wbm.im/pw/small/39573f81d4d58261e5e1ed8f1ff890f6.jpg",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ],
                    )),
                Container(
                  height: 200,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(
                        text: "Location",
                        isBold: true,
                        fontSize: 20,
                      ),
                      const TextWidget(
                        text:
                            "Lorem ipsum dolor sit amet consectetur. Eu interdum sed pretium nulla",
                        fontSize: 12,
                      ),
                      Container(
                        height: 100,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      children: [
                        TextWidget(text: "Starting from"),
                        TextWidget(
                          text: "\$95/Pax",
                          isBold: true,
                          fontSize: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 150,
                      child: ButtonWidget(
                        onPress: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(16.0),
                                      width: double.infinity,
                                      //height: MediaQuery.sizeOf(context).height*0.8,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: OfferWidget(
                                        iconList: iconList,
                                        textList: textList,
                                        ticketType: tickets,
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        title: "Select ticket",
                        radius: 15,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OfferWidget extends StatelessWidget {
  final List<IconData> iconList;
  final List<String> textList;
  final List<String> ticketType;

  const OfferWidget({
    super.key,
    required this.iconList,
    required this.textList,
    required this.ticketType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyAppColor.textFieldColor,
      height: 300,
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ticketType.length,
        itemBuilder: (context, index) {
          return Container(
            width: 250,
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey, // Border color
                width: 0.5, // Border width
              ),
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 3.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: ticketType[index],
                    isBold: true,
                    fontSize: 20,
                  ),
                  for (var i = 0; i < 4; i++) // Loop to create 5 rows
                    Row(
                      spacing: 5.0,
                      children: [
                        Icon(iconList[i], color: Colors.blue),
                        TextWidget(text: textList[i]),
                      ],
                    ),
                  TextWidget(
                      text: priceList[index], isBold: true, fontSize: 20),
                  ButtonWidget(
                    radius: 15,
                    onPress: () {
                      // Navigator.of(context).pop();
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingDetailsScreen(imageUrl: widget.imageUrl,)));
                    },
                    title: "Select ticket",
                  ),
                  // Add spacing
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

List<String> dayList = [
  "Date",
  "Today",
  "Sun",
  "Mon",
  "Tue",
  "Wed",
  "Thu",
  "Fri",
  "Sat"
];
List<String> dateList = [
  "Jan 26",
  "Jan 27",
  "Jan 28",
  "Jan 29",
  "Jan 30",
  "Jan 31",
];

List<IconData> iconList = [
  CustomIcons.store,
  Icons.check_circle,
  CustomIcons.arrow_left,
  CustomIcons.store,
];

List<String> textList = [
  "Order ticket for today",
  "Instant confirmation",
  "Non-Refundable",
  "Valid on selected date"
];

List<String> tickets = ["Regular ticket", "VIP ticket", "Standard ticket"];
List<String> priceList = [
  "\$95/Pax",
  "\$110/Pax",
  "\$120/Pax",
  "\$135/Pax",
  "\$150/Pax",
  "\$170/Pax"
];
