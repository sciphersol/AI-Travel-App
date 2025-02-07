import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';


import '../constant_widgets/app_color.dart';
import '../constant_widgets/list_items.dart';

class BecomeAPro extends ConsumerWidget {
  BecomeAPro({super.key});
  final PageController pageController=PageController();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    double height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(text: "Become a Pro"),
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
         // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.45,
              //color: MyAppColor.textFieldColor,
              child: PageView.builder(
                  itemCount: InformationArticles.informationArticlesList.length,
                  controller: pageController,
                  itemBuilder: (BuildContext context, int index) {
                    return  const ImageContainer(
                      isRadius: true,
                      width: 343,
                      height: 341,
                      imageUrl: "assets/images/group60.png",
                    );
                  }),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: InformationArticles
                    .informationArticlesList.length,
                effect: const ExpandingDotsEffect(
                  expansionFactor: 1.1,
                  activeDotColor: MyAppColor.buttonColor,
                  dotColor: Colors.grey,
                  dotHeight: 8.0,
                  dotWidth: 8.0,
                  spacing: 8.0,
                ),
              ),
            ),
            const TextWidget(text: "Personalized Itinerary Generator",isBold: true,fontSize: 16,),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextWidget(text: "The app could analyze user preferences, past travel history, and current location to generate personalized itineraries.",isJustify: false,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black12
                  ),
                  child: const Column(
                    spacing: 5.0,
                    children: [
                      TextWidget(text: "\$150/Month",fontSize: 20,isBold: true,),
                      TextWidget(text: "(Cancel anytime & no credit card required)")
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonWidget(onPress: (){
                print("object");

              },
              title: "Continue",),
            ),

          ],
        ),
      ),
    );
  }
}
