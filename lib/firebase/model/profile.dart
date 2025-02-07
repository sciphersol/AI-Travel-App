import 'package:travel_app/firebase/model/wishlist.dart';

class Profile {
  String id;
  String name;
  String userName;
  String phoneNumber;
  String email;
  String password;
  String address;
 List<WishListModelClass>? wishlist;

  Profile({
    required this.id,
    required this.name,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.address,
    this.wishlist,
  });

  // Convert Profile instance to JSON (Map<String, dynamic>)
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'name': name,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'address': address,
      'wishlist': wishlist?.map((wishlist)=>wishlist.toJSON()).toList()??[],
    };
  }

  // Convert JSON (Map<String, dynamic>) to Profile instance
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      userName: json['userName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      wishlist: json['wishlist'] is Iterable? List.from(json['wishlist']).map((wishlist)=>WishListModelClass.fromJSON(wishlist)).toList():[],
    );
  }
}
