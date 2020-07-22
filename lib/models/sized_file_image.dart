
import 'dart:core';

import 'package:flutter/material.dart';

class SizedFileImage {
  final Size size;
  final FileImage fileImage;
  final String appDocPath;
  bool _isValid;
  String _folder;
  String _file;

  String get folder => _folder;
  String get file => _file;
  bool get isValid => _isValid;

  SizedFileImage(this.fileImage, this.size, this.appDocPath) {
    var path = fileImage.file.path;
    try {
      var pathfile = path.substring(appDocPath.length+1);
      var ps = pathfile.split('/');
      _folder = ps[1];
      _file = ps[ps.length-1];
      _isValid = true;
    } catch (e) {
      _isValid = false;
    }
  }
}