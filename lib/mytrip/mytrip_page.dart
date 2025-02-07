import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Home_screen/hotel_details.dart';
import 'package:travel_app/constant_widgets/app_color.dart';
import 'package:travel_app/constant_widgets/custom_icons.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';
import 'package:travel_app/mytrip/create_trip_plan.dart';

final showOnboardingMyTrip=StateProvider<bool>((ref)=>true);

class MyTripPage extends ConsumerWidget {
  const MyTripPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double height=MediaQuery.sizeOf(context).height;
    final double width=MediaQuery.sizeOf(context).width;
    return Scaffold(
     body: SingleChildScrollView(
       child: Padding(padding: const EdgeInsets.all(10.0),
       child: ref.watch(showOnboardingMyTrip)? OnBoardingTrip(height: height):Column(
         spacing: 10,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           const SizedBox(height: 20,),
           const TextWidget(text: "My Trip",isBold: true,fontSize: 32,),
           const TextWidget(text: "Come and try our new feature to help your trip plan using AI and makes your holiday more fun and well prepare",fontSize: 10,),
           lineWidget(),
           const Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               TextWidget(text: "My Itineraries",fontSize: 20,),
               Icon(Icons.navigate_next)
             ],
           ),
           const ImageContainer(
               height: 170,
               radius: 10,
               isRadius: true, imageUrl: "assets/images/Rectangle30.png"),
           const Row(
             spacing: 10,
             children: [
               Icon(Icons.calendar_month),
               TextWidget(text: "Jan 26 - Jan 30")
             ],
           ),
           const Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               TextWidget(text: "My Order",fontSize: 20,),
               Icon(Icons.navigate_next)
             ],
           ),
           ListView.builder(
             itemCount: 3,
               shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               itemBuilder: (context,index){
             return Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                 spacing: 20,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   const ImageContainer(
                       height: 150,
                       width: 160,
                       radius: 10,isRadius: true,
                       imageUrl: "assets/images/Rectangle29.png"),
                   Column(
                     spacing: 10,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                         padding:const EdgeInsets.all(10.0),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: const Color(0xfffdf2e6),
                         ),
                         child: const TextWidget(text: "Waiting for payment",color: Colors.orange,),
                       ),
                       const Row(
                         children: [
                           Icon(Icons.calendar_month),
                           TextWidget(text: "Jan 26 - Jan 30",fontSize: 10,),
                         ],
                       ),
                       const TextWidget(text: "Ling-Ling's Bali",isBold: true,fontSize: 16,),
                       Row(
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
                             text: "500",
                             isBold: true,
                             fontSize: 10,
                           ),
                         ],
                       ),
                     ],
                   )
                 ],
               ),
             );
           }),
           SizedBox(height: height*0.07,),
           ButtonWidget(onPress: (){

           },
             title: "Create a Trip Manually",
             titleColor: Colors.black,
             color: Colors.black12,
           ),
           //Create a Trip with AI
           ButtonWidget(onPress: (){
             Navigator.push(context, MaterialPageRoute(builder: (builder){
               return CreateTripPlan();
             }));
           },
             widget: const Row(
               spacing: 5.0,
               children: [
                 TextWidget(text: "Create a Trip with AI",fontSize: 14,isBold: true,color: Colors.white,),
                 Icon(CustomIcons.ai,color: Colors.white,)
               ],
             ),
           ),
         ],
       ),
       ),
     ),
    );
  }
}

class OnBoardingTrip extends ConsumerWidget {
  const OnBoardingTrip({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Column(
      spacing: 15,
        children: [
          SizedBox(height: height*0.07,),
          const TextWidget(text: "Let’s make your trip more prepare",isBold: true,fontSize: 36,),
          const TextWidget(text: "Come and try our new feature to help your trip plan using AI and makes your holiday more fun and well prepare",fontSize: 10,),
          SizedBox(height: height*0.03,),
          const Row(spacing: 10,
            children: [
            Icon(Icons.add_circle_outline,color: MyAppColor.buttonColor,),
            TextWidget(text: "Personalized Recommendations",fontSize: 16,)
          ],),
          const Row(spacing: 10,
            children: [
            Icon(CustomIcons.time,color: MyAppColor.buttonColor,),
            TextWidget(text: "Time Efficiency",fontSize: 16,)
          ],),
          const Row(
            spacing: 10,
            children: [
            Icon(Icons.add_circle_outline,color: MyAppColor.buttonColor,),
            TextWidget(text: "Dynamic Itinerary Adjustments",fontSize: 16,)
          ],),
          const Row(
            spacing: 10,
            children: [
            Icon(Icons.add_circle_outline,color: MyAppColor.buttonColor,),
            TextWidget(text: "Cost Optimization",fontSize: 16,)
          ],),
          SizedBox(height: height*0.07,),
          ButtonWidget(onPress: (){
            ref.read(showOnboardingMyTrip.notifier).state=!ref.watch(showOnboardingMyTrip);
          },
            title: "Create a Trip Manually",
            titleColor: Colors.black,
            color: Colors.black12,
          ),
          //Create a Trip with AI
          ButtonWidget(onPress: (){
            ref.read(showOnboardingMyTrip.notifier).state=!ref.watch(showOnboardingMyTrip);

          },
            widget: const Row(
              spacing: 5.0,
              children: [
                TextWidget(text: "Create a Trip with AI",fontSize: 14,isBold: true,color: Colors.white,),
                Icon(CustomIcons.ai,color: Colors.white,)
              ],
            ),
          ),
        ],
    );
  }
}
