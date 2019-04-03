import 'package:equatable/equatable.dart';
import 'name.dart';

abstract class NameState extends Equatable {
  NameState([List props = const []]) : super([props]);
}

class NameUnitialized extends NameState {
  String toString() => "NameUnitialized";
}

class NameLoaded extends NameState {
  final List<Name> names;

  NameLoaded({this.names}) : super([ names ]);

  NameLoaded copyWith({List<Name> names}) {
    return NameLoaded(names: names ?? this.names);
  }

  String toString() => "NameLoaded { names: ${names.length} }";
}