import 'package:flutter/material.dart';

class Item {
  int x, y;                       //coordinates on gameField
  int solved;                     //'-1' aux, '0' not solved, '1' solved, '2' immutable
  int userSolution = 0;           //user variant of solution in solved matrix
  int rightSolution;              //calculated solution
  bool selected = false;          //cell selected on screen
  List auxTable = List<int>(10);  //users auxTable for 'pencil marks'
  var color;                      //color of cell

  Item(this.x,
      this.y,
      {
        @required this.rightSolution,
        @required int taskItem,
        @required int auxMatrix0,
      }) {
    if (taskItem > 0) {
      solved = 2;
    }
    else {
      if (taskItem == 0) {
        solved = auxMatrix0;
      }
    }
    auxTableReset();
  }

  void auxTableReset() {
    for (int i = 0; i < 10; i++)
      auxTable[i] = 0;
  }
}