import 'package:flutter/material.dart';
import 'package:sudoku/ui/end_game_screen.dart';
import 'package:sudoku/ui/home_page_screen.dart';

class SudokuDrawer extends StatelessWidget {

  final void Function({int action}) parentAction;

  SudokuDrawer({this.parentAction});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(icon: Icons.event, text: 'Новая игра',onTap: (){_navigateToNewGame(context);}),
          _createDrawerItem(icon: Icons.event, text: 'Заполнить заметки',onTap: (){parentAction(action: 1);Navigator.pop(context);}),
          Divider(),
          _createDrawerItem(icon: Icons.note, text: 'winnerPage',onTap: (){_navigateToWinner(context);}),
//          _createDrawerItem(icon: Icons.collections_bookmark, text: 'Steps'),
//          _createDrawerItem(icon: Icons.face, text: 'Authors'),
//          _createDrawerItem(
//              icon: Icons.account_box, text: 'Flutter Documentation'),
//          _createDrawerItem(icon: Icons.stars, text: 'Useful Links'),
//          Divider(),
//          _createDrawerItem(icon: Icons.bug_report, text: 'Report an issue'),
//          ListTile(
//            title: Text('0.0.1'),
//            onTap: () {},
//          ),
        ],
      ),
    );
  }
  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image:  AssetImage('assets/image.png'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("SUDOKU",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }
  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
  void _navigateToWinner(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EndGameScreen(false)));
  }
  void _navigateToNewGame(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}