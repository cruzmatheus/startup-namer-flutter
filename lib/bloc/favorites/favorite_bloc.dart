import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:startup_namer_flutter/bloc/favorites/favorite.dart';
import 'package:startup_namer_flutter/model/name.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  @override
  FavoriteState get initialState => FavoriteEmptyState();

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is AddFavorite) {
      List<Name> fav = [ Name(name: event.name, isFavorite: true) ];
      yield FavoriteAdded(favoriteNames: currentState.favoriteNames + fav);
    } else if (event is LoadFavorite) {
      yield FavoriteLoaded(favoriteNames: currentState.favoriteNames);
    }

  }

  @override
  void dispose() {
    super.dispose();
  }
  
}