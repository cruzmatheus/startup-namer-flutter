import 'package:equatable/equatable.dart';
import 'package:startup_namer_flutter/model/name.dart';

class FavoriteState extends Equatable {
  final List<Name> favoriteNames;

  FavoriteState(this.favoriteNames) : super([favoriteNames]);

  String toString() => 'FavoriteState { favoriteNames: $favoriteNames }';
}