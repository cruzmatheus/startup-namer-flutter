import 'package:equatable/equatable.dart';
import 'package:startup_namer_flutter/model/name.dart';

abstract class NameState extends Equatable {
  NameState([List props = const []]) : super([props]);
}

class NameUnitialized extends NameState {
  String toString() => "NameUnitialized";
}

class NameLoaded extends NameState {
  final List<Name> names;

  NameLoaded({this.names}) : super([ names]);

  String toString() => "NameLoaded { names: ${names.length} }";
}