import 'package:flutter/material.dart';
import 'package:team_queue_app/src/views/widgets/_classes/listable.dart';
import 'package:team_queue_app/src/views/widgets/opacity_toggle.dart';
import 'package:team_queue_app/src/views/widgets/remove_button.dart';

class DropdownSelectionItem<T extends Listable> extends StatelessWidget {
  const DropdownSelectionItem({
    Key? key,
    VoidCallback? onTap,
    VoidCallback? onDelete,
    bool? isEnabled,
    required T value,
  })  : _onTap = onTap,
        _onDelete = onDelete,
        _isEnabled = isEnabled ?? false,
        _value = value,
        super(key: key);

  final VoidCallback? _onTap;
  final VoidCallback? _onDelete;
  final bool _isEnabled;
  final T _value;

  @override
  PopupMenuItem<T> build(BuildContext context) {
    final VoidCallback? ownOnDelete = _onDelete;
    return PopupMenuItem(
      onTap: _onTap,
      child: Stack(
        children: [
          Positioned.fill(
            child: OpacityToggle(
              isEnabled: _isEnabled,
              child: Text(_value.name),
            ),
          ),
          if (ownOnDelete != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Align(
                alignment: Alignment.centerRight,
                child: RemoveButton(onTap: ownOnDelete),
              ),
            ),
        ],
      ),
    );
  }
}
