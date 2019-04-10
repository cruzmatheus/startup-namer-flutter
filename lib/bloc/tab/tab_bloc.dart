import 'package:bloc/bloc.dart';
import 'package:startup_namer_flutter/bloc/tab/tab.dart';
import 'package:startup_namer_flutter/model/app_tab.dart';
import '../bloc.dart';
import 'package:meta/meta.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
   final FavoriteBloc favoriteBloc;

  TabBloc({@required this.favoriteBloc}) { }

  @override
  get initialState => AppTab.names;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      if (event.tab == AppTab.favorites){
        favoriteBloc.dispatch(LoadFavorite());
      }

      yield event.tab;
    }
  }

}