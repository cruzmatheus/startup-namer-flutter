import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:startup_namer_flutter/bloc/bloc.dart';
import 'model/name.dart';
import './bloc/favorites/favorite.dart';
import './bloc/tab/tab.dart';
import './model/app_tab.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final nameBloc = NameBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: nameBloc,
        child: MaterialApp(
            title: 'Startup Name Generator',
            theme: new ThemeData(primaryColor: Colors.red),
            home: Scaffold(
                appBar: AppBar(title: Text('Startup Names Generator')),
                body: HomePage())));
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final NameBloc _nameBloc = NameBloc();
  final TabBloc _tabBloc = TabBloc();

  FavoriteBloc _favoriteBloc;
  final _scrollThreshold = 200;

  _HomePageState() {
    _scrollController.addListener(_onScroll);
    _nameBloc.dispatch(Fetch());
  }

  @override
  void initState() {
    _favoriteBloc = FavoriteBloc(nameBloc: BlocProvider.of<NameBloc>(context));
    super.initState();
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
      bloc: _tabBloc,
      builder: (BuildContext context, AppTab activeTab) {
        return BlocProviderTree(
          blocProviders: [
            BlocProvider<TabBloc>(bloc: _tabBloc),
            BlocProvider<FavoriteBloc>(bloc: _favoriteBloc)
          ],
          child: Scaffold(
            body: activeTab == AppTab.names
                ? Center(child: Text("First tab"))
                : Center(child: Text("Second tab")),
          ),
        );
      },
    );
    // return BlocBuilder(
    //   bloc: _nameBloc,
    //   builder: (BuildContext context, NameState state) {
    //     if (state is NameUnitialized) {
    //       return Center(child: CircularProgressIndicator());
    //     }

    //     if (state is NameLoaded) {
    //       return ListView.builder(
    //           itemBuilder: (BuildContext context, int index) {
    //             return index >= state.names.length - 1
    //                 ? BottomLoader()
    //                 : NameWidget(name: state.names[index], index: index);
    //           },
    //           itemCount: state.names.length,
    //           controller: _scrollController);
    //     }
    //   },
    // );
  }
}

class BottomLoader extends StatelessWidget {
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

  const NameWidget({Key key, @required this.name, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${index + 1}'),
      title: Text(name.name),
      dense: true,
    );
  }
}
