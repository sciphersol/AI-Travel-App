import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app/Home_screen/filter.dart';
import 'package:travel_app/Home_screen/hotel_details.dart';
import 'package:travel_app/Home_screen/search_destination.dart';
import 'package:travel_app/constant_widgets/app_color.dart';
import 'package:travel_app/constant_widgets/custom_icons.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';

import 'package:travel_app/riverpord/riverpord.dart';
import 'package:travel_app/wishlist/wishlist.dart';
import '../acoount/account_page.dart';
import '../constant_widgets/list_items.dart';
import '../mytrip/mytrip_page.dart';
import '../wishlist/add_to_wishlist.dart';
import 'date_guest.dart';

class HomeScreen extends ConsumerWidget {
   HomeScreen({super.key});
  final mainPageController = PageController();

 final  List<Widget> screen=[
     PageScreen(),
     Wishlist(),
    const MyTripPage(),
   AccountPage(),
  ];
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final currentIndex=ref.watch(navigationNotifierProvider);
    return Scaffold(
      body: screen[currentIndex],
      backgroundColor: MyAppColor.backgroundColor,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        height: MediaQuery.sizeOf(context).height * 0.15,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: MyAppColor.buttonColor,
            unselectedItemColor: Colors.black38,
            elevation: 0.0,
            selectedIconTheme: const IconThemeData(size: 30),
            showUnselectedLabels: true,
            currentIndex: currentIndex,

            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle:  const TextStyle(fontWeight: FontWeight.bold),
            onTap: (index) {
              ref.read(navigationNotifierProvider.notifier).setSelectedIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "Wishlist",
                icon: Icon(Icons.favorite),
              ),
              BottomNavigationBarItem(
                label: "My trip",
                icon: Icon(Icons.flight), // don't know the name of the icon
              ),
              BottomNavigationBarItem(
                label: "Account",
                icon: Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


List<Widget> screenList = [
   ColumnWidget(),
  const Center(
    child: TextWidget(text: "Page2"),
  ),
  const Center(
    child: TextWidget(text: "Page3"),
  ),
  const Center(
    child: TextWidget(text: "Page4"),
  ),
  const Center(
    child: TextWidget(text: "Page5"),
  ),
  const Center(
    child: TextWidget(text: "Page6"),
  )
];

///provider
// Define a StateNotifier for managing the selected index
class PageIndexNotifier extends StateNotifier<int> {
  PageIndexNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }
}

// Define a provider for PageIndexNotifier
final pageIndexProvider = StateNotifierProvider<PageIndexNotifier, int>((ref) {
  return PageIndexNotifier();
});

class AppBarNotifier extends StateNotifier<int> {
  AppBarNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }
}

// Define a provider for PageIndexNotifier
final appBarProvider = StateNotifierProvider<AppBarNotifier, int>((ref) {
  return AppBarNotifier();
});

final stringProvider=StateProvider<String>((ref)=>"");

final textEditingControllerProvider=StateProvider<TextEditingController>((ref)=>TextEditingController());

class PageScreen extends ConsumerWidget {
   PageScreen({super.key});
  final int mainIndex = 0;
  final mainPageController = PageController();

  @override
  Widget build(BuildContext context,WidgetRef ref) {

   ref.watch(hotelModelClassProvider);

    final mainIndex = ref.watch(pageIndexProvider); ///read provider value
    final pageNotifier = ref.read(pageIndexProvider.notifier);///update provider value

    return Scaffold(
      backgroundColor: MyAppColor.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyAppColor.backgroundColor,
        title: TextFieldWidget(
          isBorder: true,
          controller: ref.watch(textEditingControllerProvider),
          leadingIcon: Icons.search,
          radius: 30,
          hintText: "Where to?",
          trailingIcon:   ref.read(textEditingControllerProvider).text.isNotEmpty?Icons.navigate_next:null,
          trailingFn:   ref.read(textEditingControllerProvider).text.isNotEmpty?(){
            Navigator.push(context, MaterialPageRoute(builder: (builder)=>CalendarFilter()));
          }:null,
          onChanged: (value){
            ref.read(textEditingControllerProvider).text=value;
            ref.read(stringProvider.notifier).state=  ref.read(textEditingControllerProvider).text;
          },

          fillColor: Colors.white,
        ),
        actions: [
          if(
          ref.read(textEditingControllerProvider).text.isEmpty)
            InkWell(
              onTap: () async {
     Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FilterScreen()));
              },
              child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: MyAppColor.textFieldColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Icon(CustomIcons.filter)),
            )
        ],
      ),
      body: ref.watch(stringProvider).isNotEmpty? const SearchDestination() :Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const SizedBox(height: 10,),
            SizedBox(
              height: 50,
              child: ListView.builder(
                // itemExtent: 9.0,
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: OutLinedButton(
                        index: index,
                        pageIndex: mainIndex,
                        title: "Mansion",
                        onPressed: () {
                          pageNotifier.setIndex(index);
                          mainPageController.jumpToPage(index);

                        },
                        leadingIcon: CustomIcons.world,
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: PageView.builder(
                  itemCount: screenList.length,
                  onPageChanged: (index) {
                    pageNotifier.setIndex(index);

                  },
                  controller: mainPageController,
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                        child: screenList[index]
                    );
                  }),
            )

          ],
        );
      },),
    );
  }
}



