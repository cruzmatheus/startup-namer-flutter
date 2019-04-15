import 'package:bloc/bloc.dart';
import 'package:english_words/english_words.dart';
import 'package:startup_namer_flutter/bloc/bloc.dart';
import 'package:startup_namer_flutter/model/name.dart';

class NameBloc extends Bloc<NameEvent, NameState> {
  
  @override
  NameState get initialState => NameUnitialized();

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
    } else if (event is Favorite) {
      var namesList = List<Name>.from((currentState as NameLoaded).names);
      int nameIndex = namesList.indexOf(event.name);
      namesList[nameIndex] = Name(name: event.name.name, isFavorite: true);

      yield NameLoaded(names: namesList);
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