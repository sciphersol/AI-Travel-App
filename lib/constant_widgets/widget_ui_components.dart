import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Home_screen/hotel_details.dart';
import 'app_color.dart';

///Button widget
class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {
        super.key,
      this.isLoading = false,
      this.title = '',
      this.icon,
      this.widget,
      this.fontSize = 14.0,
      this.radius = 30.0,
      this.width = double.infinity,
      this.height = 60.0,
      this.color = MyAppColor.buttonColor,
      this.titleColor = Colors.white,
      required this.onPress,
        this.buttonId,
      });
  final String? buttonId;
  final bool isLoading;
  final String title;
  final Icon? icon;
  final Widget? widget;
  final double fontSize;
  final double height;
  final double width;
  final Color titleColor;
  final double radius;
  final Color color;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed:() {
       onPress();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius), color: color),
        child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: MyAppColor.buttonColor,
                  )
                : Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      if (icon != null) ...[
                        icon!// Add space between icon and text
                      ],
                      if (widget != null) ...[
                        widget!, // Add space between icon and text
                      ],
                      TextWidget(
                        text: title,
                        color: titleColor,
                        fontSize: fontSize,
                        isBold: true,
                      ),
                    ],
                  )),
      ),
    );
  }
}

///Text Widget

class TextWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color color;
  final bool isBold;
  final bool isJustify;
final int? maxLines;
  const TextWidget({
    super.key,
    this.isJustify=false,
    required this.text,
    this.maxLines=300,
    this.fontSize,
    this.color = Colors.black,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.clip,
      softWrap: true,
      maxLines:maxLines,
      textAlign: isJustify?TextAlign.justify:null,
      style: TextStyle(

        color: color,
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}

///ListTile Widget

class ListTileWidget extends StatelessWidget {
  final Widget? leadingWidget;
  final double leadingIconSize;
  final IconData? leadingIcon;
  final Color leadingIconColor;
  final double trailingIconSize;
  final IconData? trailingIcon;
  final Color trailingIconColor;
  final Color subTitleColor;
  final Color titleColor;
  final String title;
  final String? subtitle;

  const ListTileWidget({
    this.leadingWidget,
    this.leadingIconSize = 24.0,
    this.leadingIcon,
    this.leadingIconColor = Colors.black,
    this.trailingIconSize = 24.0,
    this.trailingIcon,
    this.trailingIconColor = Colors.black,
    required this.title,
    this.titleColor = Colors.black,
    this.subtitle,
    this.subTitleColor = Colors.black,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      horizontalTitleGap: 10.0,
      minVerticalPadding: 8.0,
      leading: leadingIcon != null
          ? Icon(
              leadingIcon,
              size: leadingIconSize,
              color: leadingIconColor,
            )
          : leadingWidget,
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
        ),
      ),
      subtitle: Text(
        subtitle.toString(),
        style: TextStyle(color: subTitleColor),
      ),
      trailing: Icon(
        trailingIcon,
        size: trailingIconSize,
        color: trailingIconColor,
      ),
    );
  }
}

/// 5) Phone Number Text Field
final countryCodeProvider=StateProvider<Country>((ref)=>Country(
  phoneCode: "92",
  countryCode: "PK",
  e164Sc: 0,
  geographic: true,
  level: 1,
  name: "Pakistan",
  example: "Pakistan",
  displayName: "Pakistan",
  displayNameNoCountryCode: "PK",
  e164Key: "",
));

class PhoneTextField extends ConsumerWidget {
   const PhoneTextField(
      {super.key,
      required this.controller,
      required this.onChanged,
      this.isBorder = false,
      this.radius = 10.0,
      this.fillColor = Colors.white});

