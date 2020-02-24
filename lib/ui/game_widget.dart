import 'package:flutter/material.dart';
import 'package:sudoku/calculations/Matrix.dart';
import 'package:sudoku/ui/cell.dart';
import 'package:sudoku/data/items.dart';
import 'package:sudoku/ui/button_panel.dart';
import 'package:sudoku/ui/end_game_screen.dart';

class GameWidget extends StatefulWidget {
  Items gameField;

  GameWidget(Matrix matrix,{Key key}):super(key: key){
    gameField = Items(matrix);
  }

  @override
  GameWidgetState createState() => GameWidgetState(gameField);
}

class GameWidgetState extends State<GameWidget> {
  Items gameField;
  List _cells = List();             //list of game cells
  int _selectX = 3,_selectY = 5;    //selected cell coordinates
  List _keys = List();              //keys to operate with cells

  GameWidgetState(this.gameField){
    _keysInitialize();
    _cellsInitialize();
  }

  @override
  Widget build(BuildContext context) {
    var lines = List<Widget>();
    for (int i = 0; i < 9; i++){
      lines.add(Row(children: _cells[i]));
    }
    return Column(
      children: <Widget>[
        Column (children: lines,),
        ButtonPanel(parentAction: buttonPanelAction,),
      ],
    );
  }

  _updateSelectedCells(int x, int y){
    _cells[_selectX][_selectY].item.selected = false;
    _cells[x][y].item.selected = true;
    _keys[_selectX][_selectY].currentState.update();
    _selectX = x;
    _selectY = y;
    _keys[x][y].currentState.update();
    setState(() {});
    print ('x'
        +x.toString()
        +',y'
        +y.toString()
        + ' solved='
        +gameField.item[x][y].solved.toString()
        +' user solution='
        +gameField.item[x][y].userSolution.toString()
        +' rightSolution='
        +gameField.item[x][y].rightSolution.toString()
    );
  }
  drawerAction({@required int action}){
    switch (action){
      case 0: _updateAllCells(); break;
      case 1: gameField.getZeroAuxMatrix(); _updateAllCells(); break;
    }
  }

  buttonPanelAction(int buttonNumber){
    gameField.buttonPressed(buttonNumber,_selectX,_selectY);
    if(gameField.checkForEndGame()){
      _navigateToWinner(context,gameField.checkForWinGame());
    }
    _updateAllCells();
  }

  void _updateAllCells(){
    for(int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        _keys[i][j].currentState.update();
      }
    }
  }

  void _navigateToWinner(BuildContext context,bool winner) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EndGameScreen(winner)));
  }

  void _keysInitialize(){
    for(int i = 0; i < 9; i++) {
      _keys.add(List<GlobalKey<CellState>>());
      for (int j = 0; j < 9; j++) {
        GlobalKey<CellState> temp = GlobalKey();
        _keys[i].add(temp);
      }
    }
  }

  void _cellsInitialize(){
    _cells = List();
    for(int i = 0; i < 9; i++) {
      _cells.add(List<Widget>());
      for (int j = 0; j < 9; j++) {
        _cells[i].add(Cell(
            item: gameField.item[i][j],
            parentAction: _updateSelectedCells,
            key: _keys[i][j]),);
      }
    }
  }
}
