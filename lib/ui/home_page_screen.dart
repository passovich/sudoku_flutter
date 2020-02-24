import 'package:flutter/material.dart';
import 'package:sudoku/data/settings.dart';
import 'package:sudoku/ui/game_widget.dart';
import 'package:sudoku/block/block_provider.dart';
import 'package:sudoku/block/fetch_matrix_block.dart';
import 'package:sudoku/calculations/Matrix.dart';
import 'package:sudoku/ui/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<GameWidgetState> gameWidgetKey = GlobalKey();

  @override
  void initState() {
    var bloc = BlocProvider.of<MatrixBlock>(context);
    bloc = BlocProvider.of<MatrixBlock>(context);
    bloc.fetchItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Settings.appHeader),),
      body: buildBody(context),
      drawer: SudokuDrawer(parentAction: _drawerAction,),
    );
  }

  Widget buildBody(BuildContext context){
    var bloc = BlocProvider.of<MatrixBlock>(context);
    return StreamBuilder<Matrix>(
      stream: bloc.matrixStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              GameWidget(snapshot.data,key: gameWidgetKey,),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
  _drawerAction({@required int action}){
    gameWidgetKey.currentState.drawerAction(action: action);
  }
}
