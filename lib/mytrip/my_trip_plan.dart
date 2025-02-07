import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/constant_widgets/app_color.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';
import 'package:travel_app/mytrip/trip_setting.dart';

import 'edit_itinerary.dart';

final boolListProvider = StateProvider<List<bool>>((ref) => [false,false,false,false]);
final dayProvider=StateProvider<int>((ref)=>0);

class MyTripPlan extends ConsumerWidget {
   MyTripPlan({super.key});

  final List<String> list=[
    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
  "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg",
    "https://media.istockphoto.com/id/1682296067/photo/happy-studio-portrait-or-professional-man-real-estate-agent-or-asian-businessman-smile-for.jpg?s=612x612&w=0&k=20&c=9zbG2-9fl741fbTWw5fNgcEEe4ll-JegrGlQQ6m54rg="
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boolList = ref.watch(boolListProvider);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          ImageContainer(
            isRadius: false,
            height: 400,
            imageUrl: 'assets/images/Rectangle30.png',
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>TripSetting()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: const Icon(Icons.settings),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                   Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int i = 0; i < 4; i++)
                          Align(
                            widthFactor: 0.6,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(list[i]),
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                          child: const TextWidget(
                            text: "+Invite",
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_month, color: Colors.white),
                              TextWidget(
                                text: "Jan 26 - Jan 30",
                                color: Colors.white,
                                isBold: true,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.white),
                              TextWidget(
                                text: "Bali & Singapore",
                                color: Colors.white,
                                isBold: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        spacing: 10,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (builder)=>EditItinerary()));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: const Icon(Icons.edit),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.map),
                                TextWidget(text: "Map"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.black12,
            height: 40,
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return  Consumer(
                  builder:(context,ref,child)=> TextWidget(
                    text: " Day ${index + 1}",
                    isBold: true,
                    color: ref.watch(dayProvider)==index &&ref.watch(boolListProvider)[index]==true? Colors.black:Colors.grey,
                  ),
                );
              },
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: ref.watch(boolListProvider).length, // Example number of days
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          ref.read(dayProvider.notifier).state=index;
                          // Toggle the specific index dynamically
                          ref.read(boolListProvider.notifier).state = [
                            ...boolList.sublist(0, index),
                            !boolList[index],
                            ...boolList.sublist(index + 1),
                          ];
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: "January ${26+index}, Day ${index + 1}",
                              isBold: true,
                              fontSize: 16,
                            ),
                            Icon(
                              boolList[index]
                                  ? Icons.keyboard_arrow_down_rounded
                                  : Icons.keyboard_arrow_up_rounded,
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 2,
                        itemBuilder: (context, subIndex) {
                          return Visibility(
                            visible: boolList[index],
                            child: ThreeWidgetContainer(
                              isRadius: true,
                              imageWidth: 174,
                              imageHeight: double.infinity,
                              imageUrl: "assets/images/Rectangle31.png",
                              title: "Uluwatu Temple",
                              isLine: true,
                              widget: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  for (int i = 0; i < 5; i++)
                                    const Icon(
                                      Icons.star,
                                      color: Colors.black,
                                      size: 12,
                                    ),
                                  const SizedBox(width: 5),
                                  const TextWidget(
                                    text: "4.8",
                                    isBold: true,
                                    fontSize: 10,
                                  ),
                                ],
                              ),
                              onTap: (){

                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    margin: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: const TextWidget(
                                      text: "Attraction",
                                      color: MyAppColor.buttonColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
