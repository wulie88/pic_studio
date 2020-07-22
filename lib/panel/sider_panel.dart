import 'package:flutter/material.dart';
import 'package:pic_studio/common/workstation_model.dart';
import 'package:pic_studio/panel/image_info_widget.dart';
import 'package:pic_studio/panel/panel.dart';
import 'package:provider/provider.dart';

/**
 * 右边侧边栏面板 
 */
class SiderPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SiderPanelState();
}

class _SiderPanelState extends State<SiderPanel> {
  bool _isImageInfoMode = false;

  void changeMode(bool mode) {
    setState(() {
      _isImageInfoMode = mode;
    });
  }

  @override
  Widget build(Object context) {
    var themeData = Theme.of(context);

    return Panel(
      PanelType.PanelTypeSide,
      title: 'sider panel',
      child: Column(
        children: [
          Wrap(direction: Axis.horizontal, children: <Widget>[
            RaisedButton(
              color: !_isImageInfoMode ? themeData.buttonColor : themeData.primaryColor,
              onPressed: () => changeMode(false),
              child: Text("分类详情"),
            ),
            RaisedButton(
              color: _isImageInfoMode ? themeData.buttonColor : themeData.primaryColor,
              onPressed: () => changeMode(true),
              child: Text("已选定"),
            ),
          ]),
          _isImageInfoMode ? Consumer<WorkstationModel>(
            builder: (context, model, child) {
              return model.currentImage != null ? ImageInfoWidget(model.currentImage) : Placeholder();
            }
          ): Text('分类统计:xxxx')
        ],
      ),
    );
  }
}
