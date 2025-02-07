import 'package:app_settings/app_settings.dart';

class NotificationService{
  Future permission() async{
   try{
     AppSettings.openAppSettings(type:AppSettingsType.notification);
     AppSettings.openAppSettings(type: AppSettingsType.location);
   }catch (e){
     print(e.toString());
   }
  }

}


