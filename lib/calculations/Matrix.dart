import 'dart:core';
import 'dart:math';

class Matrix {
  int _difficulty;
//  int a = 3;
  //Базовая матрица
  var basicMatrix = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 2, 4, 8, 7, 9, 5, 6, 3, 1],
    [0, 5, 1, 7, 6, 2, 3, 9, 8, 4],
    [0, 6, 3, 9, 1, 8, 4, 7, 5, 2],
    [0, 8, 9, 6, 4, 5, 2, 1, 7, 3],
    [0, 3, 7, 2, 9, 1, 8, 4, 6, 5],
    [0, 1, 5, 4, 3, 6, 7, 2, 9, 8],
    [0, 9, 6, 5, 2, 3, 1, 8, 4, 7],
    [0, 4, 8, 1, 5, 7, 6, 3, 2, 9],
    [0, 7, 2, 3, 8, 4, 9, 5, 1, 6]
];
  //решенная матрица
  var solvedMatrix = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 2, 4, 8, 7, 9, 5, 6, 3, 1],
    [0, 5, 1, 7, 6, 2, 3, 9, 8, 4],
    [0, 6, 3, 9, 1, 8, 4, 7, 5, 2],
    [0, 8, 9, 6, 4, 5, 2, 1, 7, 3],
    [0, 3, 7, 2, 9, 1, 8, 4, 6, 5],
    [0, 1, 5, 4, 3, 6, 7, 2, 9, 8],
    [0, 9, 6, 5, 2, 3, 1, 8, 4, 7],
    [0, 4, 8, 1, 5, 7, 6, 3, 2, 9],
    [0, 7, 2, 3, 8, 4, 9, 5, 1, 6]
  ];
  //матрица изменяемая пользователем
  var matrix = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 4, 0, 7, 0, 5, 0, 0, 0],
    [0, 0, 1, 7, 6, 2, 0, 0, 0, 0],
    [0, 6, 0, 9, 0, 0, 4, 7, 0, 2],
    [0, 0, 9, 0, 0, 0, 0, 0, 7, 3],
    [0, 3, 0, 2, 9, 0, 8, 4, 0, 5],
    [0, 1, 5, 0, 0, 0, 0, 0, 9, 0],
    [0, 9, 0, 5, 2, 0, 0, 8, 0, 7],
    [0, 0, 0, 0, 0, 7, 6, 3, 2, 0],
    [0, 0, 0, 0, 8, 0, 9, 0, 1, 0]
  ];
  //матрица,которую нужно решить(неизменная во время игры)
  var taskMatrix = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 4, 0, 7, 0, 5, 0, 0, 0],
    [0, 0, 1, 7, 6, 2, 0, 0, 0, 0],
    [0, 6, 0, 9, 0, 0, 4, 7, 0, 2],
    [0, 0, 9, 0, 0, 0, 0, 0, 7, 3],
    [0, 3, 0, 2, 9, 0, 8, 4, 0, 5],
    [0, 1, 5, 0, 0, 0, 0, 0, 9, 0],
    [0, 9, 0, 5, 2, 0, 0, 8, 0, 7],
    [0, 0, 0, 0, 0, 7, 6, 3, 2, 0],
    [0, 0, 0, 0, 8, 0, 9, 0, 1, 0]
  ];
  List auxMatrix = List();
  var undoMatrix = List<List<List<List>>>();
  int undoCounter = 0;

   Matrix(int difficulty){
     print('--Matrix construktor--');
     //инициализируем auxMatrix
     for (int i = 0; i < 10; i++){
       auxMatrix.add(List());
       for (int j = 0; j < 10; j++){
         auxMatrix[i].add(List());
         for (int k = 0; k < 10; k++){
           auxMatrix[i][j].add(0);
         }
       }
     }
    //генерируем новые массивы матриц
    this._difficulty = difficulty;
    getSolvedMatrix(basicMatrix, solvedMatrix);
    getNonSolvedMatrix(basicMatrix, solvedMatrix, matrix);
    generateAuxMatrix(matrix, auxMatrix);
    copy2DMatrix(matrix, taskMatrix);
    undoCounter = 0;
   // generateZeroAuxMatrix(matrix, auxMatrix);
  }
  void undoSet(var auxMatrix,var undoMatrix){
    //сдвигаем массивы auxMatrix в массиве undoMatrix вправо
    for (int y = 8; y >= 0; y--){
      for (int i = 0; i < 10; i++){
        for(int j = 0; j < 10; j++){
          for(int k = 0; k < 10; k++){
            undoMatrix[y+1][i][j][k] = undoMatrix[y][i][j][k];
          }
        }
      }
    }
    //в нулевой элемент записываем новый auxMatrix
    for (int i = 0; i < 10; i++){
      for(int j = 0; j < 10; j++){
        for(int k = 0; k < 10; k++){
          undoMatrix[0][i][j][k] = auxMatrix[i][j][k];
        }
      }
    }
    if (undoCounter < 10) undoCounter++;
   // print("undoSet, undo counter = $undoCounter");
    //Log.d(TAG, toString(auxMatrix) );
  }
  void undoGet(var auxMatrix,var undoMatrix){
    if (undoCounter>0) {
      //берём auxMatrix из нулевой ячейки
      for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 10; j++) {
          for (int k = 0; k < 10; k++) {
            auxMatrix[i][j][k] = undoMatrix[0][i][j][k];
          }
        }
      }
      for (int y = 1; y < 10; y++) {
        for (int i = 0; i < 10; i++) {
          for (int j = 0; j < 10; j++) {
            for (int k = 0; k < 10; k++) {
              undoMatrix[y - 1][i][j][k] = undoMatrix[y][i][j][k];
            }
          }
        }
      }
    undoCounter--;
   // print("undoGet, undo counter = $undoCounter");
    //Log.d(TAG,toString(auxMatrix) );
    }
  }
  static void lineProcess (var auxMatrix,int rowNumber){
    //удалить лишние элементы доп матрицы в указанной строке
    for (int i = 1; i <= 9; i++){
      if (auxMatrix[rowNumber][i][0] != 0){
        for (int j = 1; j <= 9; j++){
          if (j != i) auxMatrix[rowNumber][j][auxMatrix[rowNumber][i][0]] = 0;
        }
      }
    }
  }
  static void lineProcessAll(var auxMatrix){
    //Удалить лишние элементиы доп матрицы во всех строках
    for (int i = 1; i <= 9; i++){
      lineProcess(auxMatrix, i);
    }
  }
  static void columnProcess (var auxMatrix, int columnNumber){
    //удалить лишние элементы доп матрицы в указанном столбце
    for (int i = 1; i <= 9; i++){
      if (auxMatrix[i][columnNumber][0] != 0){
        for (int j = 1; j <= 9; j++){
          if (j != i) auxMatrix[j][columnNumber][auxMatrix[i][columnNumber][0]] = 0;
        }
      }
    }
  }
  static void columnProcessAll(var auxMatrix){
    //Удалить лишние элементиы доп матрицы во всех столбцах
    for (int i = 1; i <= 9; i++){
      columnProcess(auxMatrix, i);
    }
  }
  static void squareProcess(var auxMatrix, int iStart, int jStart){
    //Удалить лишние элементы в квадрате с указанным началом координат
    int element = 0;
    for (int i = iStart; i <= iStart+2; i++){
      for (int j = jStart; j <= jStart + 2; j++){
        if (auxMatrix[i][j][0] != 0){
          element = auxMatrix[i][j][0];
          for (int k = iStart; k <= iStart + 2; k++){
            for (int l = jStart; l <= jStart + 2; l++){
              if ((k != i)||(l != j)) auxMatrix[k][l][element] = 0;
            }
          }
        }
      }
    }
  }
  static void squareProcessAll(var auxMatrix){
    //Удаляем лишние элементы во всех квадратах
    for(int i = 1; i <= 7; i += 3){
      for(int j = 1; j <= 7; j += 3){
        squareProcess(auxMatrix, i, j);
      }
    }
  }
  static void auxMatrixProcessAll (var auxMatrix){
    // решение судоку из полной дополнительной матрицы
    int counter = 0;
    List tempMatrix = List();
    for (int i = 0; i < 10; i++){
      tempMatrix.add(List());
      for (int j = 0; j < 10; j++){
        tempMatrix[i].add(List());
        for (int k = 0; k < 10; k++){
          tempMatrix[i][j].add(0);
        }
      }
    }
    copy3DMatrix(auxMatrix, tempMatrix);
    bool comparation = false;
    //работаем над матрицей, пока есть изменения от логики
    while (!comparation){
      copy3DMatrix(auxMatrix, tempMatrix);
      columnProcessAll(auxMatrix);
      lineProcessAll(auxMatrix);
      squareProcessAll(auxMatrix);
      auxMatrixCheck(auxMatrix);
      counter++;
      comparation = compare3DMatrix(auxMatrix, tempMatrix);
    }
  }
  static bool auxMatrixCheck(var auxMatrix){
    //Проверка доп матрицы на вычисленные элементы
    int counter = 0;
    int element = 0;
    for(int i = 1; i <= 9; i++){
      for(int j = 1; j <= 9; j++){
        if (auxMatrix[i][j][0] == 0){
          for(int k = 1; k <= 9; k++){
            if (auxMatrix[i][j][k] == 0) counter++;
            else element = auxMatrix[i][j][k];
          }
          if (counter == 8) auxMatrix[i][j][0] = element;
          if (counter == 9) return false;
          counter = 0;
        }
      }
    }
    return true;
  }
  static void copy2DMatrix(var matrix1,var matrix2){
    for (int i = 0; i < 10; i++){
      for (int j = 0; j < 10; j++){
        matrix2[i][j] = matrix1[i][j];
      }
    }
  }
  static void copy3DMatrix(var matrix1,var matrix2){
    // копирывание матрицы 1 в матрицу 2
    for (int i = 0; i < 10; i++){
      for (int j = 0; j<10; j++){
        for (int k = 0; k < 10; k++){
          matrix2[i][j][k] = matrix1[i][j][k];
        }
      }
    }
  }
  static bool compare3DMatrix(var matrix1, var matrix2){
  bool result = true;
    for (int i = 0; i < 10; i++){
      for (int j = 0; j < 10; j++){
        for (int k = 0; k < 10; k++){
          if (matrix2[i][j][k] != matrix1[i][j][k]) result = false;
        }
      }
    }
  return result;
  }
  static void auxMatrixGenerate(var matrix,var auxMatrix){
    for(int i = 1; i <= 9; i++){
      for(int j = 1; j <= 9; j++){
        if (matrix[i][j] != 0){
          auxMatrix[i][j][matrix[i][j]] = matrix[i][j];
          auxMatrix[i][j][0] = matrix[i][j];  //Если 0, то значение ячейки неизвестно
        }else
          for (int k = 1; k <= 9; k++){
            auxMatrix[i][j][k] = k;
          }
      }
    }
  }
  static void generateAuxMatrix(
      var matrix,
      var auxMatrix
  ){
    //формирование полной дополнительной матрицы
   // print("generateAuxMatrix");
    for(int i = 1; i <= 9; i++){
      for(int j = 1; j <= 9; j++){
        if (matrix[i][j] != 0){
          auxMatrix[i][j][0] = matrix[i][j];
        }else auxMatrix[i][j][0] = 0;
      }
    }
  }
  static void generateZeroAuxMatrix(
    var matrix,
    var auxMatrix
  ){
    //формирование чистой дополнительной матрицы
    for(int i = 1; i <= 9; i++){
      for(int j = 1; j <= 9; j++){
        if (matrix[i][j] != 0){
          auxMatrix[i][j][0] = matrix[i][j];
        }else if (auxMatrix[i][j][0] == 0){
          auxMatrix[i][j][0] = -1;
          for (int k = 1; k <= 9; k++){
            auxMatrix[i][j][k] = k;
          }
        }
      }
    }
  }
  static void getSolvedMatrix (
    var basicMatrix,
    var solvedMatrix
  ){
    //перетасовка матрицы (получение новой полной не решенной матрицы)
    copy2DMatrix(basicMatrix, solvedMatrix);
    int counter = Random().nextInt(1000);
    for (int i = 0; i < counter; i++){
      int variant=Random().nextInt(4);
      switch (variant){
        case 0: matrixLineExchange(solvedMatrix); break;
        case 1: matrixColumnExchange(solvedMatrix); break;
        case 2: matrixTripleLineExchange(solvedMatrix); break;
        case 3: matrixTripleColumnExchange(solvedMatrix); break;
      }
    }
  }
  static void matrixLineExchange (var baseMatrix){
    //перестановка двух случайных строк в матрице судоку
    int numberLine = Random().nextInt(3);
    int numberGroupLine = Random().nextInt(3);
    int temp;
    for (int i = 1; i <= 9; i++){
      if (numberLine == 0){
        temp = baseMatrix[1+numberGroupLine*3][i];
        baseMatrix[1+numberGroupLine*3][i] = baseMatrix[2+numberGroupLine*3][i];
        baseMatrix[2+numberGroupLine*3][i] = temp;
      }
      if (numberLine == 1){
        temp = baseMatrix[2+numberGroupLine*3][i];
        baseMatrix[2+numberGroupLine*3][i] = baseMatrix[3+numberGroupLine*3][i];
        baseMatrix[3+numberGroupLine*3][i] = temp;
      }
      if (numberLine == 2){
        temp = baseMatrix[1+numberGroupLine*3][i];
        baseMatrix[1+numberGroupLine*3][i] = baseMatrix[3+numberGroupLine*3][i];
        baseMatrix[3+numberGroupLine*3][i] = temp;
      }
    }
  }
  static void matrixColumnExchange ( var baseMatrix){
    //перестановка двух случайных столбцов в матрице судоку
    int numberColumn = Random().nextInt(3);
    int numberGroupColumn = Random().nextInt(3);
    int temp;
    for (int i = 1; i <= 9; i++){
      if (numberColumn == 0){
        temp = baseMatrix[i][1 + numberGroupColumn * 3];
        baseMatrix[i][1 + numberGroupColumn * 3] = baseMatrix[i][2 + numberGroupColumn * 3];
        baseMatrix[i][2 + numberGroupColumn * 3] = temp;
    }
      if (numberColumn == 1){
        temp = baseMatrix[i][2 + numberGroupColumn * 3];
        baseMatrix[i][2 + numberGroupColumn * 3] = baseMatrix[i][3 + numberGroupColumn * 3];
        baseMatrix[i][3 + numberGroupColumn * 3] = temp;
      }
      if (numberColumn == 2){
        temp = baseMatrix[i][1 + numberGroupColumn * 3];
        baseMatrix[i][1 + numberGroupColumn * 3] = baseMatrix[i][3 + numberGroupColumn * 3];
        baseMatrix[i][3 + numberGroupColumn * 3] = temp;
      }
    }
  }
  static void matrixTripleColumnExchange (var baseMatrix){
    //перестановка двух случайных столбцов в матрице судоку
    int numberTripleColumn = Random().nextInt(3);
    int temp;
    for (int i = 1; i <= 9; i++){
      if (numberTripleColumn == 0){
        for(int j = 1; j <= 3; j++){
          temp = baseMatrix[i][j];
          baseMatrix[i][j]=baseMatrix[i][j + 3];
          baseMatrix[i][j + 3]=temp;
        }
      }
      if (numberTripleColumn == 1){
        for(int j = 1; j <= 3;j++){
          temp = baseMatrix[i][j + 3];
          baseMatrix[i][j + 3] = baseMatrix[i][j + 6];
          baseMatrix[i][j + 6]=temp;
        }
      }
      if (numberTripleColumn==2){
        for(int j = 1;j <= 3; j++){
          temp = baseMatrix[i][j];
          baseMatrix[i][j]=baseMatrix[i][j + 6];
          baseMatrix[i][j + 6]=temp;
        }
      }
    }
  }
  static void matrixTripleLineExchange (var baseMatrix){
    //перестановка двух случайных столбцов в матрице судоку
    int numberTripleLine = Random().nextInt(3);
    int temp;
    for (int i = 1; i <= 9; i++){
      if (numberTripleLine == 0){
        for(int j = 1; j <= 3; j++){
          temp = baseMatrix[j][i];
          baseMatrix[j][i] = baseMatrix[j + 3][i];
          baseMatrix[j + 3][i] = temp;
        }
      }
      if (numberTripleLine == 1){
        for(int j = 1; j <= 3; j++){
          temp = baseMatrix[j + 3][i];
          baseMatrix[j + 3][i] = baseMatrix[j + 6][i];
          baseMatrix[j + 6][i] = temp;
        }
      }
      if (numberTripleLine == 2){
        for(int j = 1; j <= 3; j++){
          temp = baseMatrix[j][i];
          baseMatrix[j][i] = baseMatrix[j + 6][i];
          baseMatrix[j + 6][i] = temp;
        }
      }
    }
  }




  //удаление лишних элементов из перетасованной матрицы
  // 30-35 элементов - легко - 51 - 46 удалений
  // 25-30 элементов - средне -56 - 51 удалений
  // 20-25 элементов - сложно - 61 - 56 удалений
  void getNonSolvedMatrix(
    var basicMatrix,
    var solvedMatrix,
    var nonSolvedMatrix
  ){

    getSolvedMatrix(basicMatrix, solvedMatrix);
    List<Element> elements = List<Element>();
    int counter = 0;
    //получаем линейное представление матрицы в виде списка
    for (int i = 1; i <= 9; i++){
      for (int j = 1; j <= 9; j++){
        Element element = new Element(i,j,solvedMatrix[i][j]);
        elements.add(element);
        counter++;
      }
    }
    //пытаемся удалить лишние эл-ты и получить матрицу для решения
    int size = elements.length;
    //Перемешивем случайным образом матрицу (линейный список)
    for (int i = 0; i < 1000; i++){
      int element1, element2;
      Element temp1 = Element(0,0,0);
      Element temp2 = Element(0,0,0);
      element1 = Random().nextInt(size);
      element2 = Random().nextInt(size);
      temp1 = elements[element1];
      temp2 = elements[element2];
      elements[element1] = temp2;
      elements[element2] = temp1;
    }
    List tempMatrix = List() ;
    for (int i = 0; i < 10; i++){
      tempMatrix.add(List());
      for (int j = 0; j < 10; j++){
        tempMatrix[i].add(0);
      }
    }
    List tempAuxMatrix = List();
    for (int i = 0; i < 10; i++){
      tempAuxMatrix.add(List());
      for (int j = 0; j < 10; j++){
        tempAuxMatrix[i].add(List());
        for (int k = 0; k < 10; k++){
          tempAuxMatrix[i][j].add(0);
        }
      }
    }
    //получаем временную матрицу
    copy2DMatrix(solvedMatrix,tempMatrix);
    //пытаемся удалить максимум элементов из временной матрицы
    copy2DMatrix(solvedMatrix,tempMatrix);
    counter=0;
    int maxDeletes=0;
    switch (_difficulty){
      case 1:maxDeletes = 46 + Random().nextInt(6); break;
      case 2:maxDeletes = 51 + Random().nextInt(6); break;
      case 3:maxDeletes = 81; break;
    }
    for (int k = 0; k < elements.length; k++){
      tempMatrix[elements[k].i][elements[k].j] = 0;
        for (int i1 = 0; i1 < 10; i1++){
          for (int j1 = 0; j1 < 10; j1++){
            for (int k1 = 0; k1 < 10; k1++){
              tempAuxMatrix[i1][j1][k1] = 0;
            }
          }
        }
      auxMatrixGenerate(tempMatrix, tempAuxMatrix);
      auxMatrixProcessAll(tempAuxMatrix);
      if ((winnerCheck(tempAuxMatrix, solvedMatrix)) && (counter <= maxDeletes)){
        tempMatrix[elements[k].i][elements[k].j] = 0;
        counter++;
      }
      else tempMatrix[elements[k].i][elements[k].j] = elements[k].element;
    }
  //print("counter = $counter");
  //возвращаемся к двумерной матрице
  copy2DMatrix(tempMatrix,nonSolvedMatrix);
  }
  static bool winnerCheck(var auxMatrix,var solvedMatrix){
    for(int i = 1; i <= 9; i++) {
      for (int j = 1; j <= 9; j++) {
        if (auxMatrix[i][j][0] != solvedMatrix[i][j]){return false;}
      }
    }
  return true;
  }
  static bool checkForEndGame(var auxMatrix){
    for(int i = 1; i <=9; i++) {
      for (int j = 1; j <= 9; j++) {
        if (auxMatrix[i][j][0] <= 0) return false;
      }
    }
  return true;
  }

  static void elementAuxMatrixReset (int iMatrix, int jMatrix,var auxMatrix){
    for (int i = 1; i <= 9; i++){
      auxMatrix[iMatrix][jMatrix][i] = 0;
    }
  }
  static void removeButtonNumberFromAuxMatrix(
    int iMatrix,
    int jMatrix,
    int buttonNumber,
    var auxMatrix
  ){
    for (int i = 1; i <= 9; i++) {
      if (auxMatrix[i][jMatrix][buttonNumber] == buttonNumber) {
        auxMatrix[i][jMatrix][buttonNumber] = 0;    //убрать элемент из строки
      }
      if (auxMatrix[iMatrix][i][buttonNumber] == buttonNumber)
        auxMatrix[iMatrix][i][buttonNumber] = 0;    //убрать элемент из столбца
    }
    //убрать элемент из квадрата
    //было удаление лишних элементов в квадрате
    //сначала нужно определить квадрат
    int i1 = 0, j1 = 0;
    if (iMatrix <= 3) i1 = 1;
    else  if (iMatrix <= 6) i1 = 4;
          else i1 = 7;
    if (jMatrix <= 3) j1 = 1;
    else  if (jMatrix <= 6) j1 = 4;
          else j1 = 7;
    //удалить элемент из квадрата
    for (int i = i1; i <= i1 + 2; i++) {
      for (int j = j1; j <= j1 + 2; j++) {
        if (auxMatrix[i][j][buttonNumber] == buttonNumber)
          auxMatrix[i][j][buttonNumber] = 0;
      }
    }
  }
  static int checkAuxMatrixForLastElement(int iMatrix, int jMatrix, var auxMatrix){
  int counter = 0;
  int element = 0;
  for (int k = 1; k <= 9; k++){
    if (auxMatrix[iMatrix][jMatrix][k] > 0){
      counter++;
      element=auxMatrix[iMatrix][jMatrix][k];
    }
  }
  if (counter == 1) return element;
  else return 0;
  }
