import 'package:flutter/material.dart';
import 'package:sudoku/block/fetch_matrix_block.dart';
import 'ui/home_page_screen.dart';
import 'package:sudoku/block/block_provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
        bloc: MatrixBlock(),
        child:
        MaterialApp(
          title: 'News application',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomeScreen(),
      ),
    );
  }
}
