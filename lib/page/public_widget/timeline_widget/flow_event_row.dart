// Copyright 2023 BenderBlog Rodriguez and contributors.
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:watermeter/repository/preference.dart' as preference;

@immutable
class FlowEventRow extends StatelessWidget {
  const FlowEventRow({
    super.key,
    required this.child,
    required this.isTitle,
  });

  final Widget child;
  final bool isTitle;

  double get circleRadius => 6;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: preference.isPhone ? 8 : 20 - circleRadius,
            ),
            child: Container(
              width: circleRadius * 2,
              height: circleRadius * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isTitle
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
              ),
            ),
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
