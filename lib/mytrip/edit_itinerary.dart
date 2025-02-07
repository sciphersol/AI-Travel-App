import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Home_screen/hotel_details.dart';
import '../constant_widgets/widget_ui_components.dart';
import 'create_trip_plan.dart';

final editItineraryProvider =StateProvider<List<bool>>((ref)=>[false,false]);

class EditItinerary extends ConsumerWidget {
   EditItinerary({super.key});
  final DateTime today=DateTime.now();

   void _showModalBottomSheet(BuildContext context, WidgetRef ref) {
     final tripPlanNotifier = ref.read(rangeStartAndRangeEndProvider.notifier);
     showModalBottomSheet(
       context: context,
       builder: (BuildContext context) {
         return Consumer(
           builder: (BuildContext context, WidgetRef ref, Widget? child) {
             return CalendarWidget(
               initialFocusedDay: today,
               rangeStart: ref.watch(rangeStartAndRangeEndProvider).rangeStart,
               rangeEnd: ref.watch(rangeStartAndRangeEndProvider).rangeEnd,
               onRangeSelected: (start, end, focusedDay) {
                 tripPlanNotifier.updateRange(start, end, focusedDay);
               },
             );
           },
         );
       },
     );
   }


  @override
  Widget build(BuildContext context,WidgetRef ref ) {
    final boolList= ref.watch(editItineraryProvider);
    final  startDate= ref.watch(rangeStartAndRangeEndProvider).rangeStart;
    final  endDate= ref.watch(rangeStartAndRangeEndProvider).rangeEnd;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Itinerary"),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                     /* // Toggle the specific index dynamically
                      ref.read(editItineraryProvider.notifier).state = [
                        ...boolList.sublist(0, index),
                        !boolList[index],
                        ...boolList.sublist(index + 1),
                      ];*/
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextWidget(
                          text: "January 26, Day ${0 + 1}",
                          //isBold: true,
                          fontSize: 16,
                        ),
                        Icon(
                          boolList[0]
                              ? Icons.keyboard_arrow_down_rounded
                              : Icons.keyboard_arrow_up_rounded,
                        ),
                      ],
                    ),
                  ),
                  Consumer(
                    builder:(context,ref,child)=> ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: ref.watch(listProvider).length,
                      itemBuilder: (context, subIndex) {
                        return Visibility(
                          visible: boolList[0],
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  spacing: 15,
                                  mainAxisSize: MainAxisSize.min,
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: (){
                                          ref.read(listProvider).removeAt(subIndex);
                                          print(ref.watch(listProvider).length);
                                        },
                                        child: const Icon(Icons.remove_circle_outline,color: Colors.red,)),
                                    ImageContainer(isRadius: true,
                                        height: 68,
                                        width: 83,radius: 10,
                                        imageUrl: ref.watch(listProvider)[subIndex].imageUrl),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(text: ref.watch(listProvider)[subIndex].title,isBold: true,fontSize: 16,),
                                        TextWidget(text: ref.watch(listProvider)[subIndex].subtitle,isBold: true,fontSize: 10,)
                                      ],
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.more_vert_rounded),
                                  ],
                                ),
                              ),
                              lineWidget()

                            ],
                          ),
                        );
                      },
                    ),
                  ),

                ],
              ),
              lineWidget(),
              const TextWidget(text: "Edit trip length",fontSize: 20,),
              OutlinedButton(onPressed: (){
                _showModalBottomSheet(context, ref);
              },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  child: Row(
                    spacing: 10,
                    children: [
                      const Icon(Icons.calendar_month,color: Colors.black,),
                      TextWidget(
                        text: startDate != null?'${startDate.day}/${startDate.month}/${startDate.year}':"Start Date"),
                      const Icon(Icons.arrow_forward,color: Colors.black,),
                      TextWidget(
                        text: endDate != null?'${endDate.day}/${endDate.month}/${endDate.year}':"End Date",
                      )
                    ],
                  ),
                )

                ,),
              ButtonWidget(onPress: (){},title: "Save Changes",)
            ],
          ),
        ),
      ),
    );
  }
}

class Itinerary{
  String imageUrl;
  String title;
  String subtitle;
  Itinerary({required this.imageUrl,
  required this.title,
  required this.subtitle});
}

List<Itinerary> itineraryList=[
  Itinerary(imageUrl: 'assets/images/Rectangle29.png', title: 'Uluwatu Temple', subtitle: "Bali"),
  Itinerary(imageUrl: 'assets/images/Rectangle29.png', title: 'Tanah Lot', subtitle: "Bali"),
  Itinerary(imageUrl: 'assets/images/Rectangle29.png', title: 'Pura Tirta Empul', subtitle: "Bali"),
  Itinerary(imageUrl: 'assets/images/Rectangle29.png', title: 'Sun Royal Hotel Bali', subtitle: "Bali"),
];
final listProvider=StateProvider<List<Itinerary>>((ref)=>itineraryList);