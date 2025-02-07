
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Home_screen/attraction.dart';
import 'package:travel_app/Home_screen/hotel_details.dart';
import 'package:travel_app/mytrip/create_trip_plan.dart';
import 'package:travel_app/riverpord/riverpord.dart';
import '../constant_widgets/app_color.dart';
import '../constant_widgets/widget_ui_components.dart';

String getMonthName(int month) {
  switch (month) {
    case 1: return "January";
    case 2: return "February";
    case 3: return "March";
    case 4: return "April";
    case 5: return "May";
    case 6: return "June";
    case 7: return "July";
    case 8: return "August";
    case 9: return "September";
    case 10: return "October";
    case 11: return "November";
    case 12: return "December";
    default: return "Unknown";
  }
}

class CalendarFilter extends ConsumerWidget {
   CalendarFilter({super.key});

 final DateTime today = DateTime.now();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String checkInDate = ref.watch(rangeStartAndRangeEndProvider).rangeStart != null
        ? "${getMonthName(ref.watch(rangeStartAndRangeEndProvider).rangeStart !.month).substring(0,3)} ${ref.watch(rangeStartAndRangeEndProvider).rangeStart !.day}"
        : "Not selected";
    String checkOutDate = ref.watch(rangeStartAndRangeEndProvider).rangeEnd != null
        ? "${getMonthName(ref.watch(rangeStartAndRangeEndProvider).rangeEnd !.month).substring(0,3)} ${ref.watch(rangeStartAndRangeEndProvider).rangeEnd !.day}"
        : "Not selected";
    return Scaffold(
      backgroundColor: MyAppColor.textFieldColor,
      appBar: AppBar(
        backgroundColor: MyAppColor.textFieldColor,
        title: const Text("Select date"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            spacing: 30,
            children: [
              Container(
                padding:const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffFDFDFD)
                ),
                child: CalendarWidget(
                  rangeStart: ref.watch(rangeStartAndRangeEndProvider).rangeStart,
                  rangeEnd: ref.watch(rangeStartAndRangeEndProvider).rangeEnd,
                  onRangeSelected: (start,end,focused){
                    ref.watch(rangeStartAndRangeEndProvider.notifier).updateRange(start,end,focused);
                  },
                  initialFocusedDay: today,
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const
                          TextWidget(text: "Check in"),
                          TextWidget(
                            text: checkInDate,
                            isBold: true,
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        size: 50,
                        color: Colors.grey,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWidget(text: "Check out"),
                          TextWidget(
                            text: checkOutDate,
                            isBold: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ButtonWidget(
                onPress: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>SelectGuest(startRange: checkInDate,endRange: checkOutDate,)));
                },
                title: "Confirm",
              ),
            ],
          ),
        ),
      ),
    );
  }
}


final countList = StateProvider<List<int>>((ref) => [1, 0, 0]);

class SelectGuest extends ConsumerWidget {
  const SelectGuest({super.key, required this.startRange, required this.endRange});

  final String startRange;
  final String endRange;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> list = ["Adults", "Children", "Infants"];

    return Scaffold(
      backgroundColor: MyAppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyAppColor.backgroundColor,
        title: const Text("Select Guest"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final countAtIndex = ref.watch(countList)[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(text: list[index], isBold: true, fontSize: 20),
                              const TextWidget(text: " Lorem ipsum dolor sit amet consectetur")
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              List<int> currentList = List.from(ref.read(countList));
                              if (index == 0) {
                                if (currentList[index] > 1) {
                                  currentList[index]--;
                                  ref.read(countList.notifier).state = currentList;
                                }
                              } else {
                                if (currentList[index] > 0) {
                                  currentList[index]--;
                                  ref.read(countList.notifier).state = currentList;
                                }
                              }
                            },
                            child: Icon(
                              Icons.remove_circle_outline,
                              size: 32,
                              color: (index == 0 && countAtIndex == 1) || (index != 0 && countAtIndex == 0)
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                          Consumer(
                            builder: (BuildContext context, WidgetRef ref, Widget? child) =>
                                TextWidget(
                                  text: countAtIndex.toString(),
                                  isBold: true,
                                  fontSize: 24,
                                  color: (index == 0 && countAtIndex == 1) || (index != 0 && countAtIndex == 0)
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                          ),
                          InkWell(
                            onTap: () {
                              List<int> currentList = List.from(ref.read(countList));
                              currentList[index]++;
                              ref.read(countList.notifier).state = currentList;
                            },
                            child: const Icon(
                              Icons.add_circle_outline,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                      lineWidget(),
                    ],
                  ),
                );
              },
            ),
            ButtonWidget(
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (builder) =>  SearchDestinationResult(list: ref.watch(countList),startRange: startRange,endRange: endRange,)),
                );
              },
              title: "Search Destination",
            ),
          ],
        ),
      ),
    );
  }
}

