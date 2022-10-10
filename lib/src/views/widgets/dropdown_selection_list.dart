import 'package:flutter/material.dart';
import 'package:team_queue_app/src/views/widgets/_classes/listable.dart';

class DropdownSelectionList<T extends Listable> extends StatefulWidget {
  const DropdownSelectionList({
    Key? key,
    required List<PopupMenuItem<T>> items,
    Widget? child,
  })  : _items = items,
        _child = child ??
            const Icon(
              Icons.playlist_add,
            ),
        super(key: key);

  final List<PopupMenuItem<T>> _items;
  final Widget? _child;

  @override
  State<DropdownSelectionList> createState() => _DropdownSelectionListState();
}

class _DropdownSelectionListState<T extends Listable>
    extends State<DropdownSelectionList<T>> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      itemBuilder: ((context) => widget._items),
      child: widget._child,
    );
  }
}
