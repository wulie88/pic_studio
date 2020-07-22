import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:image_size_getter/image_size_getter.dart' as isg;
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:pic_studio/panel/panel.dart';
import 'package:pic_studio/models/sized_file_image.dart';

class WorkstationModel extends ChangeNotifier {
  final List<SizedFileImage> images = [];
  String appDocPath;
  int _currentFolderIndex = 0;
  SizedFileImage _currentImage;

  /// 保存了所以的一级目录名称
  List<String> _folders = [];
  /// 目录下面的图片
  Map<String, List<SizedFileImage>> _imagesInFolder = Map();

  WorkstationModel() {
    listDir("/PhotoLibrary");
  }

  SizedFileImage get currentImage => _currentImage;
  List<String> get folders => _folders;
  int get currentFolderIndex => _currentFolderIndex;
  List<SizedFileImage> get currentImages {
    if (_folders.length > 0) {
      String folder = _folders[_currentFolderIndex];
      var images = _imagesInFolder[folder];
      return images;
    }

    return [];
  }

  set currentFolderIndex(int index) {
    _currentFolderIndex = index;
    notifyListeners();
  }

  set currentImage(SizedFileImage newImage) {
    _currentImage = newImage;
    notifyListeners();
  }

  void _appendImageFile(FileImage image, Size size) {
    var sfi = SizedFileImage(
        image, Size(size.width.toDouble(), size.height.toDouble()), appDocPath);
    if (!sfi.isValid) return;

    images.add(sfi);

    if (!_imagesInFolder.containsKey(sfi.folder)) {
      _imagesInFolder[sfi.folder] = [];
    }
    _imagesInFolder[sfi.folder].add(sfi);
    if (!_folders.contains(sfi.folder)) {
      _folders.add(sfi.folder);
    }
  }

  Future listDir(String folderPath) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    print(tempPath);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    this.appDocPath = appDocDir.path;
    print(appDocPath);

    var directory = new Directory(appDocPath + folderPath);
    print(directory);

    var exists = await directory.exists();
    if (!exists) {
      directory.createSync(recursive: true);
    }
    directory.list(recursive: true, followLinks: true).listen(
        (FileSystemEntity entity) async {
      if (FileSystemEntity.isFileSync(entity.path)) {
        final size = isg.ImageSizGetter.getSize(entity);
        if (size.width * size.height != 0) {
          print(entity.path + " is image file");
          _appendImageFile(
              FileImage(entity), Size(size.width.toDouble(), size.height.toDouble()));
        }
      } else {
        // await listDir(entity.path);
      }
      print(entity.path);
    }, onDone: () => {notifyListeners()});
  }
}
