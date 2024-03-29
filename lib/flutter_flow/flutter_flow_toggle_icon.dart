/*
 * Copyright (c) 2021. Scarla
 */

import 'package:flutter/material.dart';

/// Widget d'une icône basculable
class ToggleIcon extends StatelessWidget {
  const ToggleIcon({
    @required this.value,
    @required this.onPressed,
    @required this.onIcon,
    @required this.offIcon,
  });

  final bool value;
  final Function() onPressed;
  final Icon onIcon;
  final Icon offIcon;

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        icon: value ? onIcon : offIcon,
      );
}
