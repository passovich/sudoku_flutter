import 'dart:async';
import 'base_bloc.dart';
import 'package:sudoku/networking/repository.dart';
import 'package:sudoku/calculations/Matrix.dart';
import 'package:rxdart/subjects.dart';

class MatrixBlock extends Bloc{

  final _repo = Repo();

  //final _matrixStream = StreamController<Matrix>();
  final _matrixStream = BehaviorSubject<Matrix>();

  Stream<Matrix> get matrixStream => _matrixStream.stream;

  void fetchItems(){
     _matrixStream.sink.add(_repo.fetchMatrix());
  }

  @override
  void dispose(){
    _matrixStream.close();
  }
}