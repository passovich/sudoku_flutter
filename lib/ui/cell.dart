import 'package:flutter/material.dart';
import 'package:sudoku/data/settings.dart';
import 'package:sudoku/data/item.dart';

class Cell extends StatefulWidget {
  Item item;
  final void Function(int x,int y) parentAction;

  Cell({Key key,this.item,this.parentAction}): super(key:key);

  @override
  CellState createState() => CellState(item);
}

class CellState extends State<Cell> {
  Item item;

  CellState(this.item);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildCell();
  }

  Widget selectCellType(){
    if (item.solved ==  2){return Text(
      item.rightSolution.toString(),
      style: TextStyle(fontSize: Settings.bigFontSize,fontWeight: FontWeight.bold),
    );
    }
    if (item.solved ==  1){return Text(
       item.userSolution.toString(),
       style: TextStyle(fontSize: Settings.bigFontSize),
      );
    }
    if (item.solved ==  0){return null;}
    if (item.solved == -1){return buildAuxTable();}
    return Text('Error');
  }
  Widget buildCell(){
    return GestureDetector(
      child: Container(
        height: Settings.cellSize,
        width: Settings.cellSize,
        child: Center(child: selectCellType()),
          decoration: BoxDecoration(
            color: item.selected ? Settings.selColor : Settings.cellsColors[item.x][item.y],
            border: Border.all(color: Colors.black, width: 1)
          ),
      ),
      onTap: (){widget.parentAction(item.x,item.y);} ,
    );
  }

  Widget buildAuxTable(){
    var tempColumn = List<Widget>();
    for (int i = 0; i < 3; i++){
      var tempRowList = List<Widget>();
      for (int j = 0; j < 3; j++){
        tempRowList.add(
            Text(
                item.auxTable[j+i*3+1] == 0 ? '  ': item.auxTable[j+i*3+1].toString(),
              style: TextStyle(fontSize: Settings.smallFontSize),
            )
        );
      }
      tempColumn.add(Row(children: tempRowList,mainAxisAlignment: MainAxisAlignment.spaceEvenly,));
    }
    return Column(children: tempColumn, mainAxisAlignment: MainAxisAlignment.spaceEvenly,);
  }

  void update(){setState(() {});}
}
