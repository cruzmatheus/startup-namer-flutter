import 'package:bloc/bloc.dart';

import 'package:startup_namer_flutter/bloc/bloc.dart';
import 'package:startup_namer_flutter/name.dart';
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
      }
      if (currentState is NameLoaded) {
        final names = await _fetchNames();
        yield NameLoaded(names: names);
      }
    }
  }

  Future<List<Name>> _fetchNames() async {
    return List.generate(20, (int index) => Name(name: generateWordPairs().take(1).toString()));
  }

}