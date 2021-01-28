import 'package:easy_rails/constants.dart';
import 'package:easy_rails/linkOpener.dart';
import 'package:easy_rails/screens/XDSignIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class XDSignUp extends StatefulWidget {
  @override
  _XDSignUpState createState() => _XDSignUpState();
}

class _XDSignUpState extends State<XDSignUp> {

  String firstName;
  String surname;
  String streetAddress;
  String emailAddress;
  String password;

  String selectedcity;
  bool termsadnconditon = false;

  List<DropdownMenuItem> getCityList() {
    List<DropdownMenuItem<String>> dropdownitems = [];
    for (int i = 0; i < cityList.length; i++) {
      String cityname = cityList[i];
      var newItem = DropdownMenuItem(
        child: Text(cityname),
        value: cityname,
      );
      dropdownitems.add(newItem);
    }
    return dropdownitems;
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.0,
              ),
              Text(
                'Sign Up',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  color: const Color(0xff1a1a1a),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 47.0, right: 47.0),
                child: Column(
                  children: [
                    Container(
                      child: TextField(
                        textAlign: TextAlign.left,
                        onChanged: (value) {
                          firstName = value;
                        },
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 14.0),
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: '*First Name'),
                      ),
                      width: 266.0,
                      height: 43.0,
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    Container(
                      child: TextField(
                        textAlign: TextAlign.left,
                        onChanged: (value) {
                          surname = value;
                        },
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 14.0),
                        decoration:
                            kTextFieldDecoration.copyWith(hintText: '*Surname'),
                      ),
                      width: 266.0,
                      height: 43.0,
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                  ],
                ),
              ),
              Container(
                child: TextField(
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    emailAddress = value;
                  },
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14.0),
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: '*Username'),
                ),
                width: 266.0,
                height: 43.0,
              ),
              SizedBox(
                height: 14.0,
              ),
              Container(
                child: TextField(
                  textAlign: TextAlign.left,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14.0),
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: '*Password'),
                ),
                width: 266.0,
                height: 43.0,
              ),
              SizedBox(
                height: 14.0,
              ),
              Container(
                child: TextField(
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    streetAddress = value;
                  },
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14.0),
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: '*Street Address'),
                ),
                width: 266.0,
                height: 43.0,
              ),
              SizedBox(
                height: 14.0,
              ),
              Container(width: 266.0,height: 43.0,decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0),color: Color(0xfff5f5f5)),
                child: Padding(
                  padding: EdgeInsets.only(left:20.0,right:20.0),
                  child: DropdownButton<String>(iconSize: 0.0,
                    underline: Container( // This Container is used to hide the Unerline in Dropdown Menu Box
                    height: 1.0,
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.transparent, width: 0.0))
                    ),
                  ),
                    isExpanded: true,
                    hint: Text('*City',style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: const Color(0xff828282),
                      fontWeight: FontWeight.w300,
                    ),),
                    items: cityList.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        child: Text(dropDownStringItem),
                      value: dropDownStringItem,);
                    }).toList(),
                    onChanged: (String valueSelected){
                      setState(() {
                        this.selectedcity=valueSelected;
                      });
                    },
                    value: selectedcity,

                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(width: 300.0,
                height: 43.0,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom:10.0),
                      child: Checkbox(
                          activeColor: Color(0xff359f40),
                          value: termsadnconditon,
                          onChanged: (bool valueselected) {
                            setState(() {
                              if (termsadnconditon == true) {
                                termsadnconditon = false;
                              } else
                                (termsadnconditon = true);
                            });
                          }),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          color: const Color(0xff737373),
                        ),
                        children: [
                          TextSpan(
                            text: 'By signing up you accept the ',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: 'Terms\nof Service',
                            style: TextStyle(
                              color: const Color(0xff359f40),
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: const Color(0xff359f40),
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 14.0,
              ),
              Container(
                height: 43.0,
                child: RaisedButton(
                  onPressed: () async{
                  print('text2 at signup page');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
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
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 0.0, right: 0.0),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 266.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>XDSignIn(),),);
                },
                child: SizedBox(
                  width: 324.0,
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 17,
                        color: const Color(0xff1a1a1a),
                      ),
                      children: [
                        TextSpan(
                          text: 'Already have an account?',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextSpan(
                          text: ' ',
                        ),
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              RawMaterialButton(
                child: Container(
                  child: SvgPicture.string(
                    _svg_731xhc,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                elevation: 6.0,
                onPressed: (){
                  QuickLaunchLink().hitLink('mailto:support@ethink.solutions?subject=Need%20Help&body=Hi%20Support');
                  },
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 String _svg_731xhc =
    '<svg viewBox="167.0 724.6 41.1 41.1" ><defs><linearGradient id="gradient" x1="0.0" y1="0.5" x2="1.0" y2="0.5"><stop offset="0.0" stop-color="#ff3ba838"  /><stop offset="0.30627" stop-color="#ff319945"  /><stop offset="1.0" stop-color="#ff1a7861"  /></linearGradient></defs><path transform="translate(167.0, 724.56)" d="M 20.530517578125 0 C 9.192509651184082 0 0.001000000047497451 9.19178295135498 0.001000000047497451 20.5297908782959 C 0.001000000047497451 31.86752700805664 9.192509651184082 41.06000137329102 20.530517578125 41.06000137329102 C 31.86853218078613 41.06000137329102 41.06072235107422 31.86753082275391 41.06072235107422 20.52979469299316 C 41.06072235107422 9.19178295135498 31.86853218078613 0 20.530517578125 0 Z M 20.53092765808105 7.211029529571533 L 32.67974090576172 14.78667449951172 L 8.382115364074707 14.78667449951172 L 20.53092765808105 7.211029529571533 Z M 32.83111953735352 26.88402938842773 L 32.82988739013672 26.88402938842773 C 32.82988739013672 28.09914398193359 31.84512138366699 29.08377265930176 30.63014602661133 29.08377265930176 L 10.43171215057373 29.08377265930176 C 9.216598510742188 29.08377265930176 8.23197078704834 28.09900856018066 8.23197078704834 26.88402938842773 L 8.23197078704834 15.26872444152832 C 8.23197078704834 15.14020442962646 8.245109558105469 15.01524448394775 8.266460418701172 14.8924732208252 L 19.87396621704102 22.13046646118164 C 19.88819885253906 22.13936233520508 19.90338897705078 22.14538383483887 19.91803741455078 22.15359497070313 C 19.93336296081543 22.16208076477051 19.94896697998047 22.17029571533203 19.96457099914551 22.1780948638916 C 20.04655265808105 22.22039031982422 20.13100242614746 22.25447082519531 20.21736526489258 22.27677726745605 C 20.22626304626465 22.27924156188965 20.23515892028809 22.28033638000488 20.24405670166016 22.28238677978516 C 20.33876991271973 22.3046989440918 20.43471145629883 22.31865882873535 20.53052139282227 22.31865882873535 L 20.53120613098145 22.31865882873535 C 20.53189086914063 22.31865882873535 20.53257369995117 22.31865882873535 20.53257369995117 22.31865882873535 C 20.62838172912598 22.31865882873535 20.72432518005371 22.30510902404785 20.81904029846191 22.28238677978516 C 20.82793617248535 22.28019714355469 20.83683204650879 22.27924156188965 20.84572982788086 22.27677726745605 C 20.93195724487305 22.25447082519531 21.01612854003906 22.22038841247559 21.09852600097656 22.1780948638916 C 21.11412811279297 22.17029571533203 21.12973022460938 22.16208076477051 21.14505767822266 22.15359497070313 C 21.15956687927246 22.1453857421875 21.17489624023438 22.13936233520508 21.18913078308105 22.13046646118164 L 32.796630859375 14.8924732208252 C 32.8179817199707 15.01524448394775 32.83112335205078 15.13992977142334 32.83112335205078 15.26872444152832 L 32.83112335205078 26.88402938842773 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';



