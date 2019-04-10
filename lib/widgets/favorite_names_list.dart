import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_namer_flutter/model/name.dart';

import '../bloc/bloc.dart';

class FavoriteNamesList extends StatefulWidget {
  _FavoriteNamesListState createState() => _FavoriteNamesListState();
}

class _FavoriteNamesListState extends State<FavoriteNamesList> {
  FavoriteBloc _favoriteBloc;

  @override
  Widget build(BuildContext context) {
    _favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    return BlocBuilder(
      bloc: _favoriteBloc,
      builder: (BuildContext context, FavoriteState state) {
        if (state is FavoriteEmptyState) {
          return Center(child: Text(state.toString()));
        } else if (state is FavoriteAdded) {
          return Center(child: Text(state.favoriteNames.last.name));
        } else if (state is FavoriteLoaded) {
          return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return FavoriteList(name: state.favoriteNames[index], index: index);
              },
            itemCount: state.favoriteNames.length,
          );
        }
      },
    );
  }

}

class FavoriteList extends StatelessWidget {
  final Name name;
  final int index;

  FavoriteList({Key key, @required this.name, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text("${index+1}"),
      title: Text(name.name)
    );
  }

}