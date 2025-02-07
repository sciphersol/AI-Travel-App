import 'package:flutter/material.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';
import 'hotel_details.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Top 10 European Christmas Markets"),
      ),
      body:  SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            lineWidget(),
            const ImageContainer(
              width: double.infinity,
                height: 300,
                isRadius: true,
                imageUrl: "assets/images/Rectangle29.png"
            ),
            const TextWidget(text: "John Andreas Silva",isBold: true,fontSize: 16,),
            const TextWidget(text: "January 27, 2024"),
            lineWidget(),
            const TextWidget(text: "Lorem ipsum dolor sit amet consectetur. Feugiat eget arcu sollicitudin congue pulvinar sociis pellentesque volutpat. Egestas sit enim adipiscing pellentesque diam eget et rhoncus. Elit bibendum eget quis euismod. Arcu nunc massa nunc a eget viverra pellentesque commodo. Neque condimentum curabitur enim eu dictum. Bibendum quisque sed et duis."),
            const ImageContainer(
                width: double.infinity,
                height: 200,
                isRadius: true,
                imageUrl: "assets/images/Rectangle29.png"
            ),
            const TextWidget(text: "Lorem ipsum dolor sit amet consectetur. Feugiat eget arcu sollicitudin congue pulvinar sociis pellentesque volutpat. Egestas sit enim adipiscing pellentesque diam eget et rhoncus. Elit bibendum eget quis euismod. Arcu nunc massa nunc a eget viverra pellentesque commodo. Neque condimentum curabitur enim eu dictum. Bibendum quisque sed et duis."),
            lineWidget(),
             Row(
               spacing: 5.0,
              children: [
                const TextWidget(text: "Share:",isBold: true,),
                Image.network("https://cdn.iconscout.com/icon/free/png-512/free-whatsapp-logo-icon-download-in-svg-png-gif-file-formats--social-media-communication-pack-logos-icons-1718516.png?f=webp&w=512",
                  height: 20,width: 20,
                ),
                const Icon(Icons.facebook,color: Colors.blue,),
               Image.network("https://cdn.iconscout.com/icon/free/png-512/free-instagram-logo-icon-download-in-svg-png-gif-file-formats--social-media-pack-logos-icons-1583142.png?f=webp&w=512",
               height: 20,width: 20,
               )
              ],
            )
          ],
        ),
        ),
      ),
    );
  }
}
