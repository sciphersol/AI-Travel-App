import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/Home_screen/home_screen.dart';
import 'package:travel_app/constant_widgets/app_color.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';
import 'package:travel_app/onboarding_screens/onboarding_pages.dart';
import 'package:travel_app/view_model/local_auth_controller.dart';
import 'package:travel_app/view_model/local_auth_states.dart';
import '../firebase/auth_checker.dart';
import '../riverpord/riverpord.dart';

final onboardingStatusProvider=StateProvider<bool>((ref)=>false);
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Future getValue(WidgetRef ref)async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    bool value= pref.getBool("isAuthenticated")??false;
    bool onboardingStatus=pref.getBool("onboardingStatus")??false;
    ref.read(isAuthenticatedProvider.notifier).state=value;
    ref.read(onboardingStatusProvider.notifier).state=onboardingStatus;

  }
  @override
  void initState() {
    super.initState();
    getValue(ref).whenComplete((){
      if(ref.watch(onboardingStatusProvider)==true){
        return Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AuthChecker()),
          );
        });
      }
      return Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  OnboardingPages()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MyAppColor.backgroundColor,
      body: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
            ),
            child: const RiveAnimation.asset(
              "assets/images/rive.riv",
              fit: BoxFit.cover,
            ),
          ),

          const CircularProgressIndicator(
            color: MyAppColor.buttonColor,
          ),
          const TextWidget(
            text: "Explore the world with us",
            isBold: true,
            fontSize: 15,
          ),
        ],
      ),
    );

  }
}



class UnauthorizedScreen extends ConsumerWidget {
  const UnauthorizedScreen({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    ref.listen<LocalAuthStates>(localAuthControllerProvider, ((previous,state){
      if(state is Authorized){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            padding:  EdgeInsets.all(10.0),
            elevation: 5,
            animation: AlwaysStoppedAnimation(9),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            content: TextWidget(text: "You're authorized",color: Colors.white,)
        ));
       Navigator.push(context, MaterialPageRoute(builder: (builder)=>HomeScreen()));
      }else if(state is Unauthorized){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            padding:  EdgeInsets.all(10.0),
            elevation: 5,
            animation:  AlwaysStoppedAnimation(9),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            //margin: EdgeInsets.all(10.0),
            content: TextWidget(text: "You're unauthorized",color: Colors.white,)
        ));
      }
    }));
    return Scaffold(
      backgroundColor: MyAppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock,size: 200,color: MyAppColor.buttonColor,),
              const TextWidget(text: "You're unauthorized",isBold: true,fontSize: 15,),
              ButtonWidget(onPress: (){
              ref.read(localAuthControllerProvider.notifier).authenticateWithBiometrics(context);
              },title: "Verify your identity",)
            ],
          ),
        ),
      ),
    );
  }
}