  final TextEditingController controller;
  final Function(String) onChanged;
  final bool isBorder;
  final double radius;
  final Color fillColor;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: isBorder
              ? const BorderSide(
                  color: Colors.black,
                  style: BorderStyle.solid,
                )
              : BorderSide.none,
          borderRadius: BorderRadius.circular(radius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:isBorder
              ? const BorderSide(
                  color: Colors.black,
                  style: BorderStyle.solid,
                )
              : BorderSide
                  .none, // Remove the underline when the field is enabled
          borderRadius: BorderRadius.circular(radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: isBorder
              ? const BorderSide(
                  color: Colors.black,
                  style: BorderStyle.solid,
                )
              : BorderSide.none,
          borderRadius: BorderRadius.circular(radius),
        ),
        hintText: "Enter phone number",
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: fillColor,
        prefixIcon: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.2, // Adjusted width
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize:
                MainAxisSize.max, // Ensures Row takes only the necessary space
            children: [
              TextWidget(
                text: "+${ref.watch(countryCodeProvider).phoneCode}",
                isBold: true, // Optionally bold for better readability
              ),
              InkWell(
                onTap: () {
                  showCountryPicker(
                      context: context,
                      onSelect: (value) {
                        ref.read(countryCodeProvider.notifier).state=value;
                      },
                      countryListTheme: const CountryListThemeData(
                          margin: EdgeInsets.all(10.0),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          bottomSheetHeight: 400));
                },
                child: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///Text Field Widget
class TextFieldWidget extends StatelessWidget {
  // Constructor
  const TextFieldWidget({
    super.key,
    required this.controller,
    this.leadingIcon,
    this.trailingIcon,
    this.fillColor = MyAppColor.textFieldColor,
    this.textInputType = TextInputType.text,
    this.secure = false,
    this.radius = 10,
    this.hintText = " ",
    this.isBorder = false,
    this.labelText,
    this.onChanged,
    this.trailingFn
  });

  final bool secure;
  final String? labelText;
  final bool isBorder;
  final String hintText;
  final double radius;
  final TextInputType textInputType;
  final Color fillColor;
  final TextEditingController controller;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final void Function(String)? onChanged;
  final Function? trailingFn;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      obscureText: secure,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderSide: isBorder
              ? const BorderSide(
                  color: Colors.grey,
                )
              : BorderSide.none,
          borderRadius: BorderRadius.circular(radius),
        ),

        filled: true,
        fillColor: fillColor,
        prefixIcon: leadingIcon == null
            ? null
            : Icon(leadingIcon, color: Colors.black54, size: 25.0),
        suffixIcon: trailingIcon != null
            ? GestureDetector(
          onTap: () {
            if (trailingFn != null) {
              trailingFn!();  // Invoke the function when the trailing icon is tapped
            }
          },
          child: Icon(trailingIcon, color: Colors.black38, size: 25.0),
        )
            : null,
        hintText:hintText,
      ),

    );
  }
}

///image container
class ImageContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final String imageUrl;
  final Widget? child;
  final bool isRadius;
  final double radius;

  const ImageContainer(
      {super.key,
      this.height,
      required this.isRadius,
      this.child,
        this.radius=10,
      this.width,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: isRadius ? BorderRadius.circular(radius) : null,
          image:
              DecorationImage(fit: BoxFit.cover, image: AssetImage(imageUrl))),
      child: child,
    );
  }
}

class RatingAndFavorite extends StatelessWidget {
  const RatingAndFavorite({super.key,
    required this.rating,
    this.isTrue=false,
    required this.function});
  final bool isTrue;
  final double rating;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){function();},
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xffc1baba).withOpacity(0.8)),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  TextWidget(
                    text: rating.toString(),
                    isBold: true,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color:  const Color(0xffb9b9b9).withOpacity(0.9)),
              child: Icon(
                isTrue?Icons.favorite:Icons.favorite_border,
                color: isTrue?Colors.red:Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OutLinedButton extends StatelessWidget {
  const OutLinedButton(
      {super.key,
      this.leadingIcon,
      required this.title,
      this.index,
      this.pageIndex,
      this.child,
      required this.onPressed});

  final IconData? leadingIcon;
  final String title;
  final int? index;
  final int? pageIndex;
  final Widget? child;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        onPressed();
      },
      icon: leadingIcon != null
          ? Icon(leadingIcon,
              color: index == pageIndex ? Colors.blue : Colors.black)
          : null, // Leading icon
      label: Text(
        title,
        style:
            TextStyle(color: index == pageIndex ? Colors.blue : Colors.black),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(
            color: index == pageIndex
                ? Colors.blue
                : Colors.black), // Border color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(45), // Rounded corners
        ),
      ),
    );
  }
}

