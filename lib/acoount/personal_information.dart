import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/constant_widgets/app_color.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';
import 'package:travel_app/firebase/firebase_crud_operations.dart';
import 'package:travel_app/firebase/model/profile.dart';
import 'package:travel_app/riverpord/riverpord.dart';

final controllersListProvider = StateProvider.autoDispose.family<List<TextEditingController>,int >(
      (ref,index) => List.generate(index, (index) => TextEditingController()),
);
final isReadOnlyProvider=StateProvider<bool>((ref)=>true);

final isSecureTextProvider=StateProvider<bool>((ref)=>true);

class PersonalInformation extends ConsumerWidget {
  PersonalInformation({super.key});

  final List<String> listNames = [
    "Your name", "Username", "Phone Number", "Email", "Password", "Address"
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllers = ref.watch(controllersListProvider(6));
    final asyncData= ref.watch(userProfileModalClassProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const TextWidget(text: "Personal Information",isBold: true,),
        actions:  [
         if(ref.watch(isReadOnlyProvider)) GestureDetector(
            onTap: (){
              ref.read(isReadOnlyProvider.notifier).state=!ref.watch(isReadOnlyProvider);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: TextWidget(text: "Edit", fontSize: 16,isBold: true,),
            ),
          ) else GestureDetector(
           onTap: (){
             ref.read(isReadOnlyProvider.notifier).state=!ref.watch(isReadOnlyProvider);
           },
           child: const Padding(
             padding: EdgeInsets.only(right: 30.0),
             child: TextWidget(text: "Cancel", fontSize: 16,isBold: true,),
           ),
         ) ,
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            spacing: 40,
            children: [
              asyncData.when(
                  data: (userData){
                    if(userData!=null){
                      return  _buildFormForUserData(controllers,userData,listNames,ref,true);
                    }else{
                      return  _buildFormForUserData(controllers,userData,listNames,ref,false);
                    }
                  },
                  error: (error,track)=>const Center(child: TextWidget(text: "Something went wrong"),),
                  loading: ()=>const Center(child: CircularProgressIndicator(),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildFormForUserData(List<TextEditingController> controllers, Profile? userData, List<String> listNames, WidgetRef ref, bool isUpdate){
  final List<String> dataList = [
    ref.watch(authStateProvider).asData!.value!.displayName.toString(),
    "${ref.watch(authStateProvider).asData!.value!.displayName!
        .toLowerCase()
        .replaceAll(' ', '')}@${Random().nextInt(9000) + 1000}",
    ref.watch(authStateProvider).asData!.value!.phoneNumber??"Not Provided",
    ref.watch(authStateProvider).asData!.value!.email.toString(), "Password", "Not provided"
  ];
  for (int i = 0; i < controllers.length; i++) {
    if (controllers[i].text != dataList[i]) {
      controllers[i].text = dataList[i];
    }
  }
  return  ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 6,
    itemBuilder: (context, index) {

      if(userData!=null){
        controllers[0].text=userData.name;
        controllers[1].text=userData.userName;
        controllers[2].text=userData.phoneNumber;
        controllers[3].text=userData.email;
        controllers[4].text=userData.password;
        controllers[5].text=userData.address;
      }
      final controller = controllers[index];
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: listNames[index],
              fontSize: 14,
            ),
            Consumer(
              builder:(context,ref,child)=> TextField(
                obscureText: index==4?ref.watch(isSecureTextProvider):false,
                style: const TextStyle(fontSize: 20),
                readOnly: ref.watch(isReadOnlyProvider), // Set this to true if you want a read-only text field
                controller: controller,  // Use the controller directly
                decoration:  InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:ref.watch(isReadOnlyProvider)? Colors.black:Colors.blue),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:ref.watch(isReadOnlyProvider)? Colors.black:Colors.blue),
                    ),
                    suffixIcon: index==4?GestureDetector(
                        onTap: (){
                          ref.read(isSecureTextProvider.notifier).state=!ref.watch(isSecureTextProvider);
                        },
                        child:  Icon(ref.watch(isSecureTextProvider)?Icons.visibility_off:Icons.visibility,color: MyAppColor.buttonColor,)):null
                ),
              ),
            ),
            if(index==5)const SizedBox(height: 50,),
            if(index==5 && !ref.watch(isReadOnlyProvider))
              if( !ref.watch(isReadOnlyProvider))
                ButtonWidget(onPress: () {
                  String name = controllers[0].text;
                  String username = controllers[1].text;
                  String phoneNumber = controllers[2].text;
                  String email = controllers[3].text;
                  String password = controllers[4].text;
                  String address = controllers[5].text;
                  Profile data = Profile(
                      id: ref.watch(userIdProvider),
                      name: name,
                      userName: username,
                      phoneNumber: phoneNumber,
                      email: email,
                      password: password,
                      address: address,
                      wishlist: userData?.wishlist
                  );
                  if(isUpdate==true){
                    ref.watch(firebaseProvider).updateDocument("users",ref.watch(userIdProvider), data.toJson());
                  } else if(isUpdate==false){
                    ref.watch(firebaseProvider).createDocumentWithId("users",ref.watch(userIdProvider), data.toJson());
                  }
                  ref.read(isReadOnlyProvider.notifier).state = !ref.watch(isReadOnlyProvider);
                }, title: isUpdate?"Update":'Save',)

          ],
        ),
      );
    },

  );
}


Widget buildTextField(TextEditingController controller,bool isReadOnly, String? text){
  return TextField(
    onTap: (){

    },
    style: const TextStyle(fontSize: 20),
    readOnly:isReadOnly, // Set this to true if you want a read-only text field
    controller: controller,  // Use the controller directly
    decoration:  InputDecoration(
      hintText: text??text,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),

    ),
  );
}