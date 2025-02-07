import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/firebase/firebase_auth.dart';
import 'package:travel_app/firebase/firebase_crud_operations.dart';
import 'package:travel_app/firebase/model/profile.dart';
import 'package:travel_app/firebase/model/wishlist.dart';

import '../firebase/model/booking.dart';
import '../firebase/model/hotel_class.dart';
import '../firebase/model/trip.dart';
part 'riverpord.g.dart';
@riverpod
class NavigationNotifier extends _$NavigationNotifier{

  @override

  int build(){
    return 0;
  }
  void setSelectedIndex(int index){
    state=index;
  }
}

final isLoadingProvider=StateProvider<bool>((ref)=>false);

final hotelDataProvider = FutureProvider.family<List<Hotel>,String>((ref,path) async {
  final snapshot = await FirebaseFirestore.instance.collection(path).get();
  final hotels = snapshot.docs.map((doc) {
    return Hotel.fromFireStore(doc.data());
  }).toList();
  return hotels;
});

final authRepositoryProvider=Provider<AuthRepository>((ref)=> AuthRepository(FirebaseAuth.instance));
final authStateProvider= StreamProvider<User?>((ref)=>ref.read(authRepositoryProvider).authStateChange);

final userIdProvider=StateProvider<String>((ref)=>FirebaseAuth.instance.currentUser!.uid);

final isAuthenticatedProvider=StateProvider<bool>((ref)=>false);


final hotelModelClassProvider = StreamProvider<List<Hotel>>((ref) {
  return ref.watch(firebaseProvider).getDocuments("hotel").map((querySnapshot) {
    return querySnapshot.docs.map((doc) => Hotel.fromFireStore(doc.data())).toList();
  });
});

final bookingModelClassProvider = StreamProvider<List<Reservation>>((ref) {
  return ref.watch(firebaseProvider).getSubCollectionDocuments("users",ref.watch(userIdProvider),"reservations",).map((querySnapshot) {
    return querySnapshot.docs.map((doc) => Reservation.fromJSON(doc.data())).toList();
  });
});


final tripModelClassProvider = StreamProvider<List<TripModelClass>>((ref) {
  return ref.watch(firebaseProvider).getSubCollectionDocuments("users",ref.watch(userIdProvider),"trips").map((querySnapshot) {
    return querySnapshot.docs.map((doc) => TripModelClass.fromJson(doc.data())).toList();
  });
});
final userProfileModalClassProvider = StreamProvider<Profile?>((ref) {
  final userId = ref.watch(userIdProvider);
  return ref.watch(firebaseProvider).getDocumentById("users", userId)!.map((documentSnapshot) {
    if (documentSnapshot.exists) {
      return Profile.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  });
});


final documentIdsProvider = StreamProvider.family<List<String>, String>((ref, collectionName) {
  return ref.watch(firebaseProvider).getDocuments(collectionName).map((querySnapshot) {
    return querySnapshot.docs.map((document) => document.id).toList();
  });
});
