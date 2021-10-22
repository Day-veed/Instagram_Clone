import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia/models/user.dart';

class UploadPage extends StatefulWidget {
  final User gCurrentUser;
  UploadPage({this.gCurrentUser});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File file;
  TextEditingController descriptionTextEditingController = TextEditingController();
  TextEditingController locationTextEditingController = TextEditingController();

  captureImageWithCamera()async{
    Navigator.pop(context);
    PickedFile picked = await ImagePicker().getImage(
      preferredCameraDevice: CameraDevice.front, 
      source: ImageSource.camera,
      maxHeight: 680.0,
      maxWidth: 970,
    );
    setState(() {
      this.file = File(picked.path);
    });
  }

  pickImageFromGallery() async{
    Navigator.pop(context);
    PickedFile picked = await ImagePicker().getImage(
      //preferredCameraDevice: CameraDevice.front, 
      source: ImageSource.gallery,);
      setState(() {
        this.file = File(picked.path);
      }
    );
  }
  pop(){
    Navigator.pop(context);
  }

  takeImage(nContext){
    return showDialog(
      context: nContext, 
      builder: (context){
        return SimpleDialog(
          backgroundColor: Colors.grey,
          title: Text("New Post", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          children: <Widget>[
            SimpleDialogOption(
              child: Text("Capture Image With Camera", style: TextStyle(color: Colors.white),),
              onPressed: captureImageWithCamera,
            ),
            SimpleDialogOption(
              child: Text("Select Image from Gallery", style: TextStyle(color: Colors.white),),
              onPressed: pickImageFromGallery,
            ),
            SimpleDialogOption(
              child: Text("Cancel", style: TextStyle(color: Colors.white),),
              onPressed: pop,
            ),
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

  removeImage(){
    setState(() {
      file = null;
    });
  }

  getUserCurrentLocation() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark mplaceMark = placeMarks[0];
    String completeAddressInfo = '${mplaceMark.subThoroughfare} ${mplaceMark.thoroughfare}, ${mplaceMark.subLocality} ${mplaceMark.locality}, ${mplaceMark.subAdministrativeArea} ${mplaceMark.administrativeArea}, ${mplaceMark.postalCode} ${mplaceMark.country}';
    String specificAddress = '${mplaceMark.locality}, ${mplaceMark.country}';
    locationTextEditingController.text = specificAddress;
  }

  displayUploadFormScreen(){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading:  IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: removeImage,),
        title: Text("New Post", style: TextStyle(fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.bold),),
        actions: <Widget>[
          FlatButton(
            onPressed: ()=> print("tapped"), 
            child: Text("Share", style: TextStyle(color: Colors.lightGreenAccent, fontWeight: FontWeight.bold, fontSize: 16.0),),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 230.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(image: DecorationImage(image: FileImage(file), fit: BoxFit.cover,)),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 12.0),),
          ListTile(
            leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(widget.gCurrentUser.url),),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: descriptionTextEditingController,
                decoration: InputDecoration(
                  hintText: "Say something about image.", 
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person_pin_circle, color: Colors.white, size: 36.0,),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: locationTextEditingController,
                decoration: InputDecoration(
                  hintText: "Write the location here", 
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            width: 220.0,
            height: 110.0,
            alignment: Alignment.center,
            child: RaisedButton.icon(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
              color: Colors.green,
              icon: Icon(Icons.location_on, color: Colors.white,),
              label: Text("Get my current Location", style: TextStyle(color: Colors.white),),
              onPressed: getUserCurrentLocation,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return file == null ? displayUploadScreen() : displayUploadFormScreen();
  }
}
