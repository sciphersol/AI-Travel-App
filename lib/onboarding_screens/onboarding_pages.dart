import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app/constant_widgets/app_color.dart';
import 'package:travel_app/firebase/auth_checker.dart';
import 'package:travel_app/firebase/notification_firebase.dart';
import '../constant_widgets/list_items.dart';
import '../constant_widgets/widget_ui_components.dart';
import '../login_screen/login_or_signup.dart';

final onBoardingSkipButton=StateProvider<int>((ref)=>0);
class OnboardingPages extends ConsumerWidget {
   OnboardingPages({super.key});

  final pageController = PageController();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return SafeArea(

      child: Scaffold(
        backgroundColor: MyAppColor.backgroundColor,
       /* appBar: AppBar(
          backgroundColor: MyAppColor.backgroundColor,
          actions: [
            if(ref.watch(onBoardingSkipButton)!=4)
            ButtonWidget(
              color: Colors.white,
              width: 50.0,
              title: "Skip",
                titleColor: Colors.black,
                onPress: () {
                int count=OnBoardingItems.items.length - 1;
                ref.read(onBoardingSkipButton.notifier).state=count;
                pageController.jumpToPage(OnBoardingItems.items.length - 1);
                },
            ),
          ],
        ),*/
        body: Consumer(
          builder:(context,ref,child)=> Column(
           children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                (ref.watch(onBoardingSkipButton)==3)?
               const  SizedBox(height: 10,):  ButtonWidget(
                  color: Colors.white,
                  width: 50.0,
                  title: "Skip",
                  titleColor: Colors.black,
                  onPress: () {
                    int count=OnBoardingItems.items.length - 1;
                    ref.read(onBoardingSkipButton.notifier).state=count;
                    pageController.jumpToPage(OnBoardingItems.items.length - 1);
                  },
                ),
              ],
            ),
             SizedBox(
               height: MediaQuery.sizeOf(context).height*0.8,
               child: PageView.builder(
                 controller: pageController,
                 scrollDirection: Axis.horizontal,
                 onPageChanged: (index){
                   ref.read(onBoardingSkipButton.notifier).state=index;
                   print(ref.watch(onBoardingSkipButton));
                 },
                 itemCount: OnBoardingItems.items.length,
                 itemBuilder: (BuildContext context, int index) {
                   final item = OnBoardingItems.items[index];
                   return OnBoardingContainer(
                     index: index,
                     imageUrl: item.imageUrl,
                     title: item.title,
                     subTitle: item.subtitle,
                   );
                 },
               ),
             ),
             SmoothPageIndicator(
               controller: pageController,
               count: OnBoardingItems.items.length,
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
      ),
    );
  }
}
///onboarding container contains three values imagepath, title and a subtitle
class OnBoardingContainer extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? subTitle;
  final int index;

  const OnBoardingContainer({
    super.key,
    this.imageUrl,
    this.title,
    this.subTitle,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Image.asset(
            imageUrl.toString(),
            fit: BoxFit.fill,
          ),
          TextWidget(
            text: title.toString(),
            isBold: true,
            fontSize: 25,
          ),
          TextWidget(text: subTitle.toString(),fontSize: 12,),

          ///if index==3 we want to show more widgets at the bottom of this widget
          if(index==3)Column(
            children: [
              const PermissionCard(icon: Icons.location_on,title:"Location",subTitle: "Lorem ipsum dolor sit amet consectetur. Eu interdum sed pretium nulla neque purus velit quis massa."),
              const PermissionCard(icon: Icons.notifications,title:"Notifications",subTitle: "Lorem ipsum dolor sit amet consectetur. Eu interdum sed pretium nulla neque purus velit quis massa."),
              const SizedBox(height: 20,),

              ButtonWidget(onPress: ()async{
                SharedPreferences pref=await SharedPreferences.getInstance();
                pref.setBool("onboardingStatus", true);
                NotificationService notificationService=NotificationService();
                notificationService.permission();
              },title: "Yes,sure!",color: MyAppColor.buttonColor,titleColor:Colors.white),
              const SizedBox(height: 20,),
              ButtonWidget(onPress: ()async{
                SharedPreferences pref=await SharedPreferences.getInstance();
                pref.setBool("onboardingStatus", true);

                Navigator.push(context, MaterialPageRoute(builder: (builder)=>const AuthChecker()));
              },title: "Not now",color: Colors.black12,titleColor: Colors.black,),
            ],
          )
        ],
      ),
    );
  }
}
///Permission Card

class PermissionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;

  const PermissionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: MyAppColor.buttonColor,
          ///size: 24.0,
        ),
        Expanded( // Allow text to wrap within the available space
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
            children: [
              TextWidget(
                text: title,
                isBold: true,
                fontSize: 20.0,
              ),
              TextWidget(
                text: subTitle,
                fontSize: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }
}