class WishListModelClass {

  List<String> listOfHotelIds;
  String tripName;

  WishListModelClass({

    required this.listOfHotelIds,
    required this.tripName,
  });

  Map<String, dynamic> toJSON() {
    return {
      'listOfHotelIds': listOfHotelIds,
      'tripName': tripName,
    };
  }

  factory WishListModelClass.fromJSON(Map<String, dynamic> json) {
    return WishListModelClass(
      listOfHotelIds:List.from(json['listOfHotelIds']),// Convert list of hotel IDs
      tripName: json['tripName'],
    );
  }
}
