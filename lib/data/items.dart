import 'package:sudoku/calculations/Matrix.dart';
import 'item.dart';

class Items{
  Matrix m;
  List item = List();
  bool pen = true;

  Items(this.m){
    print('--Items construktor--');
    for(int i = 0; i < 9; i++) {
      item.add(List<Item>());
      for (int j = 0; j < 9; j++) {
        item[i].add(Item(
          i,j,
          rightSolution: m.solvedMatrix[i+1][j+1],
          taskItem: m.taskMatrix[i+1][j+1],
          auxMatrix0: m.auxMatrix[i+1][j+1][0],
        ));
      }
    }
  }

  getZeroAuxMatrix(){
    print ('--Items.gatZeroAuxMatrix--');
    for(int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (item[i][j].solved==0) {
          item[i][j].solved = -1;
          for (int k = 0; k < 10; k++){
            item[i][j].auxTable[k]=k;
          }
        }
      }
    }
  }
  void buttonPressed(int buttonNumber, int x, int y){
    if (buttonNumber == 0 ){pen = !pen; return;}
    if (pen == true){                   //working with primary table
      if (item[x][y].solved == -1){
        item[x][y].solved = 1;
        item[x][y].userSolution = buttonNumber;
        item[x][y].auxTableReset();
        return;
      }
      if (item[x][y].solved == 0){
        item[x][y].solved = 1;
        item[x][y].userSolution = buttonNumber;
        return;
      }
      if (item[x][y].solved == 1){
        if (item[x][y].userSolution == buttonNumber){
          item[x][y].solved=0;
          item[x][y].userSolution=0;
        } else {
          item[x][y].userSolution = buttonNumber;
        }
        return;
      }
    } else {                            //working with auxTable
      if (item[x][y].solved ==  0){item[x][y].solved = -1;}
      if (item[x][y].solved == -1){
        if (item[x][y].auxTable[buttonNumber]==buttonNumber){
          item[x][y].auxTable[buttonNumber]=0;
        }else{
          item[x][y].auxTable[buttonNumber]=buttonNumber;
        }
      }
    }
  checkAuxMatrixForLastElement(x,y, buttonNumber);
  }
  void checkAuxMatrixForLastElement(int x, int y, int buttonNumber){
    int counter = 0;
    int element = 0;
    for (int i = 0; i < 10; i++){
      if (item[x][y].auxTable[i] > 0){
        counter++;
        element = i;
      }
    }
    if (counter == 1 && element!= buttonNumber) {
      item[x][y].solved = 1;
      item[x][y].userSolution = element;
      item[x][y].auxTableReset();
    }
  }
  bool checkForEndGame(){
    print('--Items.checkForEndGame--');
    for(int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (item[i][j].solved < 1) return false;
      }
    }
    return true;
  }
  bool checkForWinGame(){
    print('Items.checkForWinGame');
    for(int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (item[i][j].solved != 2) {
          if (item[i][j].userSolution != item[i][j].rightSolution) {
            print('checkForWinGAme=false');
            print('i=' + i.toString() + ' j=' + j.toString());
            return false;
          }
        }
      }
    }
    print('checkForWinGAme=true');
    return true;
  }
}

