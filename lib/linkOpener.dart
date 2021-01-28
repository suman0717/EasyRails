import 'package:url_launcher/url_launcher.dart';

class QuickLaunchLink {
  final String url;

  QuickLaunchLink({this.url});

  void hitLink(String urlString) async {
    //This funciton can make call, Send SMS, Send Email, open URL in Browser
    String url ='$urlString';
    if(await canLaunch(url)){
      await launch(url);

    }
    else{
      throw 'Could not launch $url';}
  }
}


