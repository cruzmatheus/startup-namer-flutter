import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';

class FavoriteNamesList extends StatefulWidget {
  _FavoriteNamesListState createState() => _FavoriteNamesListState();
}

class _FavoriteNamesListState extends State<FavoriteNamesList> {
  final FavoriteBloc _favoriteBloc = FavoriteBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _favoriteBloc,
      builder: (BuildContext context, FavoriteState state) {
        if (state is FavoriteEmptyState) {
          return Center(child: Text(state.toString()));
        } else if (state is FavoriteAdded) {
          return Center(child: Text(state.favoriteNames.last.name));
        }
      },
    );
  }

}