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
  final bool hasReachedMax;

  NameLoaded({this.names, this.hasReachedMax}) : super([ names, hasReachedMax ]);

  NameLoaded copyWith({List<Name> names, bool hasReachedMax}) {
    return NameLoaded(names: names ?? this.names, hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  String toString() => "NameLoaded { names: ${names.length}, hasReachedMax: $hasReachedMax }";
}