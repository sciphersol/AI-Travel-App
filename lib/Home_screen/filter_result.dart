import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../acoount/booking.dart';
import '../constant_widgets/app_color.dart';
import '../constant_widgets/widget_ui_components.dart';
import '../firebase/firebase_crud_operations.dart';
import '../firebase/model/filter.dart';
import '../firebase/model/hotel_class.dart';


class FilterResult extends ConsumerWidget {
  const FilterResult({super.key, required this.filter, required this.collectionName});

  final HotelFilter filter;
  final String collectionName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: MyAppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyAppColor.backgroundColor,
        title: const Text("Filtered Places"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: ref.watch(firebaseProvider).getFilteredHotels(filter, collectionName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressWidget(message: "Please wait");
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final documents = snapshot.data!;
        
                  List<Hotel> hotels = documents.map((doc) => Hotel.fromFireStore(doc.data() as Map<String,dynamic>)).toList();
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      mainAxisSpacing: 10, // Spacing between rows
                      crossAxisSpacing: 10, // Spacing between columns
                      childAspectRatio: .7, // Aspect ratio of each item
                    ),
                    itemCount: hotels.length, // Number of items
                    itemBuilder: (context, index) {
                      return GridViewCard(
                        onTap: () {
        
                        },
                        imageUrl: "assets/images/Rectangle30.png",
                        title: hotels[index].name,

                        subtitle: '\$${hotels[index].charges} /Night',
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const TextWidget(text: "Something went wrong");
                } else {
                  return const TextWidget(text: "Unknown error");
                }
              } else {
                return const MyInternetConnectionWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}


