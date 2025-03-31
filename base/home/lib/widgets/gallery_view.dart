import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ui/tools/view_tools.dart';
import 'package:ui/widgets/custom_button.dart';

class GalleryView extends StatefulWidget {
  GalleryView(
      {Key? key,
        required this.onImage,})
      : super(key: key);

  final Function(InputImage inputImage) onImage;

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  File? _image;
  String? _path;
  ImagePicker? _imagePicker;

  @override
  void initState() {
    super.initState();

    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return _galleryBody(context);
  }

  Widget _galleryBody(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: 20,),
          if(_image != null)
            SizedBox(
              height: ViewTools.getPercentageHeight(context, 40),
              width: ViewTools.getPercentageWidth(context, 80),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.file(_image!),
                ],
              ),
            ),
          if(_image == null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomButton(
                text: context.l10n.aiGallery,
                onPressed: () => _getImage(ImageSource.gallery),
              ),
            ),
          if(_image == null)
            const SizedBox(height: 5,),
          if(_image == null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomButton(
                text: context.l10n.aiCamera,
                onPressed: () => _getImage(ImageSource.camera),
              ),
            ),
          const SizedBox(height: 20,),
        ]
    );
  }

  Future _getImage(ImageSource source) async {
    setState(() {
      _image = null;
      _path = null;
    });
    final pickedFile = await _imagePicker?.pickImage(source: source);
    if (pickedFile != null) {
      _processFile(pickedFile.path);
    }
  }

  Future _processFile(String path) async {
    setState(() {
      _image = File(path);
    });
    _path = path;
    final inputImage = InputImage.fromFilePath(path);
    Future.delayed(const Duration(seconds: 1), () {
      widget.onImage(inputImage);
    });
  }

  Future<String> getAssetPath(String asset) async {
    final path = await getLocalPath(asset);
    await Directory(dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(asset);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }

  Future<String> getLocalPath(String path) async {
    return '${(await getApplicationSupportDirectory()).path}/$path';
  }
}
