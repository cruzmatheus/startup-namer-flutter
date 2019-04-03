import 'package:equatable/equatable.dart';

class Name  extends Equatable {
  final String name;

  Name({ this.name }) : super([ name ]);

  @override
  String toString() => "Task { name: $name }";
}