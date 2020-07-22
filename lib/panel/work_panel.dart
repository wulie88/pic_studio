import 'dart:math';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:pic_studio/panel/panel.dart';
import 'package:pic_studio/common/workstation_model.dart';

class WorkPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WorkPanelState();
}

class _WorkPanelState extends State<WorkPanel> {
  int crossAxisCount = 4;
  double crossAxisSpacing = 5.0;
  double mainAxisSpacing = 5.0;
  TextDirection textDirection = TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return Panel(PanelType.PanelTypeSection,
        title: 'work panel',
        child: Column(children: [
          Text(
            'yyy112',
          ),
          Expanded(
              child: Container(
            color: themeData.backgroundColor,
            child: Consumer<WorkstationModel>(
                builder: (context, model, child) => WaterfallFlow.builder(
                      //cacheExtent: 0.0,
                      //reverse: true,
                      padding: const EdgeInsets.all(5.0),
                      gridDelegate:
                          SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: crossAxisSpacing,
                        mainAxisSpacing: mainAxisSpacing,
                        // collectGarbage: (List<int> garbages) {
                        //   print('collect garbage : $garbages');
                        // },
                        // viewportBuilder: (int firstIndex, int lastIndex) {
                        //   print('viewport : [$firstIndex,$lastIndex]');
                        // },
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        var sizedFileImage = model.currentImages[index];
                        return GestureDetector(
                            onTap: () => Provider.of<WorkstationModel>(context,
                                    listen: false)
                                .currentImage = sizedFileImage,
                            child: Container(
                              color: Theme.of(context).dialogBackgroundColor,
                              child: Image(
                                image: sizedFileImage.fileImage,
                                width: 200,
                              ),
                            ));
                      },
                      itemCount: min(model.currentImages.length, 1000),
                    )),
          ))
        ]));
  }
}
