import 'package:bloc/bloc.dart';
import 'package:startup_namer_flutter/bloc/favorites/favorite.dart';
import '../names/names.dart';
import 'package:meta/meta.dart';
import 'dart:async';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final NameBloc nameBloc;
  StreamSubscription namesSubscription;

  FavoriteBloc({@required this.nameBloc}) {
    namesSubscription = nameBloc.state.listen((state) {
      if (state is NameLoaded) {
        dispatch(UpdateFavorites((nameBloc.currentState as NameLoaded).names));
      }
    });
  }

  @override
  FavoriteState get initialState => nameBloc.currentState is NameLoaded 
                                  ? FavoriteState((nameBloc.currentState as NameLoaded).names) 
                                  : FavoriteState([]);

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is UpdateFavorites) {
      yield FavoriteState((nameBloc as NameLoaded).names);
    }
  }

  @override
  void dispose() {
    namesSubscription.cancel();
    super.dispose();
  }
  
}