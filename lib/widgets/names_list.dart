import 'package:flutter/material.dart';
import 'package:startup_namer_flutter/model/name.dart';
import '../bloc/names/names.dart';
import '../bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NamesList extends StatefulWidget {
  _NamesListState createState() => _NamesListState();
}

class _NamesListState extends State<NamesList> {
  final NameBloc _nameBloc = NameBloc();
  final _scrollController = ScrollController();
  final _scrollThreshold = 200;

  _NamesListState() {
    _nameBloc.dispatch(Fetch());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _nameBloc.dispatch(Fetch());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _nameBloc,
      builder: (BuildContext context, NameState state) {
        if (state is NameUnitialized) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is NameLoaded) {
          return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.names.length - 1
                    ? BottomLoader()
                    : NameWidget(name: state.names[index], index: index);
              },
              itemCount: state.names.length,
              controller: _scrollController);
        }
      },
    );
  }

}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class NameWidget extends StatelessWidget {
  final Name name;
  final int index;

  const NameWidget({Key key, @required this.name, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${index + 1}'),
      title: Text(name.name),
      dense: true,
    );
  }
}