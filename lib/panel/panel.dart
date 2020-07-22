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
    var themeData = Theme.of(context);

    var container = type == PanelType.PanelTypeSide
        ? Container(
            padding: const EdgeInsets.all(10.0),
            width: 268,
            child: child != null
                ? child
                : Text(
                    'yyy112' + title,
                  ),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: themeData.dividerColor)),
              color: themeData.primaryColor,
            ),
          )
        : Expanded(
            child: child,
          );
    return container;
  }
}
