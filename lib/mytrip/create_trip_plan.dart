import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Home_screen/home_screen.dart';
import 'package:travel_app/constant_widgets/app_color.dart';
import 'package:travel_app/constant_widgets/custom_icons.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';
import 'package:travel_app/firebase/firebase_crud_operations.dart';
import 'package:travel_app/firebase/model/trip.dart';
import 'package:travel_app/riverpord/riverpord.dart';
import 'package:travel_app/wishlist/add_to_wishlist.dart';

import 'my_trip_plan.dart';
final rangeStartAndRangeEndProvider =
    StateNotifierProvider<RangeStartEndNotifier, RangeStartAndRangeEnd>((ref) {
  return RangeStartEndNotifier();
});

class RangeStartAndRangeEnd {
  final DateTime? rangeStart;
  final DateTime? rangeEnd;

  RangeStartAndRangeEnd({this.rangeStart, this.rangeEnd});
}

class RangeStartEndNotifier extends StateNotifier<RangeStartAndRangeEnd> {
  RangeStartEndNotifier() : super(RangeStartAndRangeEnd());

  void updateRange(DateTime? start, DateTime? end, DateTime focusedDay) {
    state = RangeStartAndRangeEnd(rangeStart: start, rangeEnd: end);
  }

  void updateSingleDate(DateTime selectedDay) {
    state = RangeStartAndRangeEnd(rangeStart: selectedDay, rangeEnd: null);
  }

  void clearRange() {
    state = RangeStartAndRangeEnd();
  }
}

class TripDataClass {
  String destination;
  DateTime checkIn;
  DateTime checkOut;
  String partner;
  List<String> interestList;
  String interestListOptional;
  String budgetType;
  String specificBudgetTypeOptional;

  TripDataClass({
    required this.destination,
    required this.checkIn,
    required this.checkOut,
    required this.partner,
    required this.interestList,
    required this.interestListOptional,
    required this.budgetType,
    required this.specificBudgetTypeOptional,
  });

  TripDataClass copyWith({
    String? destination,
    DateTime? checkIn,
    DateTime? checkOut,
    String? partner,
    List<String>? interestList,
    String? interestListOptional,
    String? budgetType,
    String? specificBudgetTypeOptional,
  }) {
    return TripDataClass(
      destination: destination ?? this.destination,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      partner: partner ?? this.partner,
      interestList: interestList ?? this.interestList,
      interestListOptional: interestListOptional ?? this.interestListOptional,
      budgetType: budgetType ?? this.budgetType,
      specificBudgetTypeOptional:
      specificBudgetTypeOptional ?? this.specificBudgetTypeOptional,
    );
  }


}

class Trip extends StateNotifier<TripDataClass> {
  Trip()
      : super(TripDataClass(
    destination: "",
    checkIn:DateTime.now().add(Duration(days: 1)),
    checkOut: DateTime.now().add(Duration(days: 7)),
    partner: "",
    interestList: [],
    interestListOptional: "",
    budgetType: "",
    specificBudgetTypeOptional: "",
  ));

  void update({
    String? destination,
    DateTime? checkIn,
    DateTime? checkOut,
    String? partner,
    List<String>? interestList,
    String? interestListOptional,
    String? budgetType,
    String? specificBudgetTypeOptional,
  }) {
    state = state.copyWith(
      destination: destination,
      checkIn: checkIn,
      checkOut: checkOut,
      partner: partner,
      interestList: interestList,
      interestListOptional: interestListOptional,
      budgetType: budgetType,
      specificBudgetTypeOptional: specificBudgetTypeOptional,
    );
  }
  void clearData(){
    state= TripDataClass(destination: '',
        checkIn: DateTime.now(),
        checkOut: DateTime.now(),
        partner: '',
        interestList: [],
        interestListOptional: '',
        budgetType: '',
        specificBudgetTypeOptional: '');
  }
}

final tripDataProvider=StateNotifierProvider<Trip,TripDataClass>((ref)=>Trip());
final pageControllerProvider = Provider((ref) => PageController());

