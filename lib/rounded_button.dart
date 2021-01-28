import 'package:flutter/material.dart';


class RoundedButton extends StatelessWidget {
  String title;
  Color colour;
  Function onPressed;
  Color textcolors;
  FontWeight fontweight = FontWeight.w600;
  double fontsize = 14.0;
  RoundedButton({this.title,this.colour,@required this.onPressed,this.textcolors,this.fontweight,this.fontsize});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
//        elevation: 5.0,
        child: MaterialButton(          onPressed: onPressed,
          minWidth: 252.0,
          child: Text(
            title,style: TextStyle(color: textcolors,fontFamily: 'Poppins',fontWeight: fontweight,fontSize: fontsize),
          ),
        ),
      ),
    );
  }
}