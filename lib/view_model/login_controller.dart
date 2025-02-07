import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/riverpord/riverpord.dart';
import 'package:travel_app/view_model/login_state.dart';

class LoginController extends StateNotifier<LoginState>{
  LoginController(this.ref):super(const LoginStateInitial());
  final Ref ref;

  void loginWithEmailAndPassword( String email, String password)async{
    state=const LoginStateLoading();
    try{
      await ref.read(authRepositoryProvider).signInWithEmailAndPassword(email, password);
      state=const LoginStateSuccess();
    }catch(e){
      state=LoginStateError(e.toString());
    }
  }
   void logOut() async{
     state=const LoginStateSuccess();

     try{
       await ref.read(authRepositoryProvider).signOut();
       state=const LoginStateInitial();
     }catch(e){
       state=LoginStateError(e.toString());
     }
   }
   Future continueWithGoogle()async{
    state=const LoginStateLoading();
    try{
      await ref.read(authRepositoryProvider).signInWithGoogle();
      state=const LoginStateSuccess();

    }catch (e){
      state=LoginStateError(e.toString());
    }
   }

/*
   void continueWithFacebook()async{
     state=const LoginStateLoading();
     try{
      ref.read(authRepositoryProvider).signInWithFacebook();
      state=const LoginStateSuccess();
     }catch (e){
      state=LoginStateError(e.toString());
    }

   }
  void continueWithTwitter()async{
    state=const LoginStateLoading();
    try {
      ref.read(authRepositoryProvider).signInWithTwitter();
      state=const LoginStateSuccess();
    }catch (e){
      state=LoginStateError(e.toString());
    }
  }
  void continueWithApple()async{
    state=const LoginStateLoading();
    try {
      ref.read(authRepositoryProvider).signInWithApple();
      state=const LoginStateSuccess();
    }catch (e){
      state=LoginStateError(e.toString());
    }
  }
*/

  void verifyPhoneNumber(BuildContext context, String phoneNumber) async{
    try{
      await ref.read(authRepositoryProvider).sendOtpOnNumber(context, phoneNumber);
    } catch (e){
      state=LoginStateError(e.toString());
    }
   }
}

final loginControllerProvider= StateNotifierProvider<LoginController,LoginState>((ref)=>LoginController(ref));