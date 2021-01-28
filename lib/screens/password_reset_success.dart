import 'package:easy_rails/constants.dart';
import 'package:easy_rails/screens/XDSignIn.dart';
import 'package:easy_rails/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ResetSuccess extends StatefulWidget {
  @override
  _ResetSuccessState createState() => _ResetSuccessState();
}

class _ResetSuccessState extends State<ResetSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-1.32, -0.92),
                      end: Alignment(1.37, 0.51),
                      colors: [
                        const Color(0xff5eb533),
                        const Color(0xff097445),
                        const Color(0xff157079),
                        const Color(0xff02414d)
                      ],
                      stops: [0.0, 0.295, 0.712, 1.0],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 45.0,
                      ),
                      Image.asset('images/erwhite.png',
                          width: 32.14 * SizeConfig.widthMultiplier,
                          height: 15.78 * SizeConfig.heightMultiplier),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF5F8FB),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 50.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 60.0),
            width: 322.0,
            height: 290.0,
            child: Card(
              color: Colors.white,
              elevation: 20.0,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Password Reset Successful',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 18,
                        color: const Color(0xff363636),
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'You have successfully changed your password.\nPlease login using your new password.',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 14,
                        color: const Color(0xff363636),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      width: 68.2 * SizeConfig.widthMultiplier,
                      height: 5.65 * SizeConfig.heightMultiplier,
                      child: RaisedButton(
                        color: kShadeColor1,
                        onPressed: () async {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) => XDSignIn()), (route) => false);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                2.63 * SizeConfig.heightMultiplier)),
                        padding: EdgeInsets.all(0.0),
                        child: Padding(
                          padding: EdgeInsets.only(left: 0.0, right: 0.0),
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 15,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
