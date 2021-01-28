import 'dart:convert';
import 'dart:io';
import 'package:easy_rails/constants.dart';
import 'package:easy_rails/size_config.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

List <String> userList=[];
SharedPreferences sharedPreferences;

class TestBo extends StatefulWidget {
  @override
  _TestBoState createState() => _TestBoState();
}

class _TestBoState extends State<TestBo> {
  bool _iswaiting = false;
  String _tempFirstname;
  String _tempSurname;
  String _tempEmailAddress;
  File _image;
  File localImage;

  @override
  void initState() {
    setState(() {
      _iswaiting=true;
    });

    GetUser().whenComplete(() {
      setState(() {
        _iswaiting=false;
        print('success');
      });
    }).catchError((error, StackTrace){
      setState(() {
        _iswaiting=false;
        print(error);
      });
    });
    super.initState();
  }

  Future<bool> GetUser() async {
    sharedPreferences =await SharedPreferences.getInstance();
    sharedPreferences.clear();
    for(int i=0;i<10;i++){
      print(i);
      UserDetails user = UserDetails(firstName: '$i suman',surname: '$i Chandan',emailAddress: '$i Suman@gmail.com');
      var json1 = jsonEncode(user.tojson());
      userList.add(json1);
    }
    sharedPreferences.setStringList('shareduserlist', userList);
    print(sharedPreferences.get('shareduserlist'));
    return true;
  }

  void chooseOptionToTakeImage() {
    showDialog(barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 5.0,
          title: Text(
            'Choose Option',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 3.0 * SizeConfig.heightMultiplier,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RaisedButton(child: Text('Open Storage')
                    ,onPressed: (){
                  Navigator.pop(context);
                      getImageStorage();
                      // getImageCamera();
                    }),
                SizedBox(
                  height: 1 * SizeConfig.heightMultiplier,
                ),
                RaisedButton(child: Text('Open Camera')
                    ,onPressed: (){
                      Navigator.pop(context);
                      getImageCamera();
                    }),


              ],
            ),
          ),
        );
      },
    );
  }

  Future getImageCamera() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    print(appDocPath);

    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;

    });
    var fileName = path.basename(_image.path); // This will give the name of the image with extension
    print(fileName);
    localImage = await image.copy('$appDocPath/$fileName');
    String _encodedImage = base64Encode(_image.readAsBytesSync());

  }

  Future getImageStorage() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    print(appDocPath);

    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      localImage = image;
    });
    var fileName = path.basename(image.path); // This will give the name of the image with extension
    print(fileName);
    print('path=$appDocPath/$fileName');
    localImage = await image.copy('$appDocPath/$fileName');
    String _encodedImage = base64Encode(_image.readAsBytesSync());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(inAsyncCall: _iswaiting,
          child: SingleChildScrollView(
            child: Form(
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: (String value){
                      _tempFirstname=value;
                    },
                  ),
                  TextField(
                    onChanged: (String value){
                      _tempSurname=value;
                    },
                  ),
                  TextField(
                    onChanged: (String value){
                      _tempEmailAddress=value;
                    },
                  ),
            Container(width: 67.85 * SizeConfig.widthMultiplier,height: 60 * SizeConfig.heightMultiplier,
              child: Center(
                // Center is a layout widget. It takes a single child and positions it
                // in the middle of the parent.
                child: Column(
                  children: [
                    _image == null ? Text('No image selected.') : Image.file(_image),
                    localImage == null ? Text('No image selected.') : Image.file(localImage),
                  ],
                )
              ),
            ),
                  RaisedButton(onPressed: (){print(userList);},child: Text('userList'),),
            RaisedButton(onPressed: (){Syncdata();},child: Text('Sync'),),

                  RaisedButton(child: Text('Save in Local')
                  ,onPressed: (){
                    UserDetails user = UserDetails(firstName: _tempFirstname,surname: _tempSurname,emailAddress: _tempEmailAddress);
                    var jsonString = jsonEncode(user.tojson());
                    print(jsonString);
                    userList.add(jsonString);
                    sharedPreferences.setStringList('shareduserlist', userList);
                    print(sharedPreferences.getStringList('shareduserlist'));
                  }),
                  RaisedButton(child: Text('Upload Image')
                      ,onPressed: (){
                        chooseOptionToTakeImage();
                      })

                ],
              ),
            ),
          ),),
    );
  }

  }

class UserDetails{
  String firstName;
  String surname;
  String emailAddress;

  UserDetails({this.firstName,this.surname,this.emailAddress});
  //this map will convert object in json
  Map<String,dynamic> tojson() => {
    'firstName':firstName,
    'surname':surname,
    'emailAddress':emailAddress,
  };

