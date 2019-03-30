import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(primaryColor: Colors.red),
      home: RandomWords()
    );
  }
}

class RandomWordState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final Set<WordPair> _saved = new Set();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'), 
        actions: <Widget>[ 
            new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved,)
          ]),
      body: _buildSuggestions());
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
              (WordPair pair) {
                return new ListTile(title: new Text(pair.asPascalCase, style: _biggerFont)); 
              }
            );
          final List<Widget> divided = ListTile.divideTiles(
                                      context: context, 
                                      tiles: tiles)
                                      .toList();

          return new Scaffold(
            appBar: new AppBar(title: const Text('Saved suggestion')),
            body: new ListView(children: divided)
          );
        }
      )
    );

  }

  Widget _buildRow(WordPair pair) {
    final bool _alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase, style: _biggerFont),
      trailing: new Icon(_alreadySaved ? Icons.favorite : Icons.favorite_border, color: _alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (_alreadySaved) _saved.remove(pair);
          else _saved.add(pair);
        });
      },
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        if (index >=_suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordState createState() => new RandomWordState();
}