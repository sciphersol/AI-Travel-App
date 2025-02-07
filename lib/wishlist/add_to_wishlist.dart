import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:travel_app/firebase/firebase_crud_operations.dart';
import 'package:travel_app/firebase/model/wishlist.dart';
import '../acoount/personal_information.dart';
import '../constant_widgets/widget_ui_components.dart';
import '../firebase/model/profile.dart';
import '../riverpord/riverpord.dart';


Widget addToWishListModelBottomSheet(
    Profile? userData,
    BuildContext context, WidgetRef ref, String hotelId) {
  TextEditingController defaultController=TextEditingController();
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.cyan,
    Colors.indigo,
  ];
  if(userData==null){
    return ListTile(
      onTap: () {
        List<String> list = [hotelId];
        WishListModelClass data = WishListModelClass(
            listOfHotelIds: list, tripName: "Create New Trip");
        ref.watch(firebaseProvider).updateArrayElements(
            "users", ref.watch(userIdProvider), 'wishlist', data.toJSON());
        Navigator.pop(context);
      },
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: colors[1]),
        child: const Icon(
          Icons.directions_walk,
          size: 30,
          color: Colors.white,
        ),
      ),
      title: buildTextField(defaultController,false ,"Write a caption"),
      subtitle: const TextWidget(text: "Let's go"),
      trailing: const Icon(
        Icons.add,
      ),
    );
} else {
    List<WishListModelClass> wishlists = userData.wishlist!;
  final controllers= ref.watch(controllersListProvider(userData.wishlist!.length));
 for(int i=0;i<controllers.length;i++){
   controllers[i].text=wishlists[i].tripName;
 }

    List<String> allHotelIds = [];
    bool exists = false;
    int foundAtIndex=0;
    for (var wishlist in wishlists) {
      allHotelIds.addAll(wishlist.listOfHotelIds);
    }
    for(int i=0;i<wishlists.length;i++){
      for(int k=0;k<wishlists[i].listOfHotelIds.length;k++){
        bool value=wishlists[i].listOfHotelIds.contains(hotelId);
        if(value==true){
          foundAtIndex=i;
        }
      }
    }
    exists = allHotelIds.contains(hotelId);
    return Padding(
      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ... List.generate(
            wishlists.length,
                (index) {
              return  ListTile(
                onTap: () async {
                  if (exists) {
                    wishlists[index].tripName=controllers[index].text;
                    showTopSnackBar(
                      displayDuration: const Duration(seconds: 1),
                      Overlay.of(context),
                     padding: const EdgeInsets.all(10),
                       CustomSnackBar.info(
                         icon: const Icon(Icons.info,size: 30,color: Colors.white,),
                         messagePadding: const EdgeInsets. symmetric(horizontal: 50),
                      iconPositionLeft: 8,
                      textAlign: TextAlign.left,
                        message:
                        'The hotel is already exists in ${wishlists[foundAtIndex].tripName}',
                      ),

                    );
                  } else {
                   wishlists[index].listOfHotelIds.add(hotelId);

                    wishlists[index].tripName=controllers[index].text;
                   WishListModelClass wish=wishlists[index];
                /*   ref.watch(firebaseProvider).updateArrayElements("users", ref.watch(userIdProvider), "wishlist", wish);
                  */
                    List<Map<String, dynamic>> wishlistJson =
                    wishlists.map((w) => w.toJSON()).toList();
                    await ref.watch(firebaseProvider).updateDocument(
                      'users',
                      ref.watch(userIdProvider),
                      {"wishlist": wishlistJson},
                    );
                    showTopSnackBar(
                      displayDuration: const Duration(seconds: 1),
                      Overlay.of(context),
                      padding: const EdgeInsets.all(10),
                      CustomSnackBar.info(
                        backgroundColor: Colors.green,
                        icon: const Icon(Icons.check_circle,size: 30,color: Colors.white,),
                        messagePadding: const EdgeInsets. symmetric(horizontal: 50),
                        iconPositionLeft: 8,
                        textAlign: TextAlign.left,
                        message:
                        'The hotel is added to ${wishlists[index].tripName}',
                      ),

                    );

                    Navigator.pop(context);
                  }
                },
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: colors[
                    index % colors.length], // Prevent index out of range
                  ),
                  child: const Icon(Icons.directions_walk,
                      size: 30, color: Colors.white),
                ),
                title:buildTextField(controllers[index],false,null),
                subtitle: TextWidget(
                    text: "${wishlists[index].listOfHotelIds.length} Saved"),

                trailing: exists? const Icon(Icons.check):const Icon(Icons.add),
              );
                },
          ),
          ListTile(
            onTap: () {
              if(exists){
                showTopSnackBar(
                  displayDuration: const Duration(seconds: 1),
                  Overlay.of(context),
                  padding: const EdgeInsets.all(10),
                  CustomSnackBar.info(
                    icon: const Icon(Icons.info,size: 30,color: Colors.white,),
                    messagePadding: const EdgeInsets. symmetric(horizontal: 50),
                    iconPositionLeft: 8,
                    textAlign: TextAlign.left,
                    message:
                    'The hotel is already exists in ${wishlists[foundAtIndex].tripName}',
                  ),

                );
                Navigator.pop(context);
              }else{
                List<String> list = [hotelId];

                WishListModelClass data = WishListModelClass(
                    listOfHotelIds: list,
                    tripName: defaultController.text);
                ref.watch(firebaseProvider).updateArrayElements(
                    "users", ref.watch(userIdProvider), 'wishlist', data.toJSON());
                snackBarWidget(context,'Added successfully');

                Navigator.pop(context);
              }
            },
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: colors[1]),
              child: const Icon(
                Icons.directions_walk,
                size: 30,
                color: Colors.white,
              ),
            ),
           title:buildTextField(defaultController,false ,"Write a caption"),
            subtitle: const TextWidget(text: "Let's go"),
            trailing: const Icon(
              Icons.add,
            ),
          ),],
      ),
    );
  }
}

void snackBarWidget(BuildContext context, String message) {
  return showTopSnackBar(
              displayDuration: const Duration(seconds: 1),
              Overlay.of(context),
              padding: const EdgeInsets.all(10),
               CustomSnackBar.info(
                backgroundColor: Colors.green,
                icon: const Icon(Icons.check_circle,size: 30,color: Colors.white,),
                messagePadding: const EdgeInsets. symmetric(horizontal: 50),
                iconPositionLeft: 8,
                textAlign: TextAlign.left,
                message:
                message,
              ),

            );
}

