import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_app/screen/homepage/homepage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  static const routName = '/image-picker';

  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImageInput> {
  File? _imageItem;

  Future<void>_uploadImage(ImageSource imageSource) async {
    final picker = ImagePicker();
    final imageFile = await ImagePicker().pickImage(source: imageSource);
    setState(() {
      if (imageFile != null) {
        _imageItem = File(imageFile.path);
      } else {
        print('No image selected.');
      }
      _imageItem = File(imageFile!.path);
    }
    );
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile!.path);
    final savedImage = await imageFile.saveTo('${appDir.path}/$fileName');
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Image'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(border: Border.all(width: 2)),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.add),
              onPressed: () {
                _uploadImage(ImageSource.camera);
              },
              label: Text('Upload via Camera'),
            ),
            FlatButton.icon(
              icon: Icon(Icons.add),
              onPressed: () {
                _uploadImage(ImageSource.gallery);
              },
              label: Text('Upload via Gallery'),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                width: 100,
                height: 400,
                child: _imageItem == null
                    ? Text('No Image Selected',textAlign: TextAlign.center,)
                    : Image.file(
                        _imageItem!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            if(_imageItem !=null)
            FlatButton.icon(
                onPressed: () {

                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                }, icon: Icon(Icons.done), label: Text('Upload'),

            )
          ],
        )),
      ),
    );
  }
}
