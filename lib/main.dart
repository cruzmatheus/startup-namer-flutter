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
  final _scrollThreshold = 200;

  _HomePageState() {
    _scrollController.addListener(_onScroll);
    _nameBloc.dispatch(Fetch());
  }

  @override
  void dispose() {
    _nameBloc.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _nameBloc.dispatch(Fetch());
    }
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
          return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.names.length
                    ? BottomLoader()
                    : NameWidget(name: state.names[index], index: index);
              },
              itemCount: state.names.length,
              controller: _scrollController);
        }
      },
    );
  }
}

class BottomLoader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }

}

class NameWidget extends StatelessWidget {
  final Name name;
  final int index;

  const NameWidget({Key key, @required this.name, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('$index'),
      title: Text(name.name),
      dense: true,
    );
  }
}
