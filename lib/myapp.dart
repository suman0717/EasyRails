import 'dart:convert';
import 'package:easy_rails/constants.dart';
import 'package:easy_rails/screens/XDMenu.dart';
import 'package:easy_rails/screens/XDSignIn.dart';
import 'package:easy_rails/size_config.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _waiting = false;
  bool _isUserserExists = true;
@override
  void initState() {
    setState(() {
      _waiting = true;
    });
    CheckUserAlreadyExists().whenComplete(() {
      setState(() {
        _waiting = false;
      });
    }).catchError((error, stackTrace){
      setState(() {
        _waiting = false;
      });
      print(error);
    });
    super.initState();
  }

  //THis Function will check if the user is alreaddy signed in into the app or not
  Future<void> CheckUserAlreadyExists() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _isUserserExists = sharedPreferences.containsKey('userDataJson') == true? await GetUserDetailsFromSharedPreference():false;
  }

  Future<bool> GetUserDetailsFromSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(jsonDecode(sharedPreferences.get('userDataJson'))['UserName']!=null){
      loggedinUserName = jsonDecode(sharedPreferences.get('userDataJson'))['UserName'];
      loggedinUserPassword = jsonDecode(sharedPreferences.get('userDataJson'))['Decrypted_Password'];
      loggedinUserID = jsonDecode(sharedPreferences.get('userDataJson'))['loggedinUserID'];
      loggedinUserFName = jsonDecode(sharedPreferences.get('userDataJson'))['First_Name'];
      loggedinUserSName = jsonDecode(sharedPreferences.get('userDataJson'))['Surname'];
      loggedinUserContractor = jsonDecode(sharedPreferences.get('userDataJson'))['ContractorBuinessName'];
      // aRTCLatestBatch = jsonDecode(sharedPreferences.get('userDataJson'))['ARTCLatestBatch'];
      aRTCLatestBatch = sharedPreferences.getString('aRTCLatestBatch');
      // aRTCLatestBatch is coming directly from SharedPreference because we are saving latest data everytime we create new ARTC record,
      // and we are not fetching latest arts everytime.
      KActiveRailOperator = jsonDecode(sharedPreferences.get('userDataJson'))['Weld_Return'];
      kActiveLicenseNumber = jsonDecode(sharedPreferences.get('userDataJson'))['ActiveLicenseNumber'];
      signature = jsonDecode(sharedPreferences.get('userDataJson'))['Signature'];
      signature_Initials = jsonDecode(sharedPreferences.get('userDataJson'))['Signature_Initials_Plain'];
      country = jsonDecode(sharedPreferences.get('userDataJson'))['Country'];
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _waiting,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return SplashScreen(
                seconds: 5,
                image: Image.asset('images/erwhite.png',width: 33.14 * SizeConfig.widthMultiplier,
                    height: 19.78 * SizeConfig.heightMultiplier),
                gradientBackground: LinearGradient(
                  begin: Alignment(-1.43, -1.02),
                  end: Alignment(1.17, 1.0),
                  colors: [
                    const Color(0xff5eb533),
                    const Color(0xff097445),
                    const Color(0xff157079),
                    const Color(0xff02414d),
                  ],
                  stops: [0.0, 0.391, 0.712, 1.0],
                ),
                loaderColor: Color(0xff5eb533),
                photoSize: 150.0,
                navigateAfterSeconds: _isUserserExists==true?XDMenu():XDSignIn(),
              );
            },
          );
        },
      ),
    );
  }
}

