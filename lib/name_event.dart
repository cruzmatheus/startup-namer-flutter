import 'package:equatable/equatable.dart';

abstract class NameEvent extends Equatable { }

class Fetch extends NameEvent {

  String toString() => "Fetch";
}