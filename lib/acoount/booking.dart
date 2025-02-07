import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';
import 'package:travel_app/riverpord/riverpord.dart';
import '../Home_screen/date_guest.dart';
import '../constant_widgets/app_color.dart';
import '../firebase/model/hotel_class.dart';

class Booking extends ConsumerWidget {
  const Booking({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final asyncReservationData=ref.watch(bookingModelClassProvider);
    final asyncHotelData=ref.watch(hotelModelClassProvider);

    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(text: "Booking"),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: "My Order",fontSize: 20,),
                  Icon(Icons.navigate_next),
                ],
              ),
            ),
            asyncReservationData.when(
          data: (reservationData) {
          return asyncHotelData.when(
            data: (hotelData) {
              return ListView.builder(
                itemCount: reservationData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                   Hotel hotel=Hotel(name: "", id: "", description: "", location: "", charges: "", rating:0.0, reviewCount: 0);
                  for(int i=0;i<hotelData.length;i++){
                    bool value=hotelData[i].id.contains(reservationData[index].hotelInfo.hotelId);
                    if(value==true){
                      hotel=hotelData[i];
                    }
                  }
                  String checkInMonth = getMonthName(reservationData[index].guestInfo.checkIn.month).substring(0, 3);
                  String checkOutMonth = getMonthName(reservationData[index].guestInfo.checkOut.month).substring(0, 3);
                  int checkInDay = reservationData[index].guestInfo.checkIn.day;
                  int checkOutDay = reservationData[index].guestInfo.checkOut.day;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      spacing: 10,
                      children: [
                        const ImageContainer(
                          height: 150,
                          width: 160,
                          radius: 10,
                          isRadius: true,
                          imageUrl: "assets/images/Rectangle29.png",
                        ),
                        Expanded(
                          child: Column(
                            spacing: 10,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xfffdf2e6),
                                ),
                                child: TextWidget(
                                  text: reservationData[index].payment.isPay ? "Paid" : "Waiting for payment",
                                  color: Colors.orange,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_month),
                                   TextWidget(
                                    text: "$checkInMonth $checkInDay - $checkOutMonth $checkOutDay",
                                    fontSize: 10,
                                  ),
                                ],
                              ),
                              TextWidget(
                                text:  hotel.name,
                                isBold: true,
                                fontSize: 16,
                              ),
                              Row(
                                children: [
                                  RatingBar.builder(
                                    itemSize: 15,
                                    initialRating: hotel.rating,
                                    maxRating: 5.0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    tapOnlyMode: true,
                                    ignoreGestures: true,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star_outlined,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (double value) {},
                                  ),
                                  const SizedBox(width: 5),
                                   TextWidget(
                                    text: "${hotel.reviewCount}", // Example value for rating count
                                    isBold: true,
                                    fontSize: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            error: (error, trackStack) => const Center(child: TextWidget(text: "No data found")),
            loading: () => const Center(child: CircularProgressIndicator()),
          );
        },
        error: (error, trackStack) => const Center(child: TextWidget(text: "No data found")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
          ],
        ),
      ),
    );
  }
}


class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 30,
        children: [
         const CircularProgressIndicator(),
          TextWidget(text: message,isBold: true,),
        ],
      ),
    );
  }
}

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.error,color: Colors.red,size: 100,),
        TextWidget(text: message,isBold: true,),

      ],
    );
  }
}
class MyInternetConnectionWidget extends StatelessWidget {
  const MyInternetConnectionWidget({super.key, });


  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Icon(Icons.wifi_off,color: MyAppColor.buttonColor,size: 100,),
        TextWidget(text: "Please check your internet connection",isBold: true,),

      ],
    );
  }
}
