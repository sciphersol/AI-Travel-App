import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Home_screen/hotel_details.dart';
import 'package:travel_app/acoount/become_pro.dart';
import 'package:travel_app/acoount/booking.dart';
import 'package:travel_app/acoount/personal_information.dart';
import 'package:travel_app/acoount/privacy_policy.dart';
import 'package:travel_app/acoount/terms_conditions.dart';
import 'package:travel_app/constant_widgets/app_color.dart';
import 'package:travel_app/constant_widgets/custom_icons.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';
import 'package:travel_app/firebase/firebase_auth.dart';

import '../riverpord/riverpord.dart';
import '../view_model/login_controller.dart';
import 'license.dart';
import 'login_security.dart';
import 'notification.dart';
import 'notifications.dart';

class AccountPage extends ConsumerWidget {
   AccountPage({super.key});
final List<String> listItems=[
  "Booking","Personal Information","Login & Security","Notification","Terms & Conditions","Privacy Policy","License"
];
final List<Icon>iconList=[
  const Icon(CustomIcons.flag,color: MyAppColor.buttonColor,),
  const Icon(Icons.person,color: MyAppColor.buttonColor,),
  const Icon(CustomIcons.secure,color: MyAppColor.buttonColor,),
  const Icon(Icons.notifications,color: MyAppColor.buttonColor,),
  const Icon(Icons.info_rounded,color: MyAppColor.buttonColor,),
  const Icon(CustomIcons.policy,color: MyAppColor.buttonColor),
  const Icon(CustomIcons.license,color: MyAppColor.buttonColor),

];
final List<Widget> widgets=[
  const Booking(),
  PersonalInformation(),
  LoginSecurity(),
  NotificationPage(),
  const TermsConditions(),
  const PrivacyPolicy(),
  PageWidget(),
];
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final authState=ref.watch(authStateProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextWidget(text: "Account",isBold: true,fontSize: 32,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>const Notifications()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: MyAppColor.textFieldColor
                        ),
                        child: const Icon(Icons.notifications,color: MyAppColor.buttonColor),
                      ),
                    )
                  ],
                ),
              ),
              authState.when(
                  data: (user)=> ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(user!.photoURL.toString()),
                    ),
                    title: TextWidget(text: user.displayName.toString(),fontSize: 16,),
                    subtitle: TextWidget(text: user.email.toString(),fontSize: 10,),
                  ),
                  error:(e,widget)=> const CircularProgressIndicator(),
                  loading: ()=>const CircularProgressIndicator()),
              lineWidget(),
              const TextWidget(text: "Setting",isBold: true,fontSize: 20,),
              ListView.builder(
                itemExtent: 50,
                physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 7,
                  itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>widgets[index]));
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: iconList[index],
                    title: TextWidget(text: listItems[index],isBold: true,fontSize: 16,),
                    trailing: const Icon(Icons.navigate_next),
                  ),
                );
              }),
              lineWidget(),
              ButtonWidget(onPress: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>BecomeAPro()));
              },title: "Become a PRO",fontSize: 14,),
              Center(child: OutlinedButton(onPressed: (){

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialogWidget(
                      message: 'Are you sure want to Logout?',
                      onCancelName: "Cancel",
                      onCancel: () {
                        // Handle cancel action
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      onDeleteName: "Logout",
                      onDelete: (){
                        ref.read(loginControllerProvider.notifier).logOut();
                        Navigator.pop(context);
                        print("You're log out!");

                      },
                    );
                  },
                );

              }, child: const TextWidget(text: "LogOut")))
            ],
          ),
        ),
      ),
    );
  }
}
