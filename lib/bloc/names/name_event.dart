import 'package:equatable/equatable.dart';
import 'package:startup_namer_flutter/model/name.dart';

abstract class NameEvent extends Equatable { }

class Fetch extends NameEvent {

  String toString() => "Fetch";
}

class Favorite extends NameEvent {
  final Name name;

  Favorite(this.name);

  String toString() => "Favorite";
}