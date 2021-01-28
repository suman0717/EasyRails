import 'package:easy_rails/bottomBar.dart';
import 'package:easy_rails/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class XDUpdateProfile extends StatefulWidget {
  @override
  _XDXDUpdateProfileState createState() => _XDXDUpdateProfileState();
}

class _XDXDUpdateProfileState extends State<XDUpdateProfile> {
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
          'Update Profile',
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
                print('More Clicked on Update Profile page');
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
                            border: Border.all(
                              color: Colors.white, //                   <--- border color
                              width: 0.5,
                            ),),
                          child: GestureDetector(onTap: (){
                            print('object');
                          },
                            child: Center(
                              child: Text(
                                'Change Address',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: const Color(0xffffffff),
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
                  Container(
                    child: TextField(
                      textAlign: TextAlign.left,
                      onChanged: (value) {
                        print('object');
                      },
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 14.0),
                      decoration:
                      kTextFieldDecorationNoback,
                    ),
                    width: 303.0,
                    height: 43.0,
                  ),
                  Container(
                    child: TextField(
                      textAlign: TextAlign.left,
                      onChanged: (value) {
                        print('object');
                      },
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 14.0),
                      decoration:
                      kTextFieldDecorationNoback,
                    ),
                    width: 303.0,
                    height: 43.0,
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
