import 'package:bloc/bloc.dart';
import 'package:startup_namer_flutter/bloc/tab/tab.dart';
import 'package:startup_namer_flutter/model/app_tab.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {

  @override
  get initialState => AppTab.names;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }

}