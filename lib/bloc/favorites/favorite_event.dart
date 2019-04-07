import 'package:equatable/equatable.dart';
import 'package:startup_namer_flutter/model/name.dart';

class FavoriteEvent extends Equatable {
  FavoriteEvent([List props = const[]]) : super(props);
}

class UpdateFavorites extends FavoriteEvent {
  List<Name> favoriteNames;

  UpdateFavorites(this.favoriteNames) : super([favoriteNames]);
  
  toString() => 'UpdateFavorites';
}