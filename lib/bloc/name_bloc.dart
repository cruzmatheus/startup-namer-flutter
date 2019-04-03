import 'package:bloc/bloc.dart';

import 'package:startup_namer_flutter/bloc/bloc.dart';
import 'package:startup_namer_flutter/model/name.dart';
import 'package:english_words/english_words.dart';
import 'package:rxdart/rxdart.dart';

class NameBloc extends Bloc<NameEvent, NameState> {
  
  @override
  NameState get initialState => NameUnitialized();

  @override
  Stream<NameEvent> transform(Stream<NameEvent> events) {
    return (events as Observable<NameEvent>)
        .debounce(Duration(milliseconds: 500));
  }

  @override
  Stream<NameState> mapEventToState(NameEvent event) async* {
    if (event is Fetch) {
      if (currentState is NameUnitialized) {
        final names = await _fetchNames();
        yield NameLoaded(names: names);
      } else if (currentState is NameLoaded) {
        final names = await _fetchNames();
        yield NameLoaded(names: (currentState as NameLoaded).names + names);
      }
    }
  }

  Future<List<Name>> _fetchNames() async {
    List<Name> names = List();
    generateWordPairs().take(20).forEach((name) {
      names.add(Name(name: name.asPascalCase));
    });
    return names;
  }

}