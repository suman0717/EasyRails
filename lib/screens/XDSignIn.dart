import 'dart:math';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:easy_rails/constants.dart';
import 'package:easy_rails/linkOpener.dart';
import 'package:easy_rails/screens/XDMenu.dart';
import 'package:easy_rails/screens/otp_forgotPassword.dart';
import 'package:easy_rails/size_config.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class XDSignIn extends StatefulWidget {
  @override
  _XDSignInState createState() => _XDSignInState();
}

class _XDSignInState extends State<XDSignIn> {
  String _username;
  String _password;
  String _serverUsername;
  String _serverPassword;
  bool _waiting = false;
  String message = '';
  String forgotEmailAddress;

  GetUserLogin(String urlString) async {
    print(urlString);
    print('inside login process');
    http.Response response = await http.get(urlString);
    try {
      String data = response.body;
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setInt('ID', 35124);
      sharedPreferences.setString('userDataJson', data);
      _serverUsername = jsonDecode(data)['UserName'];
      _serverPassword = jsonDecode(data)['Decrypted_Password'];
      loggedinUserName = jsonDecode(data)['UserName'];
      loggedinUserPassword = jsonDecode(data)['Decrypted_Password'];
      loggedinUserID = jsonDecode(data)['loggedinUserID'];
      loggedinUserFName = jsonDecode(data)['First_Name'];
      loggedinUserSName = jsonDecode(data)['Surname'];
      aRTCLatestBatch = jsonDecode(data)['ARTCLatestBatch'];
      loggedinUserContractor = jsonDecode(data)['ContractorBuinessName'];
      KActiveRailOperator = jsonDecode(data)['Weld_Return'];
      kActiveLicenseNumber = jsonDecode(data)['ActiveLicenseNumber'];
      signature = jsonDecode(data)['Signature'];
      signature_Initials = jsonDecode(data)['Signature_Initials_Plain'];
      country = jsonDecode(data)['Country'] !=null?jsonDecode(data)['Country']:'Australia';
      sharedPreferences.setStringList('unSyncWeldReturn', []);
      sharedPreferences.setStringList('unSyncArtcWeldReturn', []);
      sharedPreferences.setStringList('unSyncQRWeldReturn', []);
      sharedPreferences.setStringList('artcWeldReasonList', []);
      sharedPreferences.setStringList('artcWeldTypeList', []);
      sharedPreferences.setStringList('listUpdateWeldReturnUnSynced', []);
      sharedPreferences.setStringList('listUpdateARTCWeldReturnUnsynced',[]);
      sharedPreferences.setStringList('listUpdateQRWeldReturnUnSynced', []);
      sharedPreferences.setStringList('qrRoadList', []);
      sharedPreferences.setStringList('qrTrackList', []);
      sharedPreferences.setStringList('qrWeldReasonList', []);
      sharedPreferences.setStringList('qrWeldTypeList', []);
      sharedPreferences.setStringList('qrHeating_TrolleyList', []);
      sharedPreferences.setString('aRTCLatestBatch', jsonDecode(data)['ARTCLatestBatch']);
      print('printing avlues from constant');
      print(loggedinUserName);
      print(loggedinUserPassword);
      print(loggedinUserID);
      print(loggedinUserFName);
      print(loggedinUserSName);
      print(aRTCLatestBatch);
      print(loggedinUserContractor);
      print(KActiveRailOperator);
      print(signature);
      print(signature_Initials);
      print(country);
      print('printing Finished from constant');
      await GetGenericDataForAurizon();
      await GetGenericDataForARTCWeldreturn();
      await GetGenericDataQR();
    } catch (e) {
      await Flushbar(
        titleText: Text(
          'Error',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 2.0 * SizeConfig.heightMultiplier,
            color: const Color(0xffffffff),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.left,
        ),
        messageText: Text(
          'Something went wrong.',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 1.3 * SizeConfig.heightMultiplier,
            color: const Color(0xffffffff),
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.left,
        ),
        padding: EdgeInsets.symmetric(
            vertical: 12.0, horizontal: 5.1 * SizeConfig.widthMultiplier),
        icon: Icon(
          Icons.clear,
          size: 3.94 * SizeConfig.heightMultiplier,
          color: Colors.white,
        ),
        duration: Duration(seconds: 2),
        flushbarPosition: FlushbarPosition.TOP,
        borderColor: Colors.transparent,
        shouldIconPulse: false,
        maxWidth: 91.8 * SizeConfig.widthMultiplier,
        boxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1 * SizeConfig.heightMultiplier,
            blurRadius: 2 * SizeConfig.heightMultiplier,
            offset: Offset(0, 10), // changes position of shadow
          ),
        ],
        backgroundColor: kShadeColor1,
      ).show(context);
      print(e);
    }
  }
  void ShowForgotPassword() {
    bool _localWaiting = false;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
          return ModalProgressHUD(inAsyncCall: _localWaiting,
              child: AlertDialog(
            elevation: 5.0,
            title: Text(
              'Password Recovery',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 18,
                color: const Color(0xff363636),
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 68.2 * SizeConfig.widthMultiplier,
                    height: 5.65 * SizeConfig.heightMultiplier,
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        forgotEmailAddress = value;
                      },
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 1.9 * SizeConfig.heightMultiplier,
                      ),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Email Address',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 1.5 * SizeConfig.heightMultiplier,
                            horizontal: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: 68.2 * SizeConfig.widthMultiplier,
                    height: 5.65 * SizeConfig.heightMultiplier,
                    child: RaisedButton(
                      onPressed: () async {
                        FocusManager.instance.primaryFocus.unfocus();
                        int _otp;
                        print('clicked');
                        setState(() {
                          _localWaiting=true;
                        });
                        if (forgotEmailAddress != null) {
                          // Flushbar(
                          //   titleText: Text(
                          //     'Checking User. . . ',
                          //     style: TextStyle(
                          //       fontFamily: 'Manrope',
                          //       fontSize: 2.0 * SizeConfig.heightMultiplier,
                          //       color: const Color(0xffffffff),
                          //       fontWeight: FontWeight.w600,
                          //     ),
                          //     textAlign: TextAlign.left,
                          //   ),
                          //   messageText: Text(
                          //     'Email will be sent once we validate email address',
                          //     style: TextStyle(
                          //       fontFamily: 'Manrope',
                          //       fontSize: 1.3 * SizeConfig.heightMultiplier,
                          //       color: const Color(0xffffffff),
                          //       fontWeight: FontWeight.w300,
                          //     ),
                          //     textAlign: TextAlign.left,
                          //   ),
                          //   padding: EdgeInsets.symmetric(
                          //       vertical: 12.0, horizontal: 5.1 * SizeConfig.widthMultiplier),
                          //   icon: Icon(
                          //     Icons.priority_high,
                          //     size: 3.94 * SizeConfig.heightMultiplier,
                          //     color: Colors.white,
                          //   ),
                          //   duration: Duration(seconds: 3),
                          //   flushbarPosition: FlushbarPosition.TOP,
                          //   borderColor: Colors.transparent,
                          //   shouldIconPulse: false,
                          //   maxWidth: 91.8 * SizeConfig.widthMultiplier,
                          //   boxShadows: [
                          //     BoxShadow(
                          //       color: Colors.black.withOpacity(0.3),
                          //       spreadRadius: 1 * SizeConfig.heightMultiplier,
                          //       blurRadius: 2 * SizeConfig.heightMultiplier,
                          //       offset: Offset(0, 10), // changesvalue position of shadow
                          //     ),
                          //   ],
                          //   backgroundColor: kShadeColor1,
                          // ).show(context);
                          Random _random = Random();
                          _otp = _random.nextInt(999999);
                          print(_otp);
                          if (_otp < 100000) {
                            _otp = _otp + 100000;
                          }

                          http.Response _response = await http.get(kBaseURL +
                              'REST/EasyRails/App_ForgotPWD?EmailAddress=$forgotEmailAddress&OTP=$_otp');
                          print(kBaseURL +
                              'REST/EasyRails/App_ForgotPWD?EmailAddress=$forgotEmailAddress&OTP=${_otp.toString()}');
                          print(_response.body);
                          var _responseBody=_response.body;
                          String _errormessage = jsonDecode(_responseBody)['Error'];
                          print(_errormessage);
                          if(_errormessage !='No Error'){
                            setState(() {
                              _localWaiting=false;
                            });
                            // Flushbar(
                            //   titleText: Text(
                            //     'User does not exists',
                            //     style: TextStyle(
                            //       fontFamily: 'Manrope',
                            //       fontSize: 2.0 * SizeConfig.heightMultiplier,
                            //       color: const Color(0xffffffff),
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //     textAlign: TextAlign.left,
                            //   ),
                            //   messageText: Text(
                            //     'User with email address does not exist in our system',
                            //     style: TextStyle(
                            //       fontFamily: 'Manrope',
                            //       fontSize: 1.3 * SizeConfig.heightMultiplier,
                            //       color: const Color(0xffffffff),
                            //       fontWeight: FontWeight.w300,
                            //     ),
                            //     textAlign: TextAlign.left,
                            //   ),
                            //   padding: EdgeInsets.symmetric(
                            //       vertical: 12.0, horizontal: 5.1 * SizeConfig.widthMultiplier),
                            //   icon: Icon(
                            //     Icons.clear,
                            //     size: 3.94 * SizeConfig.heightMultiplier,
                            //     color: Colors.white,
                            //   ),
                            //   duration: Duration(seconds: 3),
                            //   flushbarPosition: FlushbarPosition.TOP,
                            //   borderColor: Colors.transparent,
                            //   shouldIconPulse: false,
                            //   maxWidth: 91.8 * SizeConfig.widthMultiplier,
                            //   boxShadows: [
                            //     BoxShadow(
                            //       color: Colors.black.withOpacity(0.3),
                            //       spreadRadius: 1 * SizeConfig.heightMultiplier,
                            //       blurRadius: 2 * SizeConfig.heightMultiplier,
                            //       offset: Offset(0, 10), // changesvalue position of shadow
                            //     ),
                            //   ],
                            //   backgroundColor: kShadeColor1,
                            // ).show(context);

                          }
                          else{
                            serverOTP=jsonDecode(_responseBody)['OTP'];
                            forgotUserID=jsonDecode(_responseBody)['SystemUserID'];

                            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                            sharedPreferences.setString('tempUserID', forgotUserID);
                            sharedPreferences.setString('serverOTP', serverOTP);
                            print(serverOTP);
                            print(forgotUserID);
                            if(forgotUserID!=null && serverOTP!=null){
                              await Flushbar(
                                titleText: Text(
                                  'Email Sent',
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 2.0 * SizeConfig.heightMultiplier,
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                messageText: Text(
                                  'An email with one time password has been sent on your registered email address.',
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 1.3 * SizeConfig.heightMultiplier,
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 5.1 * SizeConfig.widthMultiplier),
                                icon: Icon(
                                  Icons.check,
                                  size: 3.94 * SizeConfig.heightMultiplier,
                                  color: Colors.white,
                                ),
                                duration: Duration(seconds: 5),
                                flushbarPosition: FlushbarPosition.TOP,
                                borderColor: Colors.transparent,
                                shouldIconPulse: false,
                                maxWidth: 91.8 * SizeConfig.widthMultiplier,
                                boxShadows: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 1 * SizeConfig.heightMultiplier,
                                    blurRadius: 2 * SizeConfig.heightMultiplier,
                                    offset: Offset(0, 10), // changes value position of shadow
                                  ),
                                ],
                                backgroundColor: kShadeColor1,
                              ).show(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EnterOTP()));}
                          }
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              2.63 * SizeConfig.heightMultiplier)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-1.0, 0.0),
                              end: Alignment(1.25, 0.0),
                              colors: [
                                const Color(0xff3ba838),
                                const Color(0xff319945),
                                const Color(0xff1a7861)
                              ],
                              stops: [0.0, 0.306, 1.0],
                            ),
                            borderRadius: BorderRadius.circular(
                                3.94 * SizeConfig.heightMultiplier)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 0.0, right: 0.0),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 67.85 * SizeConfig.widthMultiplier,
                                minHeight: 6.57 * SizeConfig.heightMultiplier),
                            alignment: Alignment.center,
                            child: Text(
                              'Send Email',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 2.0 * SizeConfig.heightMultiplier,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
        },

        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: ModalProgressHUD(
        inAsyncCall: _waiting,
        color: Color(0xff3ba838),
        opacity: 0.1,
        child: GestureDetector(onTap: (){
          FocusScope.of(context).unfocus();
        },
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Image.asset(
                    'images/ercolored.png',
                    height: 15.78 * SizeConfig.heightMultiplier,
                    width: 32.14 * SizeConfig.widthMultiplier,
                  ),
                  SizedBox(
                    height: 5.0 * SizeConfig.heightMultiplier,
                  ),

                  Text(
                    'Sign in to your account',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 2.36 * SizeConfig.heightMultiplier,
                      color: const Color(0xff1a1a1a),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 6.31 * SizeConfig.heightMultiplier,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 47.0, right: 47.0),
                    child: Column(
                      children: [
                        Container(
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              _username = value;
                            },
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 2 * SizeConfig.heightMultiplier),
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Username'),
                          ),
                          width: 67.8 * SizeConfig.widthMultiplier,
                          height: 5.65 * SizeConfig.heightMultiplier,
                        ),
                        SizedBox(
                          height: 2 * SizeConfig.heightMultiplier,
                        ),
                        Container(
                          width: 67.8 * SizeConfig.widthMultiplier,
                          height: 5.65 * SizeConfig.heightMultiplier,
                          child: TextField(
                            obscureText: true,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              _password = value;
                            },
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 2 * SizeConfig.heightMultiplier,
                            ),
                            decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Password'),
                          ),
                        ),
                        Visibility(
                          visible: message != '',
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              message,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 1.5 * SizeConfig.heightMultiplier),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6.31 * SizeConfig.heightMultiplier,
                  ),
                  Container(
                    height: 5.65 * SizeConfig.heightMultiplier,
                    child: RaisedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _waiting = true;
                        });
                        // await checkConnection();
                        dataConnectionStatus = await DataConnectionChecker().connectionStatus;
                        if(dataConnectionStatus!=DataConnectionStatus.connected){
                          setState(() {
                            _waiting = false;
                          });
                          await Flushbar(
                            titleText: Text(
                              'No Internet',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 2.0 * SizeConfig.heightMultiplier,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            messageText: Text(
                              'Please check your internet connection.',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 1.3 * SizeConfig.heightMultiplier,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 5.1 * SizeConfig.widthMultiplier),
                            icon: Icon(
                              Icons.signal_cellular_null_sharp,
                              size: 3.94 * SizeConfig.heightMultiplier,
                              color: Colors.white,
                            ),
                            duration: Duration(seconds: 2),
                            flushbarPosition: FlushbarPosition.TOP,
                            borderColor: Colors.transparent,
                            shouldIconPulse: false,
                            maxWidth: 91.8 * SizeConfig.widthMultiplier,
                            boxShadows: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1 * SizeConfig.heightMultiplier,
                                blurRadius: 2 * SizeConfig.heightMultiplier,
                                offset: Offset(0, 10), // changes position of shadow
                              ),
                            ],
                            backgroundColor: kShadeColor1,
                          ).show(context);
                        }
                        else{
                        if (_username != null && _password != null && dataConnectionStatus==DataConnectionStatus.connected) {
                          await GetUserLogin(kBaseURL +
                              'REST/EasyRails/App_GetUserDetails?UserName=$_username&Temp_pdw=$_password');
                          setState(() {
                            _waiting = false;
                          });
                          if (_username != null && _serverUsername != null) {
                            if (_username.toLowerCase() ==
                                    _serverUsername.toLowerCase() &&
                                _password == _serverPassword) {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) => XDMenu()), (route) => false);
                            }
                          } else {
                            message = '*Username or Password is Incorrect';
                          }
                        }
                        }
                        setState(() {
                          _waiting = false;
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.52 * SizeConfig.heightMultiplier)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-1.0, 0.0),
                              end: Alignment(1.25, 0.0),
                              colors: [
                                const Color(0xff3ba838),
                                const Color(0xff319945),
                                const Color(0xff1a7861)
                              ],
                              stops: [0.0, 0.306, 1.0],
                            ),
                            borderRadius: BorderRadius.circular(
                                3.94 * SizeConfig.heightMultiplier)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 0.0, right: 0.0),
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 67.85 * SizeConfig.widthMultiplier,
                                minHeight: 6.57 * SizeConfig.heightMultiplier),
                            alignment: Alignment.center,
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 2.23 * SizeConfig.heightMultiplier,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.94 * SizeConfig.heightMultiplier,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Forgot Password Tapped');
                      ShowForgotPassword();
                    },
                    child: Text(
                      'Forgot your password?',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 2.23 * SizeConfig.heightMultiplier,
                        color: kShadeColor1,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 7.9 * SizeConfig.heightMultiplier,
                  ),
                  RawMaterialButton(
                    child: Container(
                      child: FittedBox(
                        child: SizedBox(
                          width: 9.2 * SizeConfig.widthMultiplier,
                          height: 9.2 * SizeConfig.widthMultiplier,
                          child: SvgPicture.string(
                            _svg_731xhc,
                            allowDrawingOutsideViewBox: true,
                          ),
                        ),
                      ),
                    ),
                    elevation: 6.0,
                    onPressed: () {
                      QuickLaunchLink().hitLink(
                          'mailto:$supportEmail?subject=Need%20Help&body=Hi%20Support');
                    },
                  ),
                  SizedBox(
                    height: 2.63 * SizeConfig.heightMultiplier,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}

