import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'dart:math' as math show Random;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

const names = [
  "Mohammed",
  "Ali",
  "Hassan",
  "Ahmed",
  "Omar",
];

extension RnadomElement<T> on Iterable<T> {
    T getRandomElement() => elementAt(math.Random().nextInt(length));
}
extension SecondElemetn<T> on Iterable<T>{
  T getSecondElement() => elementAt(1);
}


class CubitNames extends Cubit<String?>{
  CubitNames() : super(null);
  void pickRnadomName() => emit(names.getRandomElement());
}





class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final CubitNames cubit;

  @override
  void initState() {
    cubit = CubitNames();
    super.initState();
  }
  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: cubit.stream,
          builder: (context, snap) {
            return Center(
              child: Text(
                snap.data.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          cubit.pickRnadomName();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}