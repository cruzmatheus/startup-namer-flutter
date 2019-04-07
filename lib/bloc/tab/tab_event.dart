import 'package:equatable/equatable.dart';
import 'package:startup_namer_flutter/model/app_tab.dart';

class TabEvent extends Equatable {
  TabEvent([List props = const[]]) : super(props);
}

class UpdateTab extends TabEvent {
  final AppTab tab;

  UpdateTab(this.tab) : super([tab]);

  toString() => 'UpdateTab { tab: $tab }';
}