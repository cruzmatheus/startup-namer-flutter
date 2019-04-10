import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:startup_namer_flutter/bloc/favorites/favorite.dart';
import 'package:startup_namer_flutter/model/name.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
//  final NameBloc nameBloc;
  StreamSubscription namesSubscription;

//  FavoriteBloc({@required this.nameBloc}) {
//    namesSubscription = nameBloc.state.listen((state) {
//      if (state is NameLoaded) {
//        dispatch(UpdateFavorites((nameBloc.currentState as NameLoaded).names));
//      }
//    });
//  }

  @override
  FavoriteState get initialState => FavoriteEmptyState();
//nameBloc.currentState is NameLoaded
//                                  ? FavoriteState((nameBloc.currentState as NameLoaded).names)
//                                  : FavoriteState([]);

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
//    if (event is UpdateFavorites) {
//      yield FavoriteState((nameBloc as NameLoaded).names);
//    } else
    if (event is AddFavorite) {
      List<Name> fav = [ Name(name: event.name) ];
      yield FavoriteAdded(favoriteNames: currentState.favoriteNames + fav);
    } else if (event is LoadFavorite) {
      yield FavoriteLoaded(favoriteNames: currentState.favoriteNames);
    }

  }

  @override
  void dispose() {
//    namesSubscription.cancel();
    super.dispose();
  }
  
}