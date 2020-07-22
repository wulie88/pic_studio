import 'package:flutter/material.dart';
import 'package:pic_studio/models/sized_file_image.dart';

class ImageInfoWidget extends StatelessWidget {
  final SizedFileImage currentImage;

  const ImageInfoWidget(this.currentImage, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: currentImage.fileImage),
        Text(currentImage.size.toString()),
        TextField(
          autofocus: true,
          decoration: InputDecoration(
              labelText: "说明", hintText: "说明", prefixIcon: Icon(Icons.person)),
        ),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
              labelText: "说明", hintText: "说明", prefixIcon: Icon(Icons.person)),
        ),
      ],
    );
  }
}
