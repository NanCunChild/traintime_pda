/*
Copyright 2023 SuperBart

This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.

Additionaly, for this file,

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:watermeter/page/classtable/class_table_view/class_card.dart';
import 'package:watermeter/page/classtable/class_table_view/classtable_date_row.dart';
import 'package:watermeter/page/classtable/classtable_constant.dart';
import 'package:watermeter/page/classtable/classtable_state.dart';

/// THe classtable view, the way the the classtable sheet rendered.
class ClassTableView extends StatefulWidget {
  final int index;
  const ClassTableView({
    super.key,
    required this.index,
  });

  @override
  State<ClassTableView> createState() => _ClassTableViewState();
}

class _ClassTableViewState extends State<ClassTableView> {
  late ClassTableState classTableState;
  late Size mediaQuerySize;

  /// The height is suitable to show 1-8 class, 9-10 are hidden at the bottom.
  double classTableContentHeight(int count) =>
      count *
      (mediaQuerySize.height < 800
          ? mediaQuerySize.height * 0.85
          : mediaQuerySize.height -
              topRowHeightBig -
              (mediaQuerySize.width / mediaQuerySize.height >= 1.20
                  ? midRowHeightHorizontal
                  : midRowHeightVertical)) /
      10;

  /// The class table are divided into 8 rows, the leftest row is the index row.
  List<Widget> classSubRow(int index) {
    if (index != 0) {
      List<Widget> thisRow = [];

      /// Choice the day and render it!
      for (int i = 0; i < 10; ++i) {
        /// Places in the onTable array.
        int places =
            classTableState.pretendLayout[widget.index][index - 1][i].first;

        /// The length to render.
        int count = 1;
        Set<int> conflict =
            classTableState.pretendLayout[widget.index][index - 1][i].toSet();

        /// Decide the length to render. i limit the end.
        while (i < 9 &&
            classTableState
                    .pretendLayout[widget.index][index - 1][i + 1].first ==
                places) {
          count++;
          i++;
          conflict.addAll(classTableState.pretendLayout[widget.index][index - 1]
                  [i]
              .toSet());
        }

        /// Do not include empty spaces...
        conflict.remove(-1);

        /// Generate the row.
        thisRow.add(ClassCard(
          index: places,
          height: classTableContentHeight(count),
          conflict: conflict,
        ));
      }

      return thisRow;
    } else {
      /// Leftest side, the index array.
      return List.generate(
        10,
        (index) => SizedBox(
          width: leftRow,
          height: classTableContentHeight(1),
          child: Center(
            child: AutoSizeText(
              "${index + 1}",
              group: AutoSizeGroup(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    classTableState = ClassTableState.of(context)!;
    mediaQuerySize = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// The main class table.
        ClassTableDateRow(
          firstDay: ClassTableState.of(context)!.startDay.add(
                Duration(days: widget.index * 7),
              ),
        ),

        /// The rest of the table.
        Expanded(
          child: SingleChildScrollView(
            child: Row(
              children: List.generate(
                8,
                (i) => Container(
                  color: i == 0 ? Colors.grey.shade200.withOpacity(0.75) : null,
                  child: SizedBox(
                    width:
                        i > 0 ? (mediaQuerySize.width - leftRow) / 7 : leftRow,
                    child: Column(
                      children: classSubRow(i),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}