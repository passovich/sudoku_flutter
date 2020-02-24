import 'package:flutter/material.dart';
class Settings{
   ///cell colors
   /////   static var dc = Colors.primaries[1];
   static var selColor = Colors.yellowAccent;
   static var buttonColor = Colors.lightGreen;
   static var penActiveButtonColor = Colors.redAccent;
   static var dc = Colors.green;
   static var lc = Colors.greenAccent;
   static List cellsColors = [
      [lc,lc,lc,dc,dc,dc,lc,lc,lc],
      [lc,lc,lc,dc,dc,dc,lc,lc,lc],
      [lc,lc,lc,dc,dc,dc,lc,lc,lc],
      [dc,dc,dc,lc,lc,lc,dc,dc,dc],
      [dc,dc,dc,lc,lc,lc,dc,dc,dc],
      [dc,dc,dc,lc,lc,lc,dc,dc,dc],
      [lc,lc,lc,dc,dc,dc,lc,lc,lc],
      [lc,lc,lc,dc,dc,dc,lc,lc,lc],
      [lc,lc,lc,dc,dc,dc,lc,lc,lc],
      [lc,lc,lc,dc,dc,dc,lc,lc,lc],
   ];
   ///fonts
   static String winner = 'We have a winner';
   static String loser = 'You lose';
   static double bigFontSize = 25.0;
   static double smallFontSize = 9.0;           //size of small number
   static double  cellSize = 40.0;              //size of one cell
   ///text constants
   static String appHeader = 'Судоку';
   static String endGameScreenHeader = 'Game over';
}