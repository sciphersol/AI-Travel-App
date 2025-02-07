import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/constant_widgets/app_color.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';

import 'create_trip_plan.dart';

class TripSetting extends ConsumerWidget {
   TripSetting({super.key});
 final TextEditingController controller=TextEditingController();
   final DateTime today=DateTime.now();

   void _showModalBottomSheet(BuildContext context, WidgetRef ref) {
     final dateTimeNotifier = ref.read(rangeStartAndRangeEndProvider.notifier);

     showModalBottomSheet(
       context: context,
       builder: (BuildContext context) {
         return Consumer(
           builder: (BuildContext context, WidgetRef ref, Widget? child) {
             return CalendarWidget(
               initialFocusedDay: today,
               rangeStart: ref.watch(rangeStartAndRangeEndProvider).rangeStart,
               rangeEnd: ref.watch(rangeStartAndRangeEndProvider).rangeEnd,
               onDaySelected: (start,end){
                 dateTimeNotifier.updateSingleDate(start!);
               },
             );
           },
         );
       },
     );
   }


   @override
  Widget build(BuildContext context,WidgetRef ref) {
     final  startDate= ref.watch(rangeStartAndRangeEndProvider).rangeStart;

     return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Trip setting"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            spacing: 25,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,//why this not working
            children: [
              const TextWidget(text: "Trip name",isBold: true,fontSize: 20,),
              TextFieldWidget(hintText: "Your trip name",controller: controller,fillColor: MyAppColor.textFieldColor,),
              const TextWidget(text: "Change departure",isBold: true,fontSize: 20,),
              GestureDetector(
                onTap: (){
                  _showModalBottomSheet(context,ref);
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyAppColor.textFieldColor
                  ),
                  child:
                   Row(
                    spacing: 10,
                    children: [
                      const Icon(Icons.calendar_month),
                      TextWidget(
                          text: startDate != null?'${startDate.day}/${startDate.month}/${startDate.year}':"Select your departure"),
                    ],
                  ),
                ),
              ),
              const TextWidget(text: "Collaborators",isBold: true,fontSize: 20,),
              OutlinedButton(onPressed: (){},
                  child:Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int i = 0; i < 2; i++)
                          const Align(
                            widthFactor: 0.6,
                            child: CircleAvatar(
                              backgroundImage: AssetImage("assets/images/Rectangle29.png"),
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
              ),
              const Row(
                spacing: 10,
                children: [
                  Icon(Icons.share),
                  TextWidget(text: "Share trip",isBold: true,fontSize: 16,)
                ],
              ),
              const Row(
                spacing: 10,
                children: [
                  Icon(Icons.delete,color: Colors.red,),
                  TextWidget(text: "Delete trip",isBold: true,fontSize: 16,color: Colors.red,)
                ],
              ),
              const SizedBox(height: 100,),
              ButtonWidget(onPress: (){},title: "Save changes",)
            ],
          ),
        ),
      ),
    );
  }
}