const String _svg_731xhc =
    '<svg viewBox="167.0 724.6 41.1 41.1" ><defs><linearGradient id="gradient" x1="0.0" y1="0.5" x2="1.0" y2="0.5"><stop offset="0.0" stop-color="#ff3ba838"  /><stop offset="0.30627" stop-color="#ff319945"  /><stop offset="1.0" stop-color="#ff1a7861"  /></linearGradient></defs><path transform="translate(167.0, 724.56)" d="M 20.530517578125 0 C 9.192509651184082 0 0.001000000047497451 9.19178295135498 0.001000000047497451 20.5297908782959 C 0.001000000047497451 31.86752700805664 9.192509651184082 41.06000137329102 20.530517578125 41.06000137329102 C 31.86853218078613 41.06000137329102 41.06072235107422 31.86753082275391 41.06072235107422 20.52979469299316 C 41.06072235107422 9.19178295135498 31.86853218078613 0 20.530517578125 0 Z M 20.53092765808105 7.211029529571533 L 32.67974090576172 14.78667449951172 L 8.382115364074707 14.78667449951172 L 20.53092765808105 7.211029529571533 Z M 32.83111953735352 26.88402938842773 L 32.82988739013672 26.88402938842773 C 32.82988739013672 28.09914398193359 31.84512138366699 29.08377265930176 30.63014602661133 29.08377265930176 L 10.43171215057373 29.08377265930176 C 9.216598510742188 29.08377265930176 8.23197078704834 28.09900856018066 8.23197078704834 26.88402938842773 L 8.23197078704834 15.26872444152832 C 8.23197078704834 15.14020442962646 8.245109558105469 15.01524448394775 8.266460418701172 14.8924732208252 L 19.87396621704102 22.13046646118164 C 19.88819885253906 22.13936233520508 19.90338897705078 22.14538383483887 19.91803741455078 22.15359497070313 C 19.93336296081543 22.16208076477051 19.94896697998047 22.17029571533203 19.96457099914551 22.1780948638916 C 20.04655265808105 22.22039031982422 20.13100242614746 22.25447082519531 20.21736526489258 22.27677726745605 C 20.22626304626465 22.27924156188965 20.23515892028809 22.28033638000488 20.24405670166016 22.28238677978516 C 20.33876991271973 22.3046989440918 20.43471145629883 22.31865882873535 20.53052139282227 22.31865882873535 L 20.53120613098145 22.31865882873535 C 20.53189086914063 22.31865882873535 20.53257369995117 22.31865882873535 20.53257369995117 22.31865882873535 C 20.62838172912598 22.31865882873535 20.72432518005371 22.30510902404785 20.81904029846191 22.28238677978516 C 20.82793617248535 22.28019714355469 20.83683204650879 22.27924156188965 20.84572982788086 22.27677726745605 C 20.93195724487305 22.25447082519531 21.01612854003906 22.22038841247559 21.09852600097656 22.1780948638916 C 21.11412811279297 22.17029571533203 21.12973022460938 22.16208076477051 21.14505767822266 22.15359497070313 C 21.15956687927246 22.1453857421875 21.17489624023438 22.13936233520508 21.18913078308105 22.13046646118164 L 32.796630859375 14.8924732208252 C 32.8179817199707 15.01524448394775 32.83112335205078 15.13992977142334 32.83112335205078 15.26872444152832 L 32.83112335205078 26.88402938842773 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