class ColumnWidget extends ConsumerWidget {
   ColumnWidget({super.key});
  final pageController = PageController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    //double width = MediaQuery.of(context).size.width;
    final asyncData = ref.watch(userProfileModalClassProvider);
    final asyncHotelData=ref.watch(hotelModelClassProvider);
    return Consumer(
      builder:(context,ref,child)=> Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: height * (0.5 - 0.07),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    TextWidget(
                      text: "Awesome place for you!",
                      isBold: true,
                      fontSize: 20,
                    ),
                    TextWidget(
                      text:
                      "There are many place that you can visit with your family",
                      fontSize: 12,
                    ),
                  ],),
                ),
                asyncHotelData.when(
                    data: (hotelData){
                     return asyncData.when(
                         data: (userData){
                           if(userData!=null){
                             return Expanded(
                               child: ListView.builder(
                                 shrinkWrap: true,
                                 physics: const BouncingScrollPhysics(),
                                 scrollDirection: Axis.horizontal,
                                 itemCount: hotelData.length,
                                 itemBuilder: (BuildContext context, int index) {
                                   List<String> list=[];
                                   if(userData.wishlist!.isNotEmpty){
                                     for(int i=0;i<userData.wishlist!.length;i++){
                                       list=[...list,...userData.wishlist![i].listOfHotelIds];
                                     }
                                   }
                                   bool value= list.contains(hotelData[index].id);
                                   return Container(
                                     width: 180,
                                     padding: const EdgeInsets.only(left: 5.0 ,right: 5.0),
                                     child: ThreeWidgetContainer(
                                       isTitle: true,
                                       imageWidth: 180,
                                       imageHeight: 190,
                                       imageUrl: "assets/images/Rectangle31.png",
                                       title: hotelData[index].name,
                                       subtitle: "\$${hotelData[index].charges}/Night",
                                       onTap: () {
                                         Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                             builder: (builder) => HotelDetails(
                                               imageUrl: "assets/images/Rectangle31.png",
                                               hotel: hotelData[index],
                                             ),
                                           ),
                                         );
                                       },
                                       isRadius: true,
                                       child: RatingAndFavorite(
                                         rating: hotelData[index].rating,
                                         isTrue:value,
                                         function: () {
                                           showModalBottomSheet(
                                             isScrollControlled: true,
                                               useSafeArea: true,
                                               context: context,
                                             //  scrollControlDisabledMaxHeightRatio: MediaQuery.sizeOf(context).height*0.9,
                                               showDragHandle: true,
                                               builder: (context){
                                                 return addToWishListModelBottomSheet(userData,context,ref, hotelData[index].id);
                                               });
                                         },
                                       ),
                                     ),
                                   );
                                 },
                               ),
                             );
                           }else{
                             return Expanded(
                               child: ListView.builder(
                                 shrinkWrap: true,
                                 physics: const BouncingScrollPhysics(),
                                 scrollDirection: Axis.horizontal,
                                 itemCount: hotelData.length,
                                 itemBuilder: (BuildContext context, int index) {

                                   return Padding(
                                     padding: const EdgeInsets.only(right: 12.0),
                                     child: ThreeWidgetContainer(
                                       imageWidth: 180,
                                       imageHeight: 190,
                                       imageUrl: "assets/images/Rectangle31.png",
                                       title: hotelData[index].name,
                                       subtitle: "\$${hotelData[index].charges}/Night",
                                       onTap: () {
                                         Navigator.push(
                                           context,
                                           MaterialPageRoute(
                                             builder: (builder) => HotelDetails(
                                               imageUrl: "assets/images/Rectangle31.png",
                                               hotel: hotelData[index],
                                             ),
                                           ),
                                         );
                                       },
                                       isRadius: true,
                                       child: RatingAndFavorite(
                                         rating: hotelData[index].rating,
                                         isTrue:false,
                                         function: () {
                                          /* showModalBottomSheet(context: context,
                                               builder: (context){
                                                 return addToWishListModelBottomSheet(context,ref, hotelData[index].id);
                                               });*/
                                         },
                                       ),
                                     ),
                                   );
                                 },
                               ),
                             );
                           }
                         },
                         error: (error,track)=>const Center(child: TextWidget(text: "Something went wrong"),),
                         loading: ()=>const Center(child: CircularProgressIndicator(),)
                     );
                    },
                    error: (error,track)=>const Center(child: TextWidget(text: "Something went wrong"),),
                    loading: ()=>const Center(child: CircularProgressIndicator(),)
                ),
              ],
            ),
          ),
          ///
          Container(
            // margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            color: Colors.white,
            width: double.infinity,
            height: height * (0.3 - 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: "Big promo for your best holiday",
                      isBold: true,
                      fontSize: 20,
                    ),
                    TextWidget(
                      text: "Enjoy your holiday with our interesting promo!",
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ImageContainer(
                    isRadius: true,
                    imageUrl: "assets/images/yellowCard.png",
                    height: height * (0.2 - 0.04),
                    width: double.infinity,
                    child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 100,
                                    child: TextWidget(
                                      text: "Use promo code",
                                      isBold: true,
                                      fontSize: 14,
                                      color: Colors.white,
                                    )),
                                SizedBox(
                                    width: 100,
                                    child: TextWidget(
                                      text: "to enjoy a 20% discount",
                                      isBold: true,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    width: 150,
                                    child: TextWidget(
                                      text: "TRAVELFUN20",
                                      isBold: true,
                                      fontSize: 20,
                                      color: Colors.white,
                                    )),
                                SizedBox(
                                    width: 80,
                                    child: TextWidget(
                                      text: "ON YOUR NEXT TRIP",
                                      isBold: true,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.transparent,
            width: double.infinity,
            height: height * (0.5 - 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: "Another tour that you can enjoy",
                        isBold: true,
                        fontSize: 20,
                      ),
                      TextWidget(
                        text:
                        "We have a bunch of tours that really makes you happy",
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return  Container(
                          width: 180,
                          padding: const EdgeInsets.only(left: 5.0 ,right: 5.0),
                          child: ThreeWidgetContainer(
                            isRadius: true,
                              imageWidth: 180,
                              imageHeight: 190,
                              imageUrl: "assets/images/Rectangle30.png",
                              title: "Sun Royal Hotel Bali",
                              subtitle: "\$40/Night",
                            child: RatingAndFavorite(
                                rating: 4.5,
                              function: (){
                            },),
                            onTap: (){},
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
          ///
          Container(
           height: MediaQuery.sizeOf(context).height*0.6,
            color: MyAppColor.textFieldColor,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: TextWidget(
                    text: "Information articles for you",
                    isBold: true,
                    fontSize: 20,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: TextWidget(
                    text: "Lorem ipsum dolor sit amet consectetur. Eu interdum sed",
                    fontSize: 12,
                  ),
                ),
                Flexible(
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: InformationArticles.informationArticlesList.length,
                    itemBuilder: (context, index) {
                      final item = InformationArticles.informationArticlesList[index];
                      return Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 300,
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),                              child: Image.asset(
                               item.imageUrl,
                                fit: BoxFit.cover,
                              )),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: TextWidget(
                                text: item.text.toString(),
                                isBold: true,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      
                      );
                    },
                  ),
                ),
                Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: InformationArticles.informationArticlesList.length, // Dynamic count
                    effect: const ExpandingDotsEffect(
                      expansionFactor: 1.1,
                      activeDotColor: MyAppColor.buttonColor,
                      dotColor: Colors.grey,
                      dotHeight: 8.0,
                      dotWidth: 8.0,
                      spacing: 8.0,
                    ),
                  ),
                ),
              ],
            ),
          ),

           const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
            title: TextWidget(
              text: "Trip inspirations!",
              isBold: true,
              fontSize: 20,
            ),
            subtitle: TextWidget(
              text:
              "Lorem ipsum dolor sit amet consectetur. Eu interdum",
              fontSize: 12,
            ),
            trailing: Icon(Icons.navigate_next),
          ),
          SizedBox(
            height: 250,
            width: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context,index){
                  return Container(
                      height: 222,
                      width: 160,
                      margin: const EdgeInsets.only(left: 5.0),
                      padding: const EdgeInsets.all( 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: MyAppColor.textFieldColor.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 5,
                            // offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child:const Column(
                        spacing: 5.0,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImageContainer(
                              height: 127,
                              width: 160,
                              isRadius: true,
                              imageUrl: "assets/images/Rectangle31.png"),
                          TextWidget(
                            text: "Top 10 European Christmas Markets",
                            isBold: true,
                            fontSize: 12,
                          ),
                          TextWidget(
                            text:
                            "Lorem ipsum dolor sit amet consectetur. Eu interdum sed",
                            fontSize: 8,
                          )
                        ],
                      )
                  );
                }),
          ),
          const SizedBox(height: 50,)
        ],
      ),
    );
  }
}
