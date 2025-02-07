import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Home_screen/home_screen.dart';
import 'package:travel_app/constant_widgets/app_color.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';
import 'package:travel_app/firebase/firebase_crud_operations.dart';
import 'package:travel_app/firebase/model/booking.dart';
import 'package:travel_app/riverpord/riverpord.dart';
import '../firebase/model/hotel_class.dart';
import '../mytrip/create_trip_plan.dart';
import 'hotel_details.dart';


final totalGuestProvider=StateProvider<List<int>>((ref)=>[ref.watch(roomAdultsNightsProvider)[1],0,0,]);
class BookingDetailsScreen extends ConsumerWidget {
   BookingDetailsScreen({super.key, required this.imageUrl,
     required this.roomAdultNightList,
     required this.offerType,
     required this.hotel
   });
   final List<int> roomAdultNightList;
   final OfferType offerType;
   final Hotel hotel;

  final String imageUrl;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
   final TextEditingController couponController = TextEditingController();


   final DateTime today=DateTime.now();
   void _showModelBottomSheet(BuildContext context, WidgetRef ref) {
     showModalBottomSheet(
       context: context,
       builder: (BuildContext context) {
         return Consumer(builder: (context,ref,child)=>CalendarWidget(
           rangeStart: ref.watch(rangeStartAndRangeEndProvider).rangeStart,
           rangeEnd: ref.watch(rangeStartAndRangeEndProvider).rangeEnd,
           onRangeSelected: (start, end, focused) {
             ref.read(rangeStartAndRangeEndProvider.notifier).updateRange(start, end, focused);
           },
           initialFocusedDay: today,
         ),
         );
       },
     );
   }

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    int price= offerType.chargesPerNight*roomAdultNightList[2];
    int appServiceFee=85;
    int taxes=120;
    int finalPrice=price+appServiceFee+taxes;
    return Scaffold(
      backgroundColor: MyAppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyAppColor.backgroundColor,
        title: const TextWidget(
          text: "Reservation",
          isBold: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                //height: 200,
                width: double.infinity,

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageContainer(
                        width: 150,
                        height: 150,
                        isRadius: true,
                        imageUrl: imageUrl.toString()),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ButtonWidget(
                            onPress: () {},
                            titleColor: MyAppColor.buttonColor,
                            width: 100,
                            height: 40,
                            fontSize: 12,
                            title: "Best Choice",
                            color: const Color(0xffe4edfd),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const TextWidget(text: "Sun Royal Hotel Bali"),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: List.generate(
                              6, // Number of elements (5 stars + 1 text widget)
                              (index) {
                                if (index == 5) {
                                  return const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: TextWidget(
                                      text: "(500)",
                                      isBold: true,
                                      fontSize: 12.0,
                                      color: Colors.black,
                                    ),
                                  );
                                }
                                return const Icon(
                                  Icons.star,
                                  color: Colors.black,
                                  size: 15.0,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              lineWidget(),
              const TextWidget(
                text: "Select Dates",
                isBold: true,
                fontSize: 20,
              ),
              Container(
                width: double.infinity,
                height: 60,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: MyAppColor.textFieldColor,
                    borderRadius: BorderRadius.circular(10)),
                child: GestureDetector(
                  onTap: ()  {
                    _showModelBottomSheet(context,ref);
                  },
                  child:Consumer(
                    builder:(context,ref,child)=> Row(
                      spacing: 10,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                        ),
                        TextWidget(
                          text: ref.watch(rangeStartAndRangeEndProvider).rangeStart != null
                              ? "${ref.watch(rangeStartAndRangeEndProvider).rangeStart?.day}/${ref.watch(rangeStartAndRangeEndProvider).rangeStart?.month}/${ref.watch(rangeStartAndRangeEndProvider).rangeStart?.year}"
                              : "Start date", // "Start date" when rangeStart is null
                        ),
                        const Icon(Icons.arrow_forward),
                        TextWidget(
                          text: ref.watch(rangeStartAndRangeEndProvider).rangeEnd != null
                              ? "${ref.watch(rangeStartAndRangeEndProvider).rangeEnd!.day}/${ref.watch(rangeStartAndRangeEndProvider).rangeEnd!.month}/${ref.watch(rangeStartAndRangeEndProvider).rangeEnd!.year}"
                              : "End date", // "End date" when rangeEnd is null
                        ),
                      ],
                    ),
                  ),

                ),
              ),
              lineWidget(),
              Column(
                children: [const
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: "Total Guest",
                      isBold: true,
                      fontSize: 20,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                    )
                  ],
                ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        color: MyAppColor.textFieldColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: GestureDetector(
                      onTap: ()  {
                        List<String>list=["Adults","Children","Infants"];
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    // Watch the specific index of countList
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Consumer(
                                            builder:(context,ref,child)=> Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    TextWidget(text: list[index], isBold: true, fontSize: 15),
                                                    const TextWidget(text: " Lorem ipsum dolor sit amet consectetur",fontSize: 12,)
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    // Modify count at the specific index
                                                    List<int> currentList = List.from(ref.read(totalGuestProvider)); // Create a copy of the list
                                                    if (index== 0 && currentList[index]>1) {
                                                      currentList[index]--;
                                                      ref.read(totalGuestProvider.notifier).state = currentList; // Replace the list
                                                    } else if(index>0 && currentList[index]>0){
                                                      currentList[index]--;
                                                      ref.read(totalGuestProvider.notifier).state = currentList;
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.remove_circle_outline,
                                                    size: 32,
                                                    color:  ref.watch(totalGuestProvider)[index]==1 &&index==0
                                                        ? Colors.grey: ref.watch(totalGuestProvider)[index]==0 &&index>0?Colors.grey: Colors.black ,
                                                  ),
                                                ),
                                                TextWidget(
                                                  text: ref.watch(totalGuestProvider)[index].toString(),
                                                  isBold: true,
                                                  fontSize: 24,
                                                  color:ref.watch(totalGuestProvider)[index]==1 &&index==0
                                                      ? Colors.grey: ref.watch(totalGuestProvider)[index]==0 &&index>0?Colors.grey: Colors.black ,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    // Modify count at the specific index
                                                    List<int> currentList = List.from(ref.read(totalGuestProvider)); // Create a copy of the list
                                                    currentList[index]++;
                                                    ref.read(totalGuestProvider.notifier).state = currentList; // Replace the list
                                                  },
                                                  child: const Icon(
                                                    Icons.add_circle_outline,
                                                    size: 32,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child:  TextWidget(
                        text: "${ref.watch(totalGuestProvider)[0]} Adults, ${ref.watch(totalGuestProvider)[1]} Children, ${ref.watch(totalGuestProvider)[2]} Infants " ,
                      ),

                    ),
                  )
                ],
              ),
              lineWidget(),
              Column(
                spacing: 10,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: "Guest Info",
                        fontSize: 20,
                        isBold: true,
                      ),
                      Icon(Icons.person_add_alt_1)
                    ],
                  ),
                  TextFieldWidget(
                    controller: nameController,
                    hintText: "Full name",
                  ),
                  TextFieldWidget(
                    controller: emailController,
                    hintText: "Email ",
                  ),
                  PhoneTextField(
                    controller: phoneController,
                    onChanged: (string) {

                    },
                    fillColor: MyAppColor.textFieldColor,
                  ),
                ],
              ),
              lineWidget(),
              Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: "Coupon Code",
                        isBold: true,
                        fontSize: 20,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                      )
                    ],
                  ),
                  TextFieldWidget(
                    controller: couponController,
                    hintText: "Apply coupon code",
                  )
                ],
              ),
              lineWidget(),
               Column(
                children: [
                  const Row(
                    children: [
                      TextWidget(
                        text: "Price Detail",
                        isBold: true,
                        fontSize: 20,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: "\$${offerType.chargesPerNight}x ${roomAdultNightList[2]} nights",
                      ),
                       TextWidget(
                        text: "\$$price",
                      ),
                    ],
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextWidget(
                        text: "App service fee",
                      ),
                      TextWidget(
                        text: "\$$appServiceFee",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextWidget(
                        text: "Taxes",
                      ),
                      TextWidget(
                        text: "\$$taxes",
                      ),
                    ],
                  ),
                ],
              ),
              lineWidget(),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextWidget(
                    text: "Total",
                    isBold: true,
                    fontSize: 20,
                  ),
                  TextWidget(
                    text: "\$$finalPrice",
                    isBold: true,
                    fontSize: 20,
                  )
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: "Payment Method",
                    isBold: true,
                    fontSize: 20,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                  )
                ],
              ),
              Row(
                children: [
                  ...List.generate(imageList.length, (index)=>GestureDetector(
                    onTap: (){
                      ref.read(paymentTypeProvider.notifier).state=paymentType[index];
                      print( ref.read(paymentTypeProvider.notifier).state=paymentType[index]);
                    },
                    child: Image.network(imageList[index], width: 40,height: 50,),
                  )),
                ],
              ),
              ButtonWidget(
                onPress: () {
                  if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && phoneController.text.isNotEmpty && ref.watch(rangeStartAndRangeEndProvider).rangeStart!=null &&ref.watch(rangeStartAndRangeEndProvider).rangeEnd!=null  ){
                    People people=People(
                        adults:ref.watch(totalGuestProvider)[0],
                        children: ref.watch(totalGuestProvider)[1],
                        infants: ref.watch(totalGuestProvider)[2]);
                    GuestInfo guestInfo=GuestInfo(
                        id: ref.watch(userIdProvider),
                        name: nameController.text,
                        email: emailController.text,
                        phoneNumber:"+${ref.watch(countryCodeProvider).phoneCode}${phoneController.text}",
                        checkIn: ref.watch(rangeStartAndRangeEndProvider).rangeStart?? DateTime.now(),
                        checkOut: ref.watch(rangeStartAndRangeEndProvider).rangeEnd??DateTime.now(),
                        people: people
                    );
                    HotelInfo hotelInfo= HotelInfo(
                        hotelId: hotel.id,
                        offerType: offerType.offer,
                        nights: roomAdultNightList[1],
                        rooms: roomAdultNightList[0],
                        perNightCharges: offerType.chargesPerNight
                    );
                    Payment payment=Payment(
                        payVia: ref.watch(paymentTypeProvider),
                        amount: finalPrice,
                        isPay: true,
                        payDate: DateTime.now()
                    );
                    Reservation data= Reservation(
                      userId: ref.watch(userIdProvider),
                      guestInfo: guestInfo,
                      hotelInfo: hotelInfo,
                      couponCode: couponController.text,
                      payment: payment,
                    );


                    ref.read(roomAdultsNightsProvider.notifier).state=[1,1,1];
                    ref.read(totalGuestProvider.notifier).state=[1,0,0];
             
                    ref.watch(firebaseProvider).createSubCollection("users","reservations", ref.watch(userIdProvider), data.toJSON()).then((value)=> showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              spacing: 10,
                              mainAxisSize: MainAxisSize.min, // Ensure the column takes only as much space as needed
                              children: [
                                const ImageContainer(
                                  height: 200,
                                  width: 100,
                                  isRadius: false,
                                  imageUrl: "assets/images/success.png",
                                ),
                                const TextWidget(
                                  text: "Yeayy!",
                                  isBold: true,
                                  fontSize: 20,
                                ),
                                const TextWidget(
                                  text: "Your reservation was completed, enjoy your vacation",
                                  fontSize: 12,
                                ),
                                ButtonWidget(
                                  onPress: () {
                                    ref.read(rangeStartAndRangeEndProvider.notifier).clearRange();
                                    Navigator.pushAndRemoveUntil( context, MaterialPageRoute(builder: (context) => HomeScreen()), (Route<dynamic> route) => false, );
                                  },
                                  title: 'Go to Home', // Add a title to the button
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ));
                  }
                },
                title: "Confirm and pay",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final paymentTypeProvider=StateProvider<String>((ref)=>paymentType[0]);
List<String>paymentType=["Visa","Apple pay","Master card","G pay","Paypal"];

List<String> imageList=[
"https://www.visa.com.au/dam/VCOM/regional/ve/romania/blogs/hero-image/visa-logo-800x450.jpg",
"https://developer.apple.com/news/images/og/apple-pay-og.jpg",
"https://platform.vox.com/wp-content/uploads/sites/2/chorus/uploads/chorus_asset/file/13674554/Mastercard_logo.jpg?quality=90&strip=all&crop=0,16.666666666667,100,66.666666666667",
"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiICOSc5zxXbqmMNWGcxshYlGxVguem1kziQ&s",
"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-ns1YY_la2zpWjImynS670i2Tktv9zPw4rQ&s",

];