///
class SearchDestinationResult extends ConsumerWidget {
   SearchDestinationResult({super.key,required
   this.list,required this.startRange,required this.endRange});

  final TextEditingController controller=TextEditingController();
  final List<int> list;
  final String startRange;
   final String endRange;
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    double height=MediaQuery.sizeOf(context).height;
    final hotelData=ref.watch(hotelDataProvider('hotel'));

    return Scaffold(
      backgroundColor: MyAppColor.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyAppColor.backgroundColor,
        title: TextFieldWidget(controller: controller,
        fillColor: Colors.white,
          isBorder: true,
          radius: 30,
          trailingIcon: Icons.search,
        ),
      ),
      body: hotelData.when(
          data: (data){
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 30,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_month),
                        const SizedBox(width: 8.0,),
                        TextWidget(text: startRange,fontSize: 12,),
                        const Icon(Icons.arrow_forward,),
                        TextWidget(text:endRange ,fontSize: 12,),
                        const SizedBox(width: 15,),
                        const Icon(Icons.person),
                        const SizedBox(width: 8.0,),
                        Expanded(child: TextWidget(text: "${list[0]} adults, ${list[1]} children, ${list[2]} infants",fontSize: 12,)),
                      ],
                    ),
                    lineWidget(),
                    SizedBox(
                      width:  double.infinity,
                      height: height*(0.4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWidget(text: "Holiday in Bali", isBold: true,fontSize: 20,),
                          const TextWidget(text: "There are many place that you can visit with your family",fontSize: 12,),
                      Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: ThreeWidgetContainer(
                                  imageWidth: 180,
                                  imageHeight: 190,
                                  imageUrl: "assets/images/Rectangle31.png",
                                  title:  data[index].name,
                                  subtitle: "\$${data[index].charges}/Night",
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>HotelDetails(
                                      hotel: data[index],
                                      imageUrl: "assets/images/Rectangle31.png",
                                    )));

                                  }, isRadius: true,
                                  child:  RatingAndFavorite(
                                    function: (){}, rating: data[index].rating,),
                                ),
                              );
                            }),
                      ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width:  double.infinity,
                      height: height*(0.4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWidget(text: "Attraction in Bali", isBold: true,fontSize: 20,),
                          const TextWidget(text: "There are many place that you can visit with your family",fontSize: 12,),
                          Expanded(
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (BuildContext context,int index){
                                  return  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: ThreeWidgetContainer(
                                      imageWidth: 180,
                                      imageHeight: 190,
                                      imageUrl: "assets/images/Rectangle30.png",
                                      title: data[index].name,
                                      subtitle: "\$${data[index].charges}", isRadius: true,
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>AttractionScreen(hotel: data[index],imageUrl: "assets/images/Rectangle30.png",)));
                                      },
                                      child:   RatingAndFavorite(
                                          rating: data[index].rating,
                                        function: (){},),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width:  double.infinity,
                      height: height*(0.4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWidget(text: "Restaurant in Bali", isBold: true,fontSize: 20,),
                          const TextWidget(text: "There are many place that you can visit with your family",fontSize: 12,),
                          Expanded(
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (BuildContext context,int index){
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: ThreeWidgetContainer(

                                      imageWidth: 180,
                                      imageHeight: 190,
                                      imageUrl: "assets/images/Rectangle31.png",
                                      title: data[index].name,
                                      subtitle: "(${data[index].reviewCount}K reviews)", isRadius: true,
                                      onTap: (){

                                      },
                                      child:   RatingAndFavorite(
                                          rating: data[index].rating,
                                        function: (){},),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 30,),
                  ],
                ),
              ),
            );
          },
          error: (e,value)=>const Center(child: Text("Check your internet connection"),),
         loading: ()=>const Center(child: CircularProgressIndicator(),),

      )
    );
  }
}
