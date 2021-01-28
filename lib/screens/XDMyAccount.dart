import 'package:easy_rails/bottomBar.dart';
import 'package:easy_rails/screens/XDUpdateProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

int adjustementLength = 250;
int neutralTemp = 38;
int minAdjustedTemp = 28;
double weldGap = 5.0;

class XDMyAccount extends StatefulWidget {
  @override
  _XDMyAccountState createState() => _XDMyAccountState();
}

class _XDMyAccountState extends State<XDMyAccount> {
  void reSetValue() {
    // TODO Add Action for initSate function
  }

  @override
  void initState() {
    // TODO: implement initState
    reSetValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My Account',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.more_vert,
                size: 20.0,
              ),
              onPressed: () {
                // TODO Add Functionality to do more
                print('More Clicked on My Acocunt page');
              })
        ],
      ),
      bottomNavigationBar: BottomBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.21, -1.17),
            end: Alignment(1.25, 0.26),
            colors: [
              const Color(0xff5eb533),
              const Color(0xff097445),
              const Color(0xff157079),
              const Color(0xff02414d)
            ],
            stops: [0.0, 0.391, 0.712, 1.0],
          ),
        ),
        child: ListView(
          children: [
            Container(
              height: 160.0,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                        child: CircleAvatar(
                          radius: 30.0,
                          child: Text(
                            'TN',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 28,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w600,
                              shadows: [
                                Shadow(
                                  color: const Color(0x1c000000),
                                  offset: Offset(0, 4),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                          backgroundColor: Color(0xff5dae6d),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Temporary Name',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            'ID: #123456',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: const Color(0xadffffff),
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, top: 15.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 6.0),
                              child: Icon(
                                Icons.location_on,
                                size: 15.0,
                                color: const Color(0xffffffff),
                              ),
                            ),
                            Text(
                              'Brisbane, Australia',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 130.0,
                          height: 28.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28.0),
                            color: const Color(0xffffffff),
                          ),
                          child: GestureDetector(onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>XDUpdateProfile(),),);
                          },
                            child: Center(
                              child: Text(
                                'Update Profile',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: const Color(0xff117266),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  color: Colors.white),
              child: Column(
                children: [
                  SizedBox(height: 10.00,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Username',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0xff828282),
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'tempname01',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0xff1a1a1a),
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    indent: 20.0,
                    endIndent: 25.0,
                    color: Color(0xffECECEC),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Email Address',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0xff828282),
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'temp@ethink.solutions',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: const Color(0xff1a1a1a),
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    indent: 20.0,
                    endIndent: 25.0,
                    color: Color(0xffECECEC),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phone',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: const Color(0xff828282),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'tempname01',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: const Color(0xff1a1a1a),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    indent: 20.0,
                    endIndent: 25.0,
                    color: Color(0xffECECEC),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date of Birth',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: const Color(0xff828282),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '20/05/1990',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: const Color(0xff1a1a1a),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    indent: 20.0,
                    endIndent: 25.0,
                    color: Color(0xffECECEC),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0,15.0,20.0,15.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Password',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: const Color(0xff828282),
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '**********',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: const Color(0xff1a1a1a),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
