import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File file;

  captureImageWithCamera()async{
    Navigator.pop(context);
    PickedFile picked = await ImagePicker().getImage(
            preferredCameraDevice: CameraDevice.front, 
            source: ImageSource.camera,
            maxHeight: 680.0);
        setState(() {
          this.file = File(picked.path);
        });
    /*PickedFile  imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 680.0,
      maxWidth: 970,
    );
    setState(() {
      this.file = imageFile;
    });*/
  }

  takeImage(nContext){
    return showDialog(
      context: nContext, 
      builder: (context){
        return SimpleDialog(
          title: Text("New Post", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          children: <Widget>[
            SimpleDialogOption(
              child: Text("Capture Image With Camera", style: TextStyle(color: Colors.white),),
              onPressed: captureImageWithCamera,
            )
          ],
        );
      }
    );
  }

  displayUploadScreen(){
    return Container(
      color: Theme.of(context).accentColor.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.add_photo_alternate, color: Colors.grey, size: 200.0,),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0),),
              child: Text("Upload Image", style: TextStyle(color: Colors.white, fontSize: 20.0),),
              color: Colors.green,
              onPressed: () => takeImage(context),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return displayUploadScreen();
  }
}