  //this funciton will convert json to object
  UserDetails.fromJson(Map<String,dynamic> json)
  : firstName = json['firstName'],
  surname = json['surname'],
  emailAddress = json['emailAddress'];
}



// class TestBo extends StatefulWidget {
//   TestBo({Key key, this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _TestBoState createState() => _TestBoState();
// }
//
// class _TestBoState extends State<TestBo> {
//   Future<void> _launched;
//   String _phone = '';
//
//   Future<void> _launchInBrowser(String url) async {
//     if (await canLaunch(url)) {
//       await launch(
//         url,
//         forceSafariVC: false,
//         forceWebView: false,
//         // headers: <String, String>{'my_header_key': 'my_header_value'},
//       );
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   Future<void> _launchInWebViewOrVC(String url) async {
//     if (await canLaunch(url)) {
//       await launch(
//         url,
//         enableDomStorage: true,
//         forceSafariVC: true,
//         forceWebView: true,
//         headers: <String, String>{'my_header_key': 'my_header_value'},
//       );
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   Future<void> _launchInWebViewWithJavaScript(String url) async {
//     if (await canLaunch(url)) {
//       await launch(
//         url,
//         forceSafariVC: true,
//         forceWebView: true,
//         enableJavaScript: true,
//       );
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   Future<void> _launchInWebViewWithDomStorage(String url) async {
//     if (await canLaunch(url)) {
//       await launch(
//         url,
//         forceSafariVC: true,
//         forceWebView: true,
//         enableDomStorage: true,
//       );
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   Future<void> _launchUniversalLinkIos(String url) async {
//     if (await canLaunch(url)) {
//       final bool nativeAppLaunchSucceeded = await launch(
//         url,
//         forceSafariVC: false,
//         universalLinksOnly: true,
//       );
//       if (!nativeAppLaunchSucceeded) {
//         await launch(
//           url,
//           forceSafariVC: true,
//         );
//       }
//     }
//   }
//
//   Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
//     if (snapshot.hasError) {
//       return Text('Error: ${snapshot.error}');
//     } else {
//       return const Text('');
//     }
//   }
//
//   Future<void> _makePhoneCall(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // const String toLaunch = 'https://radreviews.online/app/RAD/Terms.pdf';
//     const String toLaunch = 'https://pub.dev/packages/url_launcher/example/';
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Web Launcher'),
//       ),
//       body: ListView(
//         children: <Widget>[
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: TextField(
//                     onChanged: (String text) => _phone = text,
//                     decoration: const InputDecoration(
//                         hintText: 'Input the phone number to launch')),
//               ),
//               RaisedButton(
//                 onPressed: () => setState(() {
//                   _launched = _makePhoneCall('tel:$_phone');
//                 }),
//                 child: const Text('Make phone call'),
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(toLaunch),
//               ),
//               RaisedButton(
//                 onPressed: () => setState(() {
//                   _launched = _launchInBrowser(toLaunch);
//                 }),
//                 child: const Text('Launch in browser'),
//               ),
//               const Padding(padding: EdgeInsets.all(16.0)),
//               RaisedButton(
//                 onPressed: () => setState(() {
//                   _launched = _launchInWebViewOrVC(toLaunch);
//                 }),
//                 child: const Text('Launch in app'),
//               ),
//               RaisedButton(
//                 onPressed: () => setState(() {
//                   _launched = _launchInWebViewWithJavaScript(toLaunch);
//                 }),
//                 child: const Text('Launch in app(JavaScript ON)'),
//               ),
//               RaisedButton(
//                 onPressed: () => setState(() {
//                   _launched = _launchInWebViewWithDomStorage(toLaunch);
//                 }),
//                 child: const Text('Launch in app(DOM storage ON)'),
//               ),
//               const Padding(padding: EdgeInsets.all(16.0)),
//               RaisedButton(
//                 onPressed: () => setState(() {
//                   _launched = _launchUniversalLinkIos(toLaunch);
//                 }),
//                 child: const Text(
//                     'Launch a universal link in a native app, fallback to Safari.(Youtube)'),
//               ),
//               const Padding(padding: EdgeInsets.all(16.0)),
//               RaisedButton(
//                 onPressed: () => setState(() {
//                   _launched = _launchInWebViewOrVC(toLaunch);
//                   Timer(const Duration(seconds: 5), () {
//                     print('Closing WebView after 5 seconds...');
//                     closeWebView();
//                   });
//                 }),
//                 child: const Text('Launch in app + close after 5 seconds'),
//               ),
//               const Padding(padding: EdgeInsets.all(16.0)),
//               FutureBuilder<void>(future: _launched, builder: _launchStatus),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }



