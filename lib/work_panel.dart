import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'panel.dart';

class SizedFileImage {
  final Size size;
  final FileImage fileImage;

  SizedFileImage(this.fileImage, this.size);
}

class WorkPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WorkPanelState();
}

class _WorkPanelState extends State<WorkPanel> {
  List<SizedFileImage> images = [];

  _WorkPanelState() {
    // updateFiles();

    listDir("/PhotoLibrary");
  }

  Future listDir(String folderPath) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    print(tempPath);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    print(appDocPath);

    var directory = new Directory(appDocPath + folderPath);
    print(directory);

    var exists = await directory.exists();
    if (!exists) {
      directory.createSync(recursive: true);
    }
    directory
        .list(recursive: true, followLinks: true)
        .listen((FileSystemEntity entity) async {
      if (FileSystemEntity.isFileSync(entity.path)) {
        if (RegExp(r"[jpg|png]$").hasMatch(entity.path)) {
          print(entity.path + " is image file");
          ;
          var image = FileImage(entity);
          final size = ImageSizGetter.getSize(entity);
          this.setState(() {
            images:
            images.add(SizedFileImage(image, size));
          });
        }
      } else {
        // await listDir(entity.path);
      }
      print(entity.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(images);

    var listView = ListView.builder(
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          var sizedFileImage = images[index];
          return Row(children: [
            Image(
              image: sizedFileImage.fileImage,
              height: 200,
            ),
            Text(sizedFileImage.size.toString())
          ]);
        });

    return Panel(PanelType.PanelTypeSection,
        title: 'work panel',
        child: Column(children: [
          Text(
            'yyy112',
          ),
          Expanded(child: listView)
        ]));
  }
}
