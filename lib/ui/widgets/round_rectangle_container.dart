import 'package:flutter/material.dart';

class RoundRectangleConteiner extends StatelessWidget {
  Widget _child;
  Color _color;
  RoundRectangleConteiner({@required Widget child,Color color = Colors.black12}){
    _child = child;
    _color = color;
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      decoration: BoxDecoration(
        color: _color,
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: _child,
    );
  }
}