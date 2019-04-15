import 'package:equatable/equatable.dart';
import 'package:startup_namer_flutter/model/name.dart';

class FavoriteState extends Equatable {
  final List<Name> favoriteNames;

  FavoriteState(this.favoriteNames) : super([favoriteNames]);

  String toString() => 'FavoriteState { favoriteNames: $favoriteNames }';
}

class FavoriteEmptyState extends FavoriteState {

  FavoriteEmptyState() : super([]);

  String toString() => 'FavoriteEmptyState { favoriteNames: [] }';

}

class FavoriteAdded extends FavoriteState {
  final List<Name> favoriteNames;

  FavoriteAdded({this.favoriteNames}) : super(favoriteNames);

  String toString() => "FavoriteAdded: { favoriteNames: ${favoriteNames.length} } ";

}

class FavoriteLoaded extends FavoriteState {
  final List<Name> favoriteNames;

  FavoriteLoaded({this.favoriteNames}) : super(favoriteNames);

  String toString() => "FavoriteLoaded: { favoriteNames: ${favoriteNames.length} } ";

}