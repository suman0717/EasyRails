import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton({this.icon, this.onPress,this.iconColor});

  final IconData icon;
  final Function onPress;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Icon(icon,size: 10.0,color: iconColor,),
      ),
      shape: CircleBorder(side: BorderSide(style: BorderStyle.solid,color: iconColor,)),
//      fillColor: Colors.purpleAccent,
      constraints: BoxConstraints.tightFor(
        width: 20.0,

      ),
//      elevation: 6.0,
      onPressed: onPress,
    );
  }
}