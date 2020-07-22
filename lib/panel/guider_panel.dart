import 'package:flutter/material.dart';
import 'package:pic_studio/common/workstation_model.dart';
import 'package:pic_studio/panel/panel.dart';
import 'package:provider/provider.dart';

class GuiderPanel extends StatelessWidget {

    @override
  Widget build(Object context) {
    var themeData = Theme.of(context);

    return Panel(
      PanelType.PanelTypeSide,
      title: 'guider panel',
      child: Column(
        children: [
          Consumer<WorkstationModel>(
            builder: (context, model, child) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                return RaisedButton(
              color: model.currentFolderIndex == index ? themeData.buttonColor : themeData.primaryColor,
              onPressed: () => Provider.of<WorkstationModel>(context, listen: false).currentFolderIndex = index,
              child: Text(model.folders[index]),
            );
              }, itemCount: model.folders.length,);
            }
          )
        ])
    );
  }
}