import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Home_screen/filter_result.dart';
import 'package:travel_app/Home_screen/hotel_details.dart';
import 'package:travel_app/constant_widgets/app_color.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';
import 'package:travel_app/firebase/model/filter.dart';

final filterScreenBoolProvider =
    StateProvider<List<bool>>((ref) => [false, false, false]);
final filterScreenIsHighlightedProvider =
    StateProvider<List<bool>>((ref) => [false, false, false]);

final filterScreenPriceRangeProvider=StateProvider<int>((ref)=>400);

final filterScreenStringSelectedOptionProvider =
    StateProvider<String>((ref) => '');

class FilterScreen extends ConsumerWidget {
  FilterScreen({super.key});

  final List<String> radioList = [
    "Price (low-high)",
    "Newest first",
    "Top sellers",
    "Price (high-low)",
    "Customer top rated"
  ];

  final List<String> itemList = ["Hotel", "Attraction", "Restaurant"];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: MyAppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyAppColor.backgroundColor,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.close)),
        title: const TextWidget(
          text: "Filter",
          isBold: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lineWidget(),
              const TextWidget(
                text: "Category",
                isBold: true,
                fontSize: 20,
              ),
              const TextWidget(text: "Lorem ipsum dolor sit amet consectetur"),
              SizedBox(
                height: 50,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: OutlinedButton(
                            onPressed: () {
                              ref.read(filterScreenIsHighlightedProvider
                                      .notifier)
                                  .update((state) {
                                state[index] = !state[index];
                                return List.from(state);
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  color: ref.watch(
                                              filterScreenIsHighlightedProvider)[
                                          index]
                                      ? Colors.blue
                                      : Colors.black), // Border color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    45), // Rounded corners
                              ),
                            ),
                            child: ref.watch(
                                    filterScreenIsHighlightedProvider)[index]
                                ? TextWidget(
                                    text: itemList[index],
                                    color: MyAppColor.buttonColor,
                                  )
                                : TextWidget(text: itemList[index])),
                      );
                    }),
              ),
              lineWidget(),
              const TextWidget(
                text: "Sort By",
                isBold: true,
                fontSize: 20,
              ),
              const TextWidget(text: "Lorem ipsum dolor sit amet consectetur"),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: radioList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Radio<String>(
                          activeColor: MyAppColor.buttonColor,
                          value: radioList[index],
                          groupValue: ref
                              .watch(filterScreenStringSelectedOptionProvider),
                          onChanged: (value) {
                            if (value != null) {
                              ref
                                  .read(filterScreenStringSelectedOptionProvider
                                      .notifier)
                                  .state = value;
                            }
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(radioList[index])
                      ],
                    );
                  }),
              lineWidget(),
              const TextWidget(
                text: "Price range",
                isBold: true,
                fontSize: 20,
              ),
              const TextWidget(text: "Lorem ipsum dolor sit amet consectetur"),
              SizedBox(
                height: 70,
                child: ListView.builder(
                    itemCount: PriceRange.priceRange.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final value = PriceRange.priceRange[index];
                      return Row(
                        children: [
                         GestureDetector(
                           onTap:(){
                             ref.read(filterScreenPriceRangeProvider.notifier).state=value.price;
                           },

                           child:  Container(
                             width: 150,
                             decoration: BoxDecoration(
                               border: Border.all(
                                 color: Colors.grey, // Border color
                                 width: 1.5, // Border width
                               ),
                               borderRadius:
                               BorderRadius.circular(10), // Rounded corners
                             ),
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                               children: [
                                 Text(value.text.toString()),
                                 TextWidget(
                                   text: "\$${value.price.toString()}",
                                   isBold: true,
                                 )
                               ],
                             ),
                           ),
                         ),
                          if (index == 0)
                            const Icon(
                              Icons.arrow_forward,
                              size: 50,
                              color: Colors.grey,
                            )
                        ],
                      );
                    }),
              ),
              lineWidget(),
              const TextWidget(
                text: "Booking option",
                isBold: true,
                fontSize: 20,
              ),
              const TextWidget(text: "Lorem ipsum dolor sit amet consectetur"),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    List<String> list = [
                      "Instan confirmation",
                      "Refundable",
                      "Allow pets"
                    ];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(text: list[index], isBold: true),
                        Switch(
                          value: ref.watch(filterScreenBoolProvider)[index],
                          onChanged: (val) {
                            ref.read(filterScreenBoolProvider.notifier)
                                .update((state) {
                              state[index] = val;
                              return List.from(state);

                            });
                          },
                          activeColor: Colors.white,
                          inactiveThumbColor: Colors.white,
                          activeTrackColor: MyAppColor.buttonColor,
                          inactiveTrackColor: const Color(0xffC4C5D3),
                        ),
                      ],
                    );
                  }),
              Row(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      ref
                          .read(
                              filterScreenStringSelectedOptionProvider.notifier)
                          .state = '';
                      ref
                          .read(filterScreenIsHighlightedProvider.notifier)
                          .state = [false, false, false];
                      ref.read(filterScreenBoolProvider.notifier).state = [
                        false,
                        false,
                        false
                      ];
                    },
                    child: const TextWidget(
                      text: "Clear all",
                      isBold: true,
                      fontSize: 20,
                    ),
                  ),
                  ButtonWidget(
                    radius: 10.0,
                    width: 150,
                    onPress: () {

                      HotelFilter filter = HotelFilter(

                        charges: ref.watch(filterScreenPriceRangeProvider).toString(),
                        instanConfirmation: ref.watch(filterScreenBoolProvider)[0],
                        refundable: ref.watch(filterScreenBoolProvider)[1],
                        allowPets: ref.watch(filterScreenBoolProvider)[2],
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => FilterResult(
                            filter: filter,
                            collectionName: 'hotel',
                          ),
                        ),
                      );
                    },
                    title: "Show all places",
                  )

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PriceRange {
  int price;
  String text;
  PriceRange({required this.price, required this.text});

  static List<PriceRange> priceRange = [
    PriceRange(price: 50, text: "Minimum"),
    PriceRange(price: 245, text: "Maximum")
  ];
}

///
