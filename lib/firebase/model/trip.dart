class TripModelClass {
  String destination;
  String partner;
  List<String> interestList;
  String? interestOptional;
  String budgetType;
  String specificBudget;
  RangeClass range;

  TripModelClass({
    required this.destination,
    required this.partner,
    required this.interestList,
    this.interestOptional,
    required this.budgetType,
    required this.specificBudget,
    required this.range,
  });
  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'partner': partner,
      'interestList': interestList,
      'interestOptional': interestOptional,
      'budgetType': budgetType,
      'specificBudget': specificBudget,
      'range': range.toJson(),
    };
  }

  factory TripModelClass.fromJson(Map<String, dynamic> json) {
    return TripModelClass(
      destination: json['destination'],
      partner: json['partner'],
      interestList: List<String>.from(json['interestList']),
      interestOptional: json['interestOptional'],
      budgetType: json['budgetType'],
      specificBudget: json['specificBudget'],
      range: RangeClass.fromJson(json['range']),
    );
  }
}

class RangeClass {
  DateTime checkIn;
  DateTime checkOut;

  RangeClass({
    required this.checkIn,
    required this.checkOut,
  });

  Map<String, dynamic> toJson() {
    return {
      'checkIn': checkIn.toIso8601String(),
      'checkOut': checkOut.toIso8601String(),
    };
  }

  factory RangeClass.fromJson(Map<String, dynamic> json) {
    return RangeClass(
      checkIn: DateTime.parse(json['checkIn']),
      checkOut: DateTime.parse(json['checkOut']),
    );
  }
}
