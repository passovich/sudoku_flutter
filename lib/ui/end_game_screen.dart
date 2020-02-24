import 'package:flutter/material.dart';
import 'package:sudoku/data/settings.dart';

class EndGameScreen extends StatelessWidget {
  bool winner;

  EndGameScreen(this.winner);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(Settings.endGameScreenHeader),),
      body: Column(
        children: <Widget>[
          Text(winner ? Settings.winner: Settings.loser),
          Container(
              color: Colors.yellow,
              width: 200,
              height: 200,
              child: Image(
                image: AssetImage('assets/image.png'),
                fit: BoxFit.fill,)
          ),
        ],),
    );;
  }
}

