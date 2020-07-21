import 'package:flutter/material.dart';

enum PanelType {
  PanelTypeSide,
  PanelTypeSection,
}

class Panel extends StatelessWidget {
  final String title;
  final PanelType type;
  final Widget child;

  const Panel(this.type, {this.child, Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var container = type == PanelType.PanelTypeSide
        ? Container(
            padding: const EdgeInsets.all(10.0),
            width: 268,
            child: Column(
              children: [
                Text(
                  'yyy112' + title,
                )
              ],
            ),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.black)),
              color: Colors.black87,
            ),
          )
        : Expanded(
            child: child,
          );
    return container;
  }
}