//  public static String toString(int auxMatrix[][][]){
//  String stringMatrix="";
//  for (int i = 0; i < 10; i++){
//  for (int j = 0; j < 10; j++){
//  for(int k = 0; k<10; k++){
//  stringMatrix = stringMatrix + Integer.toString(auxMatrix[i][j][k]);
//  }
//  }
//  }
//  return stringMatrix;
//  }
//  public static String toString(int Matrix[][]){
//  String stringMatrix="";
//  for (int i = 0; i < 10; i++){
//  for (int j = 0; j < 10; j++){
//  stringMatrix = stringMatrix + Integer.toString(Matrix[i][j]);
//  }
//  }
//  return stringMatrix;
//  }
//
//  static void fromString(String stringMatrix, var auxMatrix){
//    int counter = 0;
//    for (int i = 0; i < 10; i++){
//      for (int j = 0; j < 10; j++){
//        for(int k = 0; k < 10; k++){
//          Symbol ch = stringMatrix.charAt(counter);
//          if (ch == '-'){auxMatrix[i][j][k] =-1; counter++;}
//          else {auxMatrix[i][j][k] = Character.getNumericValue(ch);}
//          counter++;
//        }
//      }
//    }
//  print("matrix getted from string = "+stringMatrix);
//  }

  static bool checkAllElementsSolved(var auxMatrix){
    for (int i = 0; i < 10; i++){
      for (int j = 0; j < 10; j++){
        if (auxMatrix[i][j][0] <= 0) return false;
      }
    }
    return true;
  }
}

class Element {
  //класс для одного элемента матрицы с координатами (для метода создания)
  int i,j,element;

  Element(this.i,this.j,this.element);
}