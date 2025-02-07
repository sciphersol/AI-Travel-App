import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app/Home_screen/booking%20details.dart';
import 'package:travel_app/constant_widgets/custom_icons.dart';
import 'package:travel_app/constant_widgets/list_items.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';
import 'package:travel_app/firebase/model/hotel_class.dart';
import 'package:travel_app/riverpord/riverpord.dart';
import '../constant_widgets/app_color.dart';

final roomAdultsNightsProvider=StateProvider<List<int>>((ref)=>[1,1,1,]);

class HotelDetails extends ConsumerWidget {
   HotelDetails({
    super.key,
     required this.imageUrl,
     required this.hotel,
  });
  final String imageUrl;
  final controller = PageController();
  final Hotel hotel;

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    List<String> list1=["Kitchen","Wifi","Free Parking"];
    List<IconData> iconList1=[
      CustomIcons.black_two_dots, CustomIcons.wifi,CustomIcons.p
    ];
    List<String> list2=["Poll","AC","Fitness Room"];
    List<IconData> iconList2=[
      CustomIcons.swiming, CustomIcons.arrow,CustomIcons.gem
    ];
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Carousel using PageView
                  SizedBox(
                    height: 400, // Adjust this height as per your need
                    child: PageView.builder(
                      controller: controller,
                      itemCount: InformationArticles.informationArticlesList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          InformationArticles.informationArticlesList[index].imageUrl,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 10,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: IconButton(
                            color: Colors.white,
                            icon: const Icon(Icons.arrow_back, color: Colors.black),
                            onPressed: () {
                              Navigator.pop(context); // Go back action
                            },
                          ),
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: IconButton(
                                color: Colors.white,
                                icon: const Icon(Icons.share, color: Colors.black),
                                onPressed: () {
                                  // Add your share functionality here
                                },
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.favorite_border, color: Colors.black),
                                onPressed: () {
                                  // Add your favorite functionality here
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: InformationArticles.informationArticlesList.length,
                      effect: const ExpandingDotsEffect(
                        expansionFactor: 1.1,
                        activeDotColor: MyAppColor.buttonColor,
                        dotColor: Colors.grey,
                        dotHeight: 10.0,
                        dotWidth: 10.0,
                        spacing: 10.0,
                      ),
                    ),
                  ),
                ],
              ),
             Padding(
               padding: const EdgeInsets.all(5.0),
               child: Column(
                 spacing: 10,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   RatingBar.builder(
                     itemSize: 20,
                     initialRating: hotel.rating,
                     maxRating: 5.0,
                     minRating: 1,
                     direction: Axis.horizontal,
                     allowHalfRating: true,
                     itemCount: hotel.rating.toInt()==1?1: hotel.rating.toInt()==2?2: hotel.rating.toInt()==3?3: hotel.rating.toInt()==4?4:5,
                     tapOnlyMode: true,
                     ignoreGestures: true,
                     itemBuilder: (context, _) => const Icon(
                       Icons.star_outlined,
                       color: Colors.amber,
                     ), onRatingUpdate: (double value) {
                   },
                   ),
                   TextWidget(
                     text: hotel.name,
                     fontSize: 20,
                     isBold: true,
                   ),
                   TextWidget(text: hotel.location),
                   OutlineButtonWidget(rating: hotel.rating,noReviews: hotel.reviewCount,),
                   lineWidget(),
                   const TextWidget(
                     text: "Facilities",
                     isBold: true,
                     fontSize: 20,
                   ),
                   const TextWidget(
                     text:
                     "Lorem ipsum dolor sit amet consectetur.Eu interdum sed pretium nulla",
                     fontSize: 12,
                   ),
                   Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             ...List.generate(list1.length, (index)=>RowComponents(
                               firstIcon: iconList1[index],
                               firstText: list1[index],
                             ))
                           ],
                         ),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             ...List.generate(list2.length, (index)=>RowComponents(
                               firstIcon: iconList2[index],
                               firstText: list2[index],
                             ))
                           ],
                         ),
                       ],
                     ),
                   ),
                   ButtonWidget(
                     onPress: () {

                     },
                     title: "Show More",
                   ),
                   const TextWidget(
                     text: "Location",
                     isBold: true,
                     fontSize: 20,
                   ),
                   const TextWidget(
                     text:
                     "Lorem ipsum dolor sit amet consectetur. Eu interdum sed pretium nulla",
                     fontSize: 12,
                   ),
                   const SizedBox(
                     height: 100,
                   ),
                   const TextWidget(
                     text: "What they said about us",
                     isBold: true,
                     fontSize: 20,
                   ),
                   const TextWidget(
                     text:
                     "Lorem ipsum dolor sit amet consectetur. Eu interdum sed pretium nulla",
                     fontSize: 12,
                   ),
                 ],
               ),
             ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 250,
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Border color
                            width: 1.5, // Border width
                          ),
                          borderRadius:
                          BorderRadius.circular(8), // Rounded corners
                        ), // Space inside the border
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              ), onRatingUpdate: (double value) {
                            },
                            ),
                            const TextWidget(
                              text:
                              "Lorem ipsum dolor sit amet consectetur. Eu interdum sed pretium nulla neque purus velit quis massa.",
                              fontSize: 9,
                            ),
                            ListTileWidget(
                              title: "Susan Cole",
                              subtitle: "Tokyo, Japan",
                              leadingWidget: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(30),
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      "https://thumbs.wbm.im/pw/small/39573f81d4d58261e5e1ed8f1ff890f6.jpg",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextWidget(
                      text: "\$125/Night",
                      isBold: true,
                      fontSize: 20,
                    ),
                    ButtonWidget(
                      radius: 15,
                      width: 100,
                      onPress: () {
                        List<String>list=["Room","Adults","Nights"];
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return Consumer(
                                  builder: (context,ref,child)=>
                                      Column(
                                mainAxisSize:  MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      spacing: 10,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20,),
                                      if(ref.watch(isLoadingProvider)==true)
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: list.length,
                                          itemBuilder: (context, index) {
                                            // Watch the specific index of countList
                                            final countAtIndex = ref.watch(roomAdultsNightsProvider)[index];
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    TextWidget(text: list[index], isBold: true, fontSize: 15),
                                                    const TextWidget(text: " Lorem ipsum dolor sit amet consectetur",fontSize: 12,)
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    // Modify count at the specific index
                                                    List<int> currentList = List.from(ref.read(roomAdultsNightsProvider)); // Create a copy of the list
                                                    if (currentList[index] > 1) {
                                                      currentList[index]--;
                                                      ref.read(roomAdultsNightsProvider.notifier).state = currentList; // Replace the list
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.remove_circle_outline,
                                                    size: 32,
                                                    color:  countAtIndex == 1
                                                        ? Colors.grey
                                                        : Colors.black,
                                                  ),
                                                ),
                                                TextWidget(
                                                  text: countAtIndex.toString(),
                                                  isBold: true,
                                                  fontSize: 24,
                                                  color:countAtIndex == 1
                                                      ? Colors.grey
                                                      : Colors.black,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    // Modify count at the specific index
                                                    List<int> currentList = List.from(ref.read(roomAdultsNightsProvider)); // Create a copy of the list
                                                    currentList[index]++;
                                                    ref.read(roomAdultsNightsProvider.notifier).state = currentList; // Replace the list
                                                  },
                                                  child: const Icon(
                                                    Icons.add_circle_outline,
                                                    size: 32,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${ref.watch(roomAdultsNightsProvider)[0]} room, ${ref.watch(roomAdultsNightsProvider)[1]} adults, ${ref.watch(roomAdultsNightsProvider)[2]} nights',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              ref.read(isLoadingProvider.notifier).state=!ref.watch(isLoadingProvider);
                                            },
                                            child: ref.watch(isLoadingProvider)?const Icon(Icons.done):const Icon(Icons.edit),
                                          )
                                        ],
                                      ),

                                    ],),
                                  ),
                                  SizedBox(
                                      height: MediaQuery.sizeOf(context).height*0.5,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: 3,
                                        itemBuilder: (context,index){

                                          List<String> iconsName=[
                                            "2 Breakfasts","Instan confirmation","Refundable","1 King-Size bed","Free wifi"
                                          ];
                                          List<IconData>iconDataList=[ CustomIcons.store, Icons.check_circle, CustomIcons.arrow_left,CustomIcons.car,CustomIcons.wifi];
                                          List<OfferType> offerTypeList=[
                                            OfferType(offer: "Standard Deluxe", chargesPerNight: 150),
                                            OfferType(offer: "Standard Deluxe Plus", chargesPerNight: 250),
                                            OfferType(offer: "Standard Deluxe Premium", chargesPerNight: 350),
                                          ];

                                          return Container(

                                            margin: const EdgeInsets.only(left: 5.0,bottom: 10.0),
                                            padding: const EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey, // Border color
                                                width: 1.5, // Border width
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(8), // Rounded corners
                                            ), // Space inside the border
                                            child: Column(
                                              spacing: 10,
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(text: offerTypeList[index].offer,isBold: true,fontSize: 20,),
                                                ...List.generate(5, (subIndex)=>RowComponents(firstIcon: iconDataList[subIndex], firstText: iconsName[subIndex])),
                                                TextWidget(text: "\$${offerTypeList[index].chargesPerNight}/Night",isBold: true,fontSize: 20,),
                                                const TextWidget(text: "(exclude tax)",fontSize: 12,),
                                                Center(
                                                  child: ButtonWidget(
                                                    width: 200,
                                                    onPress: (){
                                                      ref.read(isLoadingProvider.notifier).state=!ref.watch(isLoadingProvider);

                                                      Navigator.of(context).pop();
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                          BookingDetailsScreen(
                                                            imageUrl: imageUrl,
                                                            roomAdultNightList: ref.watch(roomAdultsNightsProvider),
                                                            offerType: offerTypeList[index],
                                                            hotel: hotel,

                                                          )));
                                                    },
                                                    title: "Select Room",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                  ),
                                ],
                              ));
                            });
                      },
                      title: "Select room",
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RowComponents extends StatelessWidget {
  const RowComponents({
    super.key,
    required this.firstIcon,
    required this.firstText,
    this.color= MyAppColor.buttonColor
  });

  final IconData firstIcon;
  final String firstText;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          firstIcon,
          color: color,
        ),
        const SizedBox(width: 10,),
        TextWidget(
          text: firstText,
          isBold: true,
        )
      ],
    );
  }
}

class OutlineButtonWidget extends StatelessWidget {
  const OutlineButtonWidget({super.key,required this.rating,required this.noReviews});
  final double rating;
  final int noReviews;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                 TextWidget(
                  text:rating.toString(),
                  isBold: true,
                ),
                RatingBar.builder(
                  itemSize: 10,
                  initialRating: rating,
                  maxRating: 5.0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  tapOnlyMode: true,
                  ignoreGestures: true,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star_outlined,
                    color: Colors.black,
                  ), onRatingUpdate: (double value) {
                },
                ),
              ],
            ),
            const TextWidget(
              text: "Very Good",
              isBold: true,
              fontSize: 15,
            ),
             Column(
              children: [
                TextWidget(
                  text: noReviews.toString(),
                  isBold: true,
                ),
                const TextWidget(
                  text: "Reviews",
                  isBold: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class OfferType{
  String offer;
  int chargesPerNight;
  OfferType({required this.offer,required this.chargesPerNight});
}
Widget lineWidget(){
  return Container(
height: 1.0,
width: double.infinity,
color: Colors.grey,
);
}
