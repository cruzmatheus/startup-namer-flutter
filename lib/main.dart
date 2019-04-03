import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_namer_flutter/bloc/bloc.dart';
import 'name.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Startup Name Generator',
        theme: new ThemeData(primaryColor: Colors.red),
        home: Scaffold(
          appBar: AppBar(title: Text('Startup Names Generator')),
          body: HomePage()));
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final NameBloc _nameBloc = NameBloc();

  _HomePageState() {
    // _scrollController.addListener(onScroll());
    _nameBloc.dispatch(Fetch());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _nameBloc,
      builder: (BuildContext context, NameState state) {
        if (state is NameUnitialized) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is NameLoaded) {
          // return Center(child: Text("The state is $state"));
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return NameWidget(name: state.names[index]);
            },
            itemCount: state.names.length
          );
        }
      },
    );
  }
}

class NameWidget extends StatelessWidget {
  final Name name;

  const NameWidget({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '1',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(name.name),
      dense: true,
    );
  }
}
