import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/constant_widgets/app_color.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';
import 'package:travel_app/view_model/login_controller.dart';
import 'package:travel_app/view_model/login_state.dart';

import '../riverpord/riverpord.dart';

class LoginOrSignupScreen extends ConsumerWidget {
    LoginOrSignupScreen({super.key});

  final TextEditingController _phoneNumberController=TextEditingController();

    @override
  Widget build(BuildContext context,WidgetRef ref) {
      ref.listen<LoginState>(loginControllerProvider, ((previous,state){
        if(state is LoginStateError){
          ref.read(isLoadingProvider.notifier).state=!ref.watch(isLoadingProvider);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
             padding: const EdgeInsets.all(10.0),
             elevation: 5,
             animation: const AlwaysStoppedAnimation(9),
             clipBehavior: Clip.antiAliasWithSaveLayer,
             //margin: EdgeInsets.all(10.0),
             content: TextWidget(text: state.error,color: Colors.white,)
         ));
        }else if(state is LoginStateSuccess){
          ref.read(isLoadingProvider.notifier).state=!ref.watch(isLoadingProvider);
        }
      }));
      double mediaWidth=MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: MyAppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyAppColor.backgroundColor,
        actions: [
          ButtonWidget(onPress: (){},
            title: "X",color: Colors.white,
            titleColor:Colors.black,
            width: mediaWidth*0.03,
            fontSize: 18.0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextWidget(text: "Login or Sign up",isBold: true,fontSize: 30.0,),
              const TextWidget(text: "Lorem ipsum dolor sit amet consectetur. Eu interdum sed pretium nulla neque purus velit quis massa.",),
              const TextWidget(text: "Phone Number",fontSize: 20.0,),
              PhoneTextField(controller: _phoneNumberController, onChanged: (value){}),
              ButtonWidget(onPress: (){
                if(_phoneNumberController.text.length>5){
                  ref.read(loginControllerProvider.notifier).verifyPhoneNumber(context, "+92${_phoneNumberController.text}");
                }else{
                  print("Enter the number");
                }
              },title: "Continue",),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 2.0,
                    width: MediaQuery.sizeOf(context).width*0.4,
                    color: Colors.grey,
                  ),
                  const TextWidget(text: "or"),
                  Container(
                    height: 2.0,
                    width: MediaQuery.sizeOf(context).width*0.4,
                    color: Colors.grey,
                  ),
                ],
              ),

              ButtonWidget(
                widget: SizedBox(height: 25,width: 25,
                  child: Image.asset("assets/images/google.png"),
                ),
                onPress: (){
                  ref.read(isLoadingProvider.notifier).state=true;

                  ref.read(loginControllerProvider.notifier).continueWithGoogle();
                },
                title: "Continue with Google",
                titleColor: Colors.black,
                color: MyAppColor.textFieldColor,
                isLoading: ref.watch(isLoadingProvider),
              ),
              ButtonWidget(
                icon: const Icon(Icons.apple,color: Colors.black,size: 35,),
                onPress: (){},
                title: "Continue with Apple",
                titleColor: Colors.black,
                color: MyAppColor.textFieldColor,
              ),
              ButtonWidget(
                icon: const Icon(Icons.facebook,color: Colors.blue,size: 30,),
                onPress: (){},
                title: "Continue with Facebook",
                titleColor: Colors.black,
                color: MyAppColor.textFieldColor,
              ),
              ButtonWidget(
                widget: SizedBox(height: 35,width: 35,
                child: Image.asset("assets/images/x.jpg"),
                ),
                onPress: (){},
                title: "Continue with Twitter",
                titleColor: Colors.black,
                color: MyAppColor.textFieldColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}




///OTP Screen of Login Screen
class OtpScreen extends ConsumerWidget {
  OtpScreen(BuildContext context, String verificationId, String phoneNumber, {super.key});

  final List<TextEditingController> controllerList = [
    TextEditingController(), // Controller for the first TextField
    TextEditingController(), // Controller for the second TextField
    TextEditingController(), // Controller for the third TextField
    TextEditingController(), // Controller for the fourth TextField
    TextEditingController(), // Controller for the fifth TextField
    TextEditingController(), // Controller for the sixth TextField
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: MyAppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyAppColor.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextWidget(
                text: "Login or Sign up", isBold: true, fontSize: 30.0,),
              const TextWidget(
                text: "Lorem ipsum dolor sit amet consectetur. Eu interdum sed pretium nulla neque purus velit quis massa.",),
              const TextWidget(
                text: "A verification code has been sent to +6299876451",
                isBold: true,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for(int i=0;i<6;i++)
                    OtpBoxFieldWidget(controller: controllerList[i],)

                ],
              ),
              const TextWidget(text: "Resend in: 35", color: Colors.grey,),
              ButtonWidget(onPress: () {}, title: "Continue",),
            ],
          ),
        ),
      ),
    );
  }

}

///
class OtpBoxFieldWidget extends StatelessWidget {
   const OtpBoxFieldWidget({super.key,
  required this.controller,
  });

  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 42.8,
      decoration: BoxDecoration(
        color: MyAppColor.textFieldColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextField(
        onChanged: (value){

        },
        controller: controller,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          hintText: "*",
          hintStyle: TextStyle(fontSize: 20.0),
        ),
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
