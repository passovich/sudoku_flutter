import 'package:flutter/material.dart';
import 'package:sudoku/data/settings.dart';
import 'package:sudoku/ui/widgets/round_rectangle_container.dart';

class ButtonPanel extends StatefulWidget{
  final void Function(int action) parentAction;

  ButtonPanel({this.parentAction});

  @override
  _ButtonPanelState createState() => _ButtonPanelState();
}

class _ButtonPanelState extends State<ButtonPanel> {
  bool pen = true;

  @override
  Widget build(BuildContext context) {

    return
      Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _getButton(1),
              _getButton(2),
              _getButton(3),
              _getButton(4),
              _getButton(5),
          ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _getButton(6),
              _getButton(7),
              _getButton(8),
              _getButton(9),
              _getButton(0),
          ],),
      ],);
  }
  Widget _getButton(int buttonNumber) {
    return RoundRectangleConteiner(
      color:  pen ? Settings.penActiveButtonColor : Settings.buttonColor,
      child: IconButton(
       // focusColor: Colors.green,
        //highlightColor: Colors.purple,
        icon: Text(buttonNumber>0 ? buttonNumber.toString():'Pen'),
        iconSize: 30,
        onPressed: () { buttonNumber == 0 ? penPressed() : widget.parentAction(buttonNumber);
        },
      ),
    );
  }

 void penPressed(){
   pen = !pen;
   widget.parentAction(0);
   setState(() {});
 }
}