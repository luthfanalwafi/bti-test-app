import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPickerModal extends StatefulWidget {
  final File? file;

  const CameraPickerModal({super.key, this.file});

  @override
  State<CameraPickerModal> createState() => _CameraPickerModalState();
}

class _CameraPickerModalState extends State<CameraPickerModal> {
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  void getImageFromGalery() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1200,
      maxWidth: 1200,
      imageQuality: 85,
    );
    if (!mounted) return;
    if (image != null) {
      final file = File(image.path);
      Navigator.pop(context, file);
    } else {
      Navigator.pop(context);
    }
  }

  void getImageFromCamera() async {
    final image = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1200,
      maxWidth: 1200,
      imageQuality: 85,
    );
    if (!mounted) return;
    if (image != null) {
      final file = File(image.path);
      Navigator.pop(context, file);
    } else {
      Navigator.pop(context);
    }
  }

  // void _showImage() async {
  //   Navigator.pop(context);
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (_) => PhotoViewPage(file: widget.file)),
  //   );
  // }

  List<Widget> pickerModal() {
    final theme = Theme.of(context);
    const padding = EdgeInsets.all(15);
    return [
      InkWell(
        radius: 0,
        onTap: getImageFromGalery,
        child: Padding(
          padding: padding,
          child: Center(
            child: Text(
              'Choose from Gallery',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      InkWell(
        radius: 0,
        onTap: getImageFromCamera,
        child: Padding(
          padding: padding,
          child: Center(
            child: Text(
              'Take Photo',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        Material(
          child: SafeArea(
            top: false,
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 15),
              itemCount: pickerModal().length,
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(height: 0),
                );
              },
              itemBuilder: (context, index) {
                return pickerModal()[index];
              },
            ),
          ),
        ),
      ],
    );
  }
}
