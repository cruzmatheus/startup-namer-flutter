import 'package:bloc/bloc.dart';

import 'package:startup_namer_flutter/bloc/bloc.dart';
import 'package:startup_namer_flutter/name.dart';

class NameBloc extends Bloc<NameEvent, NameState> {
  @override
  // TODO: implement initialState
  NameState get initialState => NameUnitialized();

  @override
  Stream<NameState> mapEventToState(NameEvent event) async* {
    if (event is Fetch) {
      if (currentState is NameUnitialized) {
        final names = await _fetchNames();
        yield NameLoaded(names: names);
      }
    }
  }

  Future<List<Name>> _fetchNames() async {
    return List.generate(10, (int index) => Name(name: "teste $index"));
  }

}