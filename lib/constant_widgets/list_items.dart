class InformationArticles{
  String  imageUrl;
  String text;
  InformationArticles({
    required this.imageUrl,
    required this.text
  });
  static List<InformationArticles> informationArticlesList=[
    InformationArticles(
        imageUrl:"assets/images/Rectangle29.png",
        text: '7 reasons to holiday in Costa Adeje, Tenerife, Canary Islands, Spain'
    ),
    InformationArticles(
        imageUrl:"assets/images/yellowCard.png",
        text: 'New holidays in Costa Adeje, Spain'
    ),
    InformationArticles(
        imageUrl:"assets/images/Rectangle29.png",
        text: 'Spend your holiday in Costa Adeje, Tenerife,'
    ),
    InformationArticles(
        imageUrl:"assets/images/yellowCard.png",
        text: 'Family restaurant in Costa Adeje, Tenerife, C'
    ),

  ];
}

/// list item for onBoarding page
class OnBoardingItems {
  String imageUrl;
  String title;
  String subtitle;

  OnBoardingItems({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  static List<OnBoardingItems> items = [
    OnBoardingItems(
      imageUrl: "assets/images/image1.png",
      title: "Your Passport to Adventure!",
      subtitle:
      "Welcome aboard! We're thrilled to have you join this app, your go-to travel companion. Get ready to explore the world like never before. Let the adventure begin!",
    ),
    OnBoardingItems(
      imageUrl: "assets/images/image2.png",
      title: "Personalized Travel Experience",
      subtitle:
      "Tell us about your travel style and preferences, and we'll tailor recommendations just for you. Whether you're a culture connoisseur, a thrill-seeker, or a relaxation enthusiast!",
    ),
    OnBoardingItems(
      imageUrl: "assets/images/image3.png",
      title: "Your Passport to Adventure!",
      subtitle:
      "Navigate through our intuitive features to effortlessly plan your dream getaway. From real-time flight updates to curated itineraries and exclusive deals, we've got all your travel needs covered",
    ),
    OnBoardingItems(
      imageUrl: "assets/images/image4.png",
      title: "Get ready for a world of discovery with us. Bon voyage! ",
      subtitle: "To get the most joy of us. You will need to allow the following:",
    ),
  ];
}