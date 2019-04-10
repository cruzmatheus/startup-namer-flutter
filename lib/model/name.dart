import 'package:equatable/equatable.dart';

class Name  extends Equatable {
  final String name;
  bool isFavorite;

  Name({ this.name, this.isFavorite = false }) : super([ name, isFavorite ]);

  @override
  String toString() => "Task { name: $name, isFavorite $isFavorite }";
}