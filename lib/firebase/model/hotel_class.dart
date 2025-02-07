
class Hotel {
  String name;
  String id;
  String description;
  String location;
  String charges;
  double rating;
  List<String>? images;
  List<Reviews>? reviews;
  int reviewCount;

  Hotel({
    required this.name,
    required this.id,
    required this.description,
    required this.location,
    required this.charges,
    required this.rating,
     this.images,
     this.reviews,
    required this.reviewCount,
  });

  factory Hotel.fromFireStore(Map<String, dynamic> data) {
    return Hotel(
      name: data['hotelName'],
     id: data['id'],
      description: data['hotelDescription'],
      location: data['location'],
      charges: data['charges'],
      rating: data['rating'],
      images: data['images'] is Iterable ? List.from(data['images']):null,
      reviews: data['reviews'] is Iterable ? List.from(data['reviews'].map((review)=>Reviews.fromFireStore(review)).toList()):null,
      reviewCount: data['reviewCount']
    );
  }

  Map<String, dynamic> toFireStore() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['hotelName'] = name;
    data['id']=id;
    data['hotelDescription'] = description;
    data['location'] = location;
    data['charges'] = charges;
    data['rating'] = rating;
    data['images'] = images;
    data['reviews'] = reviews?.map((review) => review.toFireStore()).toList();
    data['reviewCount']=reviewCount;
    return data;
  }
}

// Reviews class
class Reviews {
  String? reviewedBy;
  String? review;
  String? id;
  double? rating;

  Reviews({
    this.reviewedBy,
    this.review,
    this.id,
    this.rating,
  });

  factory Reviews.fromFireStore(Map<String, dynamic> data) {
    return Reviews(
      reviewedBy: data["reviewedBy"],
      review: data['review'],
      id: data['id'],
      rating: data['rating'],
    );
  }

  Map<String, dynamic> toFireStore() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['reviewedBy'] = reviewedBy;
    data['review'] = review;
    data['id'] = id;
    data['rating'] = rating;
    return data;
  }
}