final pageNavigator=Provider((ref){
   if (ref.watch(pageControllerProvider).hasClients) {
   return ref.read(pageControllerProvider).animateToPage(
      ref.watch(pageIndexProvider) + 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
});

class CreateTripPlan extends ConsumerWidget {
  CreateTripPlan({super.key});
  final DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int indexProvider = ref.watch(pageIndexProvider); // Read provider value
    final pageNotifier =
        ref.read(pageIndexProvider.notifier); // Update provider value

    List<Widget> widgetList = [
      Destination(),
      Travelling(),
      Interested(),
      Budget(),
    ];
    return Scaffold(
        backgroundColor: MyAppColor.backgroundColor,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                if (indexProvider == 0) {
                  return;
                } else {
                  pageNotifier.setIndex(indexProvider - 1);
                  //here is the issue
                  if (ref.watch(pageControllerProvider).hasClients) {
                    ref.read(pageControllerProvider).animateToPage(
                          indexProvider - 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                  }
                }
              },
              child: const Icon(Icons.arrow_back)),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const TextWidget(text: "Create trip plan", isBold: true),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                pageNotifier.setIndex(0);
              },
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(Icons.close),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(30),
                  minHeight: 15,
                  value: (indexProvider + 1) /
                      4, // Adjust progress bar according to the index
                  color: MyAppColor.buttonColor,
                  backgroundColor: MyAppColor.textFieldColor,
                ),
                widgetList[ref.watch(pageIndexProvider)],
              ],
            ),
          ),
        ));
  }
}

final addDestinationControllerProvider = StateProvider<String>((ref) => "");

List<String> placesListData = [
  "Singapore",
  "Bali",
  "Rome",
  "Paris",
  "Torino",
  "Jakarta",
  "Surabaya",
  "Lombok",
  "Hanoi",
  "Nha Trang",
  "London",
  "Hawaii"
];

final filteredPlacesProvider =
    StateNotifierProvider<FilteredPlacesNotifier, List<String>>((ref) {
  return FilteredPlacesNotifier();
});

class FilteredPlacesNotifier extends StateNotifier<List<String>> {
  FilteredPlacesNotifier() : super(placesListData);

  void filterList(String input) {
    if (input.isEmpty) {
      state = [
        "Singapore",
        "Bali",
        "Rome",
        "Paris",
        "Torino",
        "Jakarta",
        "Surabaya",
        "Lombok",
        "Hanoi",
        "Nha Trang",
        "London",
        "Hawaii"
      ];
    } else {
      state = state
          .where((place) => place.toLowerCase().contains(input.toLowerCase()))
          .toList();
    }
  }
}

class Destination extends ConsumerWidget {
  Destination({super.key});

  final DateTime today = DateTime.now();

