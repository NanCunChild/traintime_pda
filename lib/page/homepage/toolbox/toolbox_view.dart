// Copyright 2023 BenderBlog Rodriguez and contributors.
// SPDX-License-Identifier: MPL-2.0

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:watermeter/page/homepage/toolbox/cards/creative_card.dart';
import 'package:watermeter/page/homepage/toolbox/cards/empty_classroom_card.dart';
import 'package:watermeter/page/homepage/toolbox/cards/exam_card.dart';
import 'package:watermeter/page/homepage/toolbox/cards/experiment_card.dart';
import 'package:watermeter/page/homepage/toolbox/cards/score_card.dart';
import 'package:watermeter/model/toolbox_addresses.dart';
import 'package:watermeter/page/homepage/toolbox/cards/sport_card.dart';
import 'package:watermeter/page/homepage/toolbox/cards/telebook_card.dart';
import 'package:watermeter/page/homepage/toolbox/cards/webview_card.dart';
import 'package:watermeter/page/homepage/toolbox/cards/xdu_planet_card.dart';

class ToolBoxView extends StatelessWidget {
  final BoxConstraints constraints;
  const ToolBoxView({
    super.key,
    required this.constraints,
  });

  final List<Widget> study = const [
    ScoreCard(),
    ExamCard(),
    EmptyClassroomCard(),
    ExperimentCard(),
    SportCard(),
    WebViewCard(data: WebViewAddresses.calculator),
  ];

  final List<Widget> service = const [
    WebViewCard(data: WebViewAddresses.payment),
    WebViewCard(data: WebViewAddresses.repair),
    WebViewCard(data: WebViewAddresses.network),
    WebViewCard(data: WebViewAddresses.reserve),
    WebViewCard(data: WebViewAddresses.mobileEntry),
    TeleBookCard(),
  ];

  final List<Widget> others = const [
    CreativeCard(),
    XDUPlanetCard(),
    WebViewCard(data: WebViewAddresses.ruisiEntry),
  ];

  @override
  Widget build(BuildContext context) {
    Widget grid(String text, List<Widget> list) => GridView.count(
          crossAxisCount: 4,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: list,
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "小工具",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 12),
        children: [
          grid("学习", study),
          grid("服务", service),
          grid("其他", others),
        ],
      ),
    );
  }
}
