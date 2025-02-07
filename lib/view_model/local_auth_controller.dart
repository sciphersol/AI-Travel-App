import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/firebase/auth_checker.dart';
import 'package:travel_app/riverpord/riverpord.dart';


import 'local_auth_states.dart';

class LocalAuthController extends StateNotifier<LocalAuthStates>{
  LocalAuthController(this.ref):super(const Unauthorized());
  final Ref ref;
   authenticateWithBiometrics(BuildContext context,) async {
    final LocalAuthentication auth = LocalAuthentication();
    bool authenticated = false;
    SharedPreferences pref= await SharedPreferences.getInstance();
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
      if(authenticated==true){
        state=const Authorized();
        pref.setBool("isAuthenticated", true);
        ref.read(isAuthenticatedProvider.notifier).state=true;
        bool value=pref.getBool('isAuthenticated')??false;
        ref.watch(isAuthenticatedProvider.notifier).state=value;

      }else if(authenticated==false){
        state=const Unauthorized();
        pref.setBool("isAuthenticated", false);
        ref.read(isAuthenticatedProvider.notifier).state=false;
      }


    } on PlatformException catch (e) {
      pref.setBool("isAuthenticated", false);
      ref.read(isAuthenticatedProvider.notifier).state=false;
      state=const Unauthorized();

    }

  }
 
 
}

final localAuthControllerProvider= StateNotifierProvider<LocalAuthController,LocalAuthStates>((ref)=>LocalAuthController(ref));