class ThreeWidgetContainer extends StatelessWidget {
  final double? imageHeight;
  final double? imageWidth;
  final String imageUrl;
  final Widget? child;
  final bool isRadius;
  final String? title;
  final String? subtitle;
 final bool isLine;
 final bool isTitle;
  final Widget? widget;
  final Function onTap;

  const ThreeWidgetContainer(
      {super.key,
        this.isLine=false,
        this.isTitle=true,
        this.widget,
         required this.onTap,
      this.imageHeight,
        this.imageWidth,
      required this.isRadius,
      this.child,
      required this.imageUrl,
       this.title,
       this.subtitle,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Column(
        spacing: 10.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
         Container(
            height: imageHeight,
            width: imageWidth,
            decoration: BoxDecoration(
                borderRadius:  BorderRadius.circular(15),
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(imageUrl))),
            child: child,
          ),
         Flexible(
           child: TextWidget(
             text: title.toString(),
             isBold: true,
             fontSize: 15,
           ),
         ),
       widget??TextWidget(
           text: subtitle.toString(),
           fontSize: 12,

         ),
          if (isLine) lineWidget(),
        ],
      ),
    );
  }
}
class GridViewCard extends StatelessWidget {
  final String imageUrl;
  final Widget? child;
  final String? title;
  final String? subtitle;
  final Function onTap;
  const GridViewCard(
      {super.key,
        required this.onTap,
        this.child,
        required this.imageUrl,
        this.title,
        this.subtitle,
       });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Column(
        spacing: 10.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
       Container(
         height: 160,
         decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(15),
             image: DecorationImage(
                 fit: BoxFit.cover, image: AssetImage(imageUrl))),
         child: child,
       ),
            Expanded(
              child: TextWidget(
                maxLines: 2,
                text: title.toString(),
                isBold: true,
                fontSize: 15,
              ),
            ),
          TextWidget(
            text: subtitle.toString(),
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}


///calendar widget

class CalendarWidget extends StatelessWidget {
  final DateTime initialFocusedDay;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final  Function(DateTime?, DateTime?, DateTime)? onRangeSelected;
  final void Function(DateTime?, DateTime?)? onDaySelected;


  const CalendarWidget({super.key,
    required this.initialFocusedDay,
    this.rangeStart,
    this.rangeEnd,
     this.onRangeSelected,
    this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekendStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        weekdayStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      calendarStyle: const CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Colors.transparent,
        ),
        selectedTextStyle: TextStyle(color: Colors.black),
        withinRangeTextStyle: TextStyle(color: Colors.white),
        rangeHighlightColor: MyAppColor.buttonColor,
        rangeStartDecoration: BoxDecoration(
          color: MyAppColor.buttonColor,
          shape: BoxShape.circle,
        ),
        rangeEndDecoration: BoxDecoration(
          color: MyAppColor.buttonColor,
          shape: BoxShape.circle,
        ),
      ),
      rangeSelectionMode: RangeSelectionMode.toggledOn,
      rangeStartDay: rangeStart,
      rangeEndDay: rangeEnd,
      onRangeSelected: onRangeSelected,
      headerStyle: const HeaderStyle(
        titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        formatButtonVisible: false,
        titleCentered: true,
      ),
      rowHeight: 40,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2040, 3, 14),
      focusedDay: initialFocusedDay,
      onDaySelected: onDaySelected,// add this proper
      selectedDayPredicate: (day) => isSameDay(day, initialFocusedDay),
    );
  }
}

class AlertDialogWidget extends StatelessWidget {
  final String message;
  final String onCancelName;
  final String onDeleteName;
  final Function onCancel;
  final Function onDelete;

  const AlertDialogWidget({
    required this.message,
    required this.onCancelName,
    required this.onDeleteName,
    required this.onCancel,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message,style: const TextStyle(fontSize: 20),),
      actions: [
        Row(
          spacing: 20,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ButtonWidget(
                onPress: onCancel,
              title: onCancelName,
                color: Colors.black12,
                titleColor: Colors.black,
              ),
            ),
            Expanded(
              child: ButtonWidget(

                onPress: onDelete,
                title: onDeleteName,
                color: const Color(0xffbf3a3a),
              ),
            ),
        ],)
      ],
    );
  }
}


