import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Home_screen/hotel_details.dart';
import 'package:travel_app/constant_widgets/app_color.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';
import 'package:travel_app/firebase/firebase_crud_operations.dart';
import 'package:travel_app/firebase/model/wishlist.dart';
import 'package:travel_app/riverpord/riverpord.dart';
import 'package:travel_app/wishlist/add_to_wishlist.dart';
import '../firebase/model/hotel_class.dart';

final showGridViewProvider = StateProvider<bool>((ref) => true);
final showDeleteButton = StateProvider<bool>((ref) => false);
final showRenameTrip = StateProvider<bool>((ref) => false);
final showListView = StateProvider<bool>((ref) => false);
final holdListData=StateProvider<WishListModelClass>((ref)=>WishListModelClass(listOfHotelIds: [], tripName: "tripName"));

class Wishlist extends ConsumerWidget {
  Wishlist({super.key});
  final TextEditingController _renameTripController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(userProfileModalClassProvider);
    return Scaffold(
      backgroundColor: MyAppColor.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyAppColor.backgroundColor,
        title: const TextWidget(text: "Wishlist", isBold: true, fontSize: 32),
        actions: [
          _buildAppBarAction(ref),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(
                width: 210,
                child: TextWidget(
                  text: "Lorem ipsum dolor sit amet consectetur. Eu interdum sed pretium nulla",
                  fontSize: 10,
                ),
              ),
              asyncData.when(
                data: (profile) {
                  return !ref.watch(showListView)?
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: .7,
                    ),
                    itemCount: profile?.wishlist!.length,
                    itemBuilder: (context, index) {
                      return GridViewCard(
                        onTap: () {
                          if (ref.watch(showDeleteButton) == false) {
                            ref.read(holdListData.notifier).state = profile.wishlist![index];
                            ref.read(showListView.notifier).state = !ref.watch(showListView);
                          }
                        },
                        imageUrl: "assets/images/Rectangle30.png",
                        title: profile?.wishlist![index].tripName,
                        subtitle: "${profile!.wishlist![index].listOfHotelIds.length} Saved",
                        child: ref.watch(showDeleteButton)
                            ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              child: Container(
                                margin: const EdgeInsets.all(10.0),
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              onTap: () {
                                _renameTripController.text = profile.wishlist![index].tripName;
                                showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  isScrollControlled: true,
                                  useSafeArea: true,
                                  context: context,
                                  builder: (context) {
                                    return Consumer(
                                      builder: (context, ref, child) => Padding(
                                        padding: EdgeInsets.fromLTRB(10, 20, 10, MediaQuery.of(context).viewInsets.bottom),
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: [
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      ref.read(showRenameTrip.notifier).state = !ref.watch(showRenameTrip);
                                                    },
                                                    child: const RowComponents(
                                                      firstIcon: Icons.edit,
                                                      color: Colors.black,
                                                      firstText: "Rename your trip",
                                                    )),
                                                if (ref.watch(showRenameTrip))
                                                  IconButton(
                                                    onPressed: () {
                                                      profile.wishlist![index].tripName = _renameTripController.text;
                                                      List<Map<String, dynamic>> wish = profile.wishlist!.map((item) => item.toJSON()).toList();
                                                      ref.watch(firebaseProvider).updateDocument("users", ref.watch(userIdProvider), {"wishlist": wish}).then((onValue) {
                                                        ref.read(showRenameTrip.notifier).state = !ref.watch(showRenameTrip);
                                                        ref.read(showDeleteButton.notifier).state = !ref.watch(showDeleteButton);
                                                        Navigator.pop(context);
                                                        snackBarWidget(context, "Update successfully");
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.check_circle,
                                                      size: 40,
                                                      color: MyAppColor.buttonColor,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            if (ref.watch(showRenameTrip)) const SizedBox(height: 10),
                                            if (ref.watch(showRenameTrip)) TextFieldWidget(controller: _renameTripController, isBorder: true, fillColor: Colors.white),
                                            const SizedBox(height: 10),
                                            GestureDetector(
                                              onTap: () {
                                                String trip = profile.wishlist![index].tripName;
                                                profile.wishlist!.removeAt(index);
                                                List<Map<String, dynamic>> wish = profile.wishlist!.map((item) => item.toJSON()).toList();
                                                ref.watch(firebaseProvider).updateDocument("users", ref.watch(userIdProvider), {"wishlist": wish}).then((onValue) {
                                                  ref.read(showDeleteButton.notifier).state = !ref.watch(showDeleteButton);
                                                  Navigator.pop(context);
                                                  snackBarWidget(context, "$trip is removed from wishlist");
                                                });
                                              },
                                              child: const RowComponents(firstIcon: Icons.delete, color: Colors.black, firstText: "Delete"),
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            )
                          ],
                        )
                            : null,
                      );
                    },
                  )
                  :_buildListView(ref);
                },
                error: (error, trackStack) => const Text("error"),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),

    );
  }
}



  Widget _buildAppBarAction(WidgetRef ref) {
    return ref.watch(showListView)
        ? GestureDetector(
      onTap: () {
        ref.read(showListView.notifier).state=!ref.watch(showListView);
       /* ref.read(showGridViewProvider.notifier).state = !ref.watch(showGridViewProvider);
        ref.read(showListView.notifier).state = !ref.watch(showListView);*/
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: MyAppColor.textFieldColor,
        ),
        child: const Icon(Icons.arrow_back),
      ),
    )
        : GestureDetector(
      onTap: () {
        ref.read(showDeleteButton.notifier).state = !ref.watch(showDeleteButton);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: MyAppColor.textFieldColor,
        ),
        child: Icon(ref.watch(showDeleteButton) ? Icons.check : Icons.edit),
      ),
    );
  }
  Widget _buildListView(WidgetRef ref){
  final asyncHotelData=ref.watch(hotelModelClassProvider);
  WishListModelClass wishListModelClass=ref.watch(holdListData);

  return asyncHotelData.when(
      data: (hotelData){
        List<Hotel> hotelList=[];

        for(int i=0;i<hotelData.length;i++){
           if(wishListModelClass.listOfHotelIds.contains(hotelData[i].id)){
             hotelList=[...hotelList,hotelData[i]];
           }

        }
        print(hotelList.length);
        return Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: hotelList.length,
                itemBuilder: (context,index){
                  return Container(
                    width: double.infinity,
                    height: 430,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.only(left: 5.0 ,right: 5.0),
                    child: ThreeWidgetContainer(
                        imageWidth: double.infinity,
                        imageHeight: 350,
                        title: hotelList[index].name,
                        subtitle: "\$${hotelList[index].charges} Night",
                        onTap: (){}, isRadius: true, imageUrl: "assets/images/Rectangle29.png",
                      child: RatingAndFavorite(
                          isTrue: true,
                          rating: hotelList[index].rating, function: (){}),
                    ),

                  );
                })
          ],
        );
      },
      error: (error,track)=>Center(child: Text(error.toString()),),
      loading: ()=>const Center(child: CircularProgressIndicator(),));

  }