  void _showModelBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Consumer(
          builder: (context, ref, child) => CalendarWidget(
            initialFocusedDay: today,
            rangeStart: ref.watch(rangeStartAndRangeEndProvider).rangeStart,
            rangeEnd: ref.watch(rangeStartAndRangeEndProvider).rangeEnd,
            onRangeSelected: (start, end, focused) {
              ref.read(rangeStartAndRangeEndProvider.notifier)
                  .updateRange(start, end, focused);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int indexProvider = ref.watch(pageIndexProvider);
    final pageNotifier = ref.read(pageIndexProvider.notifier);
    final startDate = ref.watch(rangeStartAndRangeEndProvider).rangeStart;
    final endDate = ref.watch(rangeStartAndRangeEndProvider).rangeEnd;
    final destinationText = ref.watch(addDestinationControllerProvider);
    final TextEditingController destinationController =
        TextEditingController(text: destinationText);

    return Column(
      spacing: 132,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const TextWidget(
                text: "Add destination", isBold: true, fontSize: 20),
            Consumer(
                builder: (context, ref, child) => TextFieldWidget(
                      fillColor: Colors.white,
                      controller:
                          destinationController, // Use the destination text here
                      hintText: "Search your destination",
                      isBorder: true,
                      radius: 30,
                      leadingIcon: Icons.search,
                      onChanged: (value) {
                        ref
                            .read(filteredPlacesProvider.notifier)
                            .filterList(value);
                      },
                    )),
            Consumer(builder: (context, ref, child) {
              final filteredPlaces = ref.watch(filteredPlacesProvider);
              return Wrap(
                spacing: 5.0,
                children: filteredPlaces.map((buttonText) {
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          width: destinationText == buttonText ? 2 : 1,
                          color: destinationText == buttonText
                              ? Colors.blue
                              : Colors.black),
                    ),
                    onPressed: () {
                      ref
                          .read(addDestinationControllerProvider.notifier)
                          .state = buttonText;
                    },
                    child: Text(
                      buttonText,
                      style: TextStyle(
                          color: destinationText == buttonText
                              ? Colors.blue
                              : Colors.black),
                    ),
                  );
                }).toList(),
              );
            }),
            const TextWidget(text: "Trip length", isBold: true, fontSize: 20),
            OutlinedButton(
              onPressed: () {
                _showModelBottomSheet(context, ref);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  spacing: 10,
                  children: [
                    const Icon(Icons.calendar_month, color: Colors.black),
                    TextWidget(
                      text: startDate != null
                          ? '${startDate.day}/${startDate.month}/${startDate.year}'
                          : "Start Date",
                      isBold: true,
                    ),
                    const Icon(Icons.arrow_forward, color: Colors.black),
                    TextWidget(
                      text: endDate != null
                          ? '${endDate.day}/${endDate.month}/${endDate.year}'
                          : "End Date",
                      isBold: true,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        ButtonWidget(
          onPress: () async {
            ref.read(tripDataProvider.notifier).update(
              destination:destinationController.text,
              checkIn: ref.watch(rangeStartAndRangeEndProvider).rangeStart,
              checkOut: ref.watch(rangeStartAndRangeEndProvider).rangeEnd,
            );
            pageNotifier.setIndex(indexProvider + 1);
            ref.read(addDestinationControllerProvider.notifier).state='';
            destinationController.text='';
            ref.read(rangeStartAndRangeEndProvider.notifier).clearRange();
         ref.watch(pageNavigator);
          },
          title: "Next",
        )
      ],
    );
  }
}

///
final whoIsTravellingWithYouProvider = StateProvider<String>((ref) => "");

class Travelling extends ConsumerWidget {
  Travelling(
      {super.key, });


  final List<String> names = ["Solo", "Partner", "Friends", "Family"];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 238,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            const SizedBox(
              height: 40,
            ),
            const TextWidget(
              text: "Who is travelling with you?",
              isBold: true,
              fontSize: 20,
            ),
            const TextWidget(
              text:
                  "Lorem ipsum dolor sit amet consectetur. Eu interdum sed pretium nulla",
              fontSize: 10,
            ),
            GridView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // Ensures GridView doesn't scroll
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    mainAxisSpacing: 20, // Spacing between rows
                    crossAxisSpacing: 20, // Spacing between columns
                    childAspectRatio: .9, // Aspect ratio of each item
                    mainAxisExtent: 130),
                itemCount: names.length,
                itemBuilder: (context, index) {
                  final List<Icon> iconList = [
                    Icon(
                      Icons.person,
                      size: 50,
                      color: ref.watch(whoIsTravellingWithYouProvider) ==
                              names[index]
                          ? Colors.blue
                          : Colors.grey,
                    ),
                    Icon(CustomIcons.partner,
                        size: 50,
                        color: ref.watch(whoIsTravellingWithYouProvider) ==
                                names[index]
                            ? Colors.blue
                            : Colors.grey),
                    Icon(Icons.group,
                        size: 50,
                        color: ref.watch(whoIsTravellingWithYouProvider) ==
                                names[index]
                            ? Colors.blue
                            : Colors.grey),
                    Icon(Icons.groups,
                        size: 50,
                        color: ref.watch(whoIsTravellingWithYouProvider) ==
                                names[index]
                            ? Colors.blue
                            : Colors.grey)
                  ];
                  return GestureDetector(
                    onTap: () {
                      ref.read(whoIsTravellingWithYouProvider.notifier).state =
                          names[index];
                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: ref.watch(whoIsTravellingWithYouProvider) ==
                                    names[index]
                                ? Colors.blue
                                : Colors.black),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconList[index],
                          TextWidget(
                            text: names[index],
                            fontSize: 16,
                            color: ref.watch(whoIsTravellingWithYouProvider) ==
                                    names[index]
                                ? Colors.blue
                                : Colors.black,
                            isBold: ref.watch(whoIsTravellingWithYouProvider) ==
                                    names[index]
                                ? true
                                : false,
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
        ButtonWidget(
          onPress: () async {

            ref.read(tripDataProvider.notifier).update(
            partner: ref.watch(whoIsTravellingWithYouProvider)
            );
            ref.read(whoIsTravellingWithYouProvider.notifier).state='';
            ref
                .read(pageIndexProvider.notifier)
                .setIndex(ref.watch(pageIndexProvider) + 1);
            ref.watch(pageNavigator);
          },
          title: "Next",
        ),
      ],
    );
  }
}

///
final yourInterestProvider = StateProvider<List<String>>((ref) => []);

class Interested extends ConsumerWidget {
  Interested({super.key});
  final TextEditingController controller = TextEditingController();
  final List<String> interestList = [
    "Camping",
    "Nature",
    "Shopping",
    "Culture",
    "Great Food",
    "Beach",
    "History",
    "Water Sports",
    "Outdoors",
    "Hidden Gems",
    "Urban View",
    "Attraction",
    "Adventure"
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 136,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            const SizedBox(
              height: 10,
            ),
            const TextWidget(
              text: "What is your interest?",
              isBold: true,
              fontSize: 20,
            ),
            const TextWidget(
              text:
                  "Lorem ipsum dolor sit amet consectetur. Eu interdum sed pretium nulla",
              fontSize: 10,
            ),
            Wrap(
              spacing: 5.0, // Space between buttons horizontally
              children: interestList.map((buttonText) {
                return OutlinedButton(
                  onPressed: () {
                    if (!ref
                        .read(yourInterestProvider.notifier)
                        .state
                        .contains(buttonText)) {
                      ref.read(yourInterestProvider.notifier).state = [
                        ...ref.read(yourInterestProvider.notifier).state,
                        buttonText
                      ];
                    } else {
                      ref
                          .read(yourInterestProvider.notifier)
                          .state
                          .remove(buttonText);
                      List<String> lst = [
                        ...ref.read(yourInterestProvider.notifier).state
                      ];
                      ref.read(yourInterestProvider.notifier).state = lst;
                    }
                  },
                  child: Consumer(builder: (context, ref, child) {
                    List<String> value = ref.watch(yourInterestProvider);
                    return Text(buttonText,
                        style: TextStyle(
                            color: value.contains(buttonText)
                                ? Colors.blue
                                : Colors.black));
                  }),
                );
              }).toList(),
            ),
            const TextWidget(
              text: "Other (optional)",
              isBold: true,
              fontSize: 20,
            ),
            TextFieldWidget(
              hintText: "Nightlife, Shopping, Camping",
              controller: controller,
              onChanged: (value){
                controller.text=value;
              },
              isBorder: true,
              radius: 30,
              fillColor: Colors.white,
            ),
          ],
        ),
        ButtonWidget(
          onPress: () async {
            ref.read(tripDataProvider.notifier).update(
                interestList: ref.watch(yourInterestProvider),
            interestListOptional: controller.text
            );
            ref.read(yourInterestProvider.notifier).state=[];
            controller.text='';
            ref
                .read(pageIndexProvider.notifier)
                .setIndex(ref.watch(pageIndexProvider) + 1);
            ref.watch(pageNavigator);
          },
          title: "Next",
        ),
      ],
    );
  }
}

