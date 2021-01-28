import 'package:easy_rails/constants.dart';
import 'package:easy_rails/screens/otp_ResetPassword.dart';
import 'package:easy_rails/size_config.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> locationListTemp=[''];

class EnterOTP extends StatefulWidget {
  @override
  _EnterOTPState createState() => _EnterOTPState();
}

class _EnterOTPState extends State<EnterOTP> {

  bool _waiting = false;
  String _enteredOTP;
  String _message='';
  String forgotEmailAddress;

  void validationOTPMessage(String errormsg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 5.0,
            title: Text(
              'Error:',
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
                  Text(
                    errormsg,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 1.9 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 1 * SizeConfig.heightMultiplier,
                  ),
                ],
              ),
            ),
          );
        });
  }

  bool validateOTP(String number) {
    print(number);
    if (number.length != 6) {
      validationOTPMessage('Please enter correct verification code');
      return false;
    }
    else{
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      FocusScope.of(context).unfocus();
    },
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: ModalProgressHUD(
          inAsyncCall: _waiting,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0 * SizeConfig.heightMultiplier,
                  ),
                  Image.asset(
                    'images/ercolored.png',
                    height: 15.78 * SizeConfig.heightMultiplier,
                    width: 32.14 * SizeConfig.widthMultiplier,
                  ),
                  SizedBox(
                    height: 5.3 * SizeConfig.heightMultiplier,
                  ),
                  Text(
                    'Enter the verification code \n sent to your email',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 2.3 * SizeConfig.heightMultiplier,
                      color: const Color(0xff1a1a1a),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Visibility(
                      visible: _message != '',
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          _message,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 1.5 * SizeConfig.heightMultiplier),
                        ),
                      )),
                  SizedBox(
                    height: 6.3 * SizeConfig.heightMultiplier,
                  ),
                  Container(
                    width: 68.2 * SizeConfig.widthMultiplier,
//                  height: 5.7 * SizeConfig.heightMultiplier,
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        _enteredOTP = value;
                        print(_enteredOTP);
                      },
                      style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 2.0 * SizeConfig.heightMultiplier),
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter Code . . .',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 1.5 * SizeConfig.heightMultiplier,
                            horizontal: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.9 * SizeConfig.heightMultiplier,
                  ),
                  Container(
                    width: 68.2 * SizeConfig.widthMultiplier,
                    height: 5.65 * SizeConfig.heightMultiplier,
                    child: RaisedButton(color: kShadeColor1,
                      onPressed: () async {
                        FocusManager.instance.primaryFocus.unfocus();
                        if(_message!=''){
                          _message='';
                        }
                        if(_enteredOTP!=null){
                          bool _validate = validateOTP(_enteredOTP);
                          if(_validate==true){
                            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                            String _tempUserID=sharedPreferences.get('tempUserID');
                            String _tempOTP=sharedPreferences.get('serverOTP');
                            print('object');
                            print(_tempOTP);
                            print(_tempUserID);
                            if(_tempOTP==_enteredOTP){
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EnterNewPWD(),
                                ),
                              );
                            }
                            else{
                              validationOTPMessage('Please enter correct verification code');
                            }
                          }
                        }
                        setState(() {
                          _waiting = true;
                        });
                        setState(() {
                          _waiting = false;
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.63 * SizeConfig.heightMultiplier)),
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
                  'Submit',
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
                  SizedBox(
                    height: 3.95 * SizeConfig.heightMultiplier,
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

