import 'package:flutter/material.dart';

import '../models/game.dart';

typedef IntCallback = Function(int);

class GamesPopup extends StatefulWidget {
  const GamesPopup({
    super.key,
    this.withPlacements = false,
    required this.onSubmitted,
    required this.game,
  });
  final bool withPlacements;
  final IntCallback onSubmitted;
  final Game game;

  @override
  State<GamesPopup> createState() => _GamesPopupState();
}

class _GamesPopupState extends State<GamesPopup> {
  int selectedPlacement = 0;

  @override
  void initState() {
    super.initState();
    if (!widget.withPlacements) {
      selectedPlacement = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _getTitle(widget.withPlacements),
      content: SizedBox(
        width: 400,
        child: _getContent(widget.withPlacements),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _onConfirmPressed,
          child: const Text('Confirm'),
        ),
      ],
    );
  }

  Widget _getTitle(bool withPlacements) {
    return Text('Congratulations,\nyou won at ${widget.game.name}!');
  }

  Widget _getContent(bool withPlacements) {
    if (withPlacements) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Which placement did you achieve?'),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          DropdownMenu<int>(
            dropdownMenuEntries: widget.game.rewards
                .map(
                  (e) => DropdownMenuEntry<int>(
                    value: e.placement,
                    label: e.placement.toString(),
                  ),
                )
                .toList(),
            onSelected: (value) => setState(() {
              selectedPlacement = value ?? 0;
            }),
            enableSearch: true,
            enableFilter: false,
          ),
        ],
      );
    }
    return const Text('Do you want to confirm your win?');
  }

  void _onConfirmPressed() {
    if (selectedPlacement == 0) {
      return;
    }
    widget.onSubmitted(selectedPlacement);
    Navigator.of(context).pop();
  }
}