///
final budgetTypeProvider = StateProvider<String>((ref) => "");

class Budget extends ConsumerWidget {
  Budget({super.key});
  final TextEditingController controller = TextEditingController();
  final List<String> budgetList = ["Cheap", "Balanced", "Luxurious"];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 270,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            const SizedBox(
              height: 10,
            ),
            const TextWidget(
              text: "Set your budget",
              isBold: true,
              fontSize: 20,
            ),
            const TextWidget(
                text:
                    "Lorem ipsum dolor sit amet consectetur. Eu interdum sed pretium nulla"),
            Wrap(
              spacing: 10.0,
              children: budgetList.map((toElement) {
                return Consumer(
                  builder: (context, ref, child) => OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          width: ref.watch(budgetTypeProvider) == toElement
                              ? 2
                              : 1,
                          color: ref.watch(budgetTypeProvider) == toElement
                              ? Colors.blue
                              : Colors.black),
                    ),
                    onPressed: () {
                      ref.read(budgetTypeProvider.notifier).state = toElement;
                    },
                    child: TextWidget(
                      text: toElement,
                      color: ref.watch(budgetTypeProvider) == toElement
                          ? Colors.blue
                          : Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
            const TextWidget(
              text: "Specific budget (optional)",
              isBold: true,
              fontSize: 20,
            ),
            TextFieldWidget(
              hintText: "Set your budget manually",
              controller: controller,
              fillColor: Colors.white,
              isBorder: true,
              radius: 30,
            ),
          ],
        ),
        ButtonWidget(
          onPress: () async {
            ref.read(tripDataProvider.notifier).update(budgetType: ref.watch(budgetTypeProvider),
                specificBudgetTypeOptional:controller.text
            );

            RangeClass rangeClass=RangeClass(checkIn: ref.watch(tripDataProvider).checkIn, checkOut: ref.watch(tripDataProvider).checkOut);

            TripModelClass data=TripModelClass(
                destination: ref.watch(tripDataProvider).destination,
                partner: ref.watch(tripDataProvider).partner,
                interestList: ref.watch(tripDataProvider).interestList,
                interestOptional: ref.watch(tripDataProvider).interestListOptional,
                budgetType: ref.watch(tripDataProvider).budgetType,
                specificBudget: ref.watch(tripDataProvider).specificBudgetTypeOptional,
                range:rangeClass);
            ref.watch(firebaseProvider).createSubCollection("users", "trips", ref.watch(userIdProvider), data.toJson()).then((u){
              ref.read(pageIndexProvider.notifier).setIndex(0);
              ref.read(rangeStartAndRangeEndProvider.notifier).clearRange();
              ref.read(tripDataProvider.notifier).clearData();
            })
                .whenComplete(()=>snackBarWidget(context, "Created successfully")).then((v)=>Navigator.push(context, MaterialPageRoute(builder: (builder)=>MyTripPlan())));
            
            },
          title: "Create your trip",
        ),
      ],
    );
  }
}
