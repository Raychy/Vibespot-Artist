import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class MultipleTextField extends StatefulWidget {
  final Set<String>? value;
  final Function(Set<String>)? onChanged;
  const MultipleTextField({Key? key, this.value, this.onChanged})
      : super(key: key);

  @override
  _MultipleTextFieldState createState() => _MultipleTextFieldState();
}

class _MultipleTextFieldState extends State<MultipleTextField> {
  late MultiInputCubit _cubit;
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    _cubit = MultiInputCubit();
    super.initState();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MultiInputCubit, Set<String>>(
      bloc: _cubit,
      listener: (context, state) {
        if(widget.onChanged != null) {
          widget.onChanged!(state);
        }
      },
      builder: (context, state) {
        return Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white54, width: .6)),
            child: Column(
              children: [
                TextFormField(
                  focusNode: _focusNode,
                  controller: _textEditingController,
                  onChanged: (value) {
                    print(value);
                    if (value.endsWith(',') && value.length > 2) {
                      _cubit.add(value.substring(0, value.length - 1));
                      _textEditingController.clear();
                    }
                  },
                  onEditingComplete: () {
                    if (_textEditingController.text.isNotEmpty) {
                      _cubit.add(_textEditingController.text);
                      _textEditingController.clear();
                    } else {
                      _focusNode.unfocus();
                    }
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter your text separated by a comma',
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      for (var item in state)
                        Chip(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9)),
                            label: Text(
                              item,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(color: Colors.white),
                            ),
                            onDeleted: () {
                              _cubit.subtract(item);
                            },
                            backgroundColor: Theme.of(context).primaryColorDark)
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }
}

class MultiInputCubit extends Cubit<Set<String>> {
  MultiInputCubit() : super(<String>{});

  add(String value) {
    emit(state.union(<String>{value}));
  }

  subtract(String value) {
    emit(state.difference(<String>{value}));
  }
}
