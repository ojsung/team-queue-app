import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'quarter_screen_panel.dart';

class QuarterScreenCard extends StatelessWidget {
  const QuarterScreenCard(
      {Key? key,
      required Widget header,
      required Widget body,
      double? height,
      double? width})
      : _header = header,
        _body = body,
        _height = height,
        _width = width,
        super(key: key);
  final double? _height;
  final double? _width;
  final Widget _header;
  final Widget _body;

  @override
  Widget build(BuildContext context) {
    return QuarterScreenPanel(
      height: _height,
      width: _width,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .1,
            child: _header,
          ),
          Expanded(
            child: _body,
          ),
        ],
      ),
    );
  }
}
