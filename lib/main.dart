import 'package:flutter/material.dart';
import 'package:dartea/dartea.dart';

void main() {
  final program = Program<CounterModel, Command, Null>(
    init,
    update,
    view,
  ).withDebugTrace();

  runApp(MyApp(program));
}

class MyApp extends StatelessWidget {
  final Program darteaProgram;
  MyApp(this.darteaProgram);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: darteaProgram.build(key: Key('root_key')),
    );
  }
}

// Model
class CounterModel {
  final int counter;
  CounterModel(this.counter);
  CounterModel copyWith({int counter}) => CounterModel(counter ?? this.counter);

  @override
  String toString() => '$counter';
}

abstract class Command {}

class Increment implements Command {}

class Decrement implements Command {}

// Init
Upd<CounterModel, Command> init() => Upd(CounterModel(0));

// Update
Upd<CounterModel, Command> update(Command cmd, CounterModel model) {
  switch (cmd.runtimeType) {
    case Increment:
      return Upd(model.copyWith(counter: model.counter + 1));
      break;
    case Decrement:
      return Upd(model.copyWith(counter: model.counter - 1));
      break;

    default:
  }
  return Upd(model);
}

// View
Widget view(
    BuildContext context, Dispatch<Command> dispatch, CounterModel model) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Flutter MVU"),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$model',
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => dispatch(Increment()),
      tooltip: 'Increment',
      child: Icon(Icons.add),
    ),
  );
}
