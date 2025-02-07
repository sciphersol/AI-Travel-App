import 'package:cloud_firestore/cloud_firestore.dart';



class Reservation {
  String userId;
  GuestInfo guestInfo;
  HotelInfo hotelInfo;
  String couponCode;
  Payment payment;

  Reservation({
   required this.userId,
    required this.guestInfo,
    required this.hotelInfo,
    required this.couponCode,
    required this.payment,
  });

  // Method to convert Reservation object to JSON
  Map<String, dynamic> toJSON() {
    return {
      'userId':userId,
      'guestInfo': guestInfo.toJSON(),
      'hotelInfo': hotelInfo.toJSON(),
      'couponCode': couponCode,
      'payment': payment.toJson(),
    };
  }

  // Factory constructor to create a Reservation object from JSON
  factory Reservation.fromJSON(Map<String, dynamic> json) {
    return Reservation(
      userId: json['userId'],
      guestInfo: GuestInfo.fromJSON(json['guestInfo']),
      hotelInfo: HotelInfo.fromJSON(json['hotelInfo']),
      couponCode: json['couponCode'],
      payment: Payment.fromJson(json['payment']),
    );
  }
}

class GuestInfo {
  String id;
  String name;
  String email;
  String phoneNumber;
  DateTime checkIn;
  DateTime checkOut;
  People people;

  GuestInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.checkIn,
    required this.checkOut,
    required this.people,
  });

  // Method to convert GuestInfo object to JSON
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'people': people.toJSON(),
    };
  }

  // Factory constructor to create a GuestInfo object from JSON
  factory GuestInfo.fromJSON(Map<String, dynamic> json) {
    return GuestInfo(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      // Convert Timestamp to DateTime
      checkIn: (json['checkIn'] as Timestamp).toDate(),
      checkOut: (json['checkOut'] as Timestamp).toDate(),
      people: People.fromJSON(json['people']),
    );
  }
}


class People {
  int adults;
  int children;
  int infants;

  People({
    required this.adults,
    required this.children,
    required this.infants,
  });

  // Method to convert People object to JSON
  Map<String, dynamic> toJSON() {
    return {
      'adults': adults,
      'children': children,
      'infants': infants,
    };
  }

  // Factory constructor to create a People object from JSON
  factory People.fromJSON(Map<String, dynamic> json) {
    return People(
      adults: json['adults'],
      children: json['children'],
      infants: json['infants'],
    );
  }
}

class HotelInfo {
  String hotelId;
  String offerType;
  int nights;
  int rooms;
  int perNightCharges;

  HotelInfo({
    required this.hotelId,
    required this.offerType,
    required this.nights,
    required this.rooms,
    required this.perNightCharges,
  });

  // Method to convert HotelInfo object to JSON
  Map<String, dynamic> toJSON() {
    return {
      'hotelId': hotelId,
      'offerType': offerType,
      'nights': nights,
      'rooms': rooms,
      'perNightCharges': perNightCharges,
    };
  }

  // Factory constructor to create a HotelInfo object from JSON
  factory HotelInfo.fromJSON(Map<String, dynamic> json) {
    return HotelInfo(
      hotelId: json['hotelId'],
      offerType: json['offerType'],
      nights: json['nights'],
      rooms: json['rooms'],
      perNightCharges: json['perNightCharges'],
    );
  }
}

class Payment {
  String payVia;
  int amount;
  bool isPay;
  DateTime payDate;

  Payment({
    required this.payVia,
    required this.amount,
    required this.isPay,
    required this.payDate,
  });

  // Method to convert Payment object to JSON
  Map<String, dynamic> toJson() {
    return {
      'payVia': payVia,
      'amount': amount,
      'isPay': isPay,
      'payDate': payDate.toIso8601String(), // Convert DateTime to ISO 8601 string format
    };
  }

  // Factory constructor to create a Payment object from JSON
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      payVia: json['payVia'],
      amount: json['amount'],
      isPay: json['isPay'],
      payDate: DateTime.parse(json['payDate']), // Convert ISO 8601 string back to DateTime
    );
  }
}
