import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:startup_namer_flutter/bloc/bloc.dart';
import 'package:startup_namer_flutter/widgets/tab_selector.dart';
import './bloc/favorites/favorite.dart';
import './bloc/tab/tab.dart';
import './model/app_tab.dart';
import './widgets/names_list.dart';
import './widgets/favorite_names_list.dart';

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
  final TabBloc _tabBloc = TabBloc();
  FavoriteBloc _favoriteBloc;

  @override
  void initState() {
//    _favoriteBloc = FavoriteBloc(nameBloc: BlocProvider.of<NameBloc>(context));
    _favoriteBloc = FavoriteBloc();
    super.initState();
  }

  @override
  void dispose() {
    _tabBloc.dispose();
    super.dispose();
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
                ? NamesList()
                : FavoriteNamesList(),
//                : Center(child: Text(_favoriteBloc.favoriteNames.elementAt(0))),
            bottomNavigationBar: TabSelector(
                activeTab: activeTab,
                onTabSelected: (tab) => _tabBloc.dispatch(UpdateTab(tab))),
          ),
        );
      },
    );
  }
}
