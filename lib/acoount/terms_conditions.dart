import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/constant_widgets/widget_ui_components.dart';

class TermsConditions extends ConsumerWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(text: "Terms and Conditions"),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(text: "Welcome to AI Travel!",isBold: true,fontSize: 16,),
              TextWidget(text: '''
              These terms and conditions outline the rules and regulations for the use of AI Travel's Website, located at .
          
          By accessing this website we assume you accept these terms and conditions. Do not continue to use AI Travel if you do not agree to take all of the terms and conditions stated on this page.
          
          The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: 
          
          "Client", "You" and "Your" refers to you, the person log on this website and compliant to the Company’s terms and conditions. "The Company", "Ourselves", "We", "Our" and "Us", refers to our Company. "Party", "Parties", or "Us", refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client’s needs in respect of provision of the Company’s stated services, in accordance with and subject to, prevailing law of Netherlands. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same. Our Terms and Conditions were created with the help of the Terms & Conditions Generator.
          
          Cookies
          We employ the use of cookies. By accessing AI Travel, you agreed to use cookies in agreement with the AI Travel's Privacy Policy.
          Most interactive websites use cookies to let us retrieve the user's details for each visit. Cookies are used by our website to enable the functionality of certain areas to make it easier for people visiting our website. Some of our affiliate/advertising partners may also use cookies.
          
          License
          Unless otherwise stated, AI Travel and/or its licensors own the intellectual property rights for all material on AI Travel. All intellectual property rights are reserved. You may access this from AI Travel for your own personal use subjected to restrictions set in these terms and conditions.
          
          You must not:
          Republish material from AI Travel
          Sell, rent or sub-license material from AI Travel
          Reproduce, duplicate or copy material from AI Travel
          Redistribute content from AI Travel
              
              ''',fontSize: 12,isJustify: true,)
            ],
          ),
        ),
      ),
    );
  }
}
