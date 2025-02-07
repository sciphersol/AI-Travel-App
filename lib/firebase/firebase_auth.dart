
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_app/Home_screen/home_screen.dart';
import '../login_screen/login_or_signup.dart';

class AuthRepository {
  AuthRepository(this._auth);
  final FirebaseAuth _auth;

  Stream<User?> get authStateChange => _auth.idTokenChanges();

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-email") {
        throw AuthException("Wrong email address");
      } else if (e.code == "wrong-password") {
        throw AuthException("Wrong password!");
      } else {
        throw AuthException("An error occurred. Try again!");
      }
    }
  }

/*  Future<UserCredential> signInWithFacebook() async {
   try{
     final LoginResult loginResult = await FacebookAuth.instance.login();
     final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken.token);
     return _auth.signInWithCredential(facebookAuthCredential);
   } catch(e){
     throw AuthException("An error occurred. Try again!");
   }
  }

  Future<UserCredential> signInWithTwitter() async {
   try{
     final twitterLogin = new TwitterLogin(
         apiKey: '<your consumer key>',
         apiSecretKey:' <your consumer secret>',
         redirectURI: '<your_scheme>://'
     );
     final authResult = await twitterLogin.login();
     final twitterAuthCredential = TwitterAuthProvider.credential(
       accessToken: authResult.authToken!,
       secret: authResult.authTokenSecret!,
     );
     return await _auth.signInWithCredential(twitterAuthCredential);
   } catch (e){
     throw AuthException("An error occurred. Try again!");
   }
  }


  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  Future<UserCredential> signInWithApple() async {

   try{
     final rawNonce = generateNonce();
     final nonce = sha256ofString(rawNonce);
     final appleCredential = await SignInWithApple.getAppleIDCredential(
       scopes: [
         AppleIDAuthorizationScopes.email,
         AppleIDAuthorizationScopes.fullName,
       ],
       nonce: nonce,
     );
     final oauthCredential = OAuthProvider("apple.com").credential(
       idToken: appleCredential.identityToken,
       rawNonce: rawNonce,
     );
     return await _auth.signInWithCredential(oauthCredential);
   } catch (e){
     throw AuthException("An error occurred. Try again!");
   }
  }*/
  Future sendOtpOnNumber(BuildContext context, String phoneNumber) async {

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      },
      verificationFailed: (FirebaseAuthException ex) {
        print("Verification failed: ${ex.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        print("Code sent to $phoneNumber");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(context, verificationId, phoneNumber),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle auto-retrieval timeout (e.g., user can enter code manually)
        print("Auto retrieval timeout for verification ID: $verificationId");
      },
    );
  }
  Future verifyingOtpCode(BuildContext context,String verificationId, String code,) async{
    try{
      PhoneAuthCredential credential= await PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: code
      );
      _auth.signInWithCredential(credential).then((value) => Navigator.push(context,
          MaterialPageRoute(builder: (_) =>   HomeScreen())));


    }catch (ex) {
      // If there's an error, handle it accordingly
      print("Error verifying OTP: $ex");
      // For example, you can show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect OTP. Please try again.'),
        ),
      );
      // Or navigate the user to a different screen based on the error
      Navigator.push(context, MaterialPageRoute(builder: (_) =>  LoginOrSignupScreen()));
    }
  }
  Future<UserCredential> signInWithGoogle() async {
   try{
     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
     final credential = GoogleAuthProvider.credential(
       accessToken: googleAuth?.accessToken,
       idToken: googleAuth?.idToken,
     );
     return await _auth.signInWithCredential(credential);
   }catch (e){
     throw AuthException("An error occurred. Try again!");
   }
  }


  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() {
    return message;
  }
}
