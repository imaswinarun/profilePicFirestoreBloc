import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profilePiCTask/models/userModel.dart';
import 'package:profilePiCTask/screens/bloc/FireStoreUpdate/fireStoreUpdate_event.dart';
import 'package:profilePiCTask/screens/bloc/FireStoreUpdate/fireStoreUpdate_state.dart';
import 'package:profilePiCTask/screens/bloc/FireStoreUpdate/firestoreUpdate_bloc.dart';
import 'package:profilePiCTask/utils/buildCustomAppBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profilePiCTask/utils/buildNetworkImage.dart';
import 'package:profilePiCTask/utils/dbHelper.dart';
import 'package:profilePiCTask/utils/navigationHelper.dart';
import 'package:flutter/painting.dart' as painting;

class ProfileEditScreen extends StatefulWidget {
  final UserModel userModel;
  ProfileEditScreen(this.userModel);

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  XFile? image;
  TextEditingController textEditingController = TextEditingController();
  late FireStoreUpdateBloc fireStoreUpdateBloc;

  @override
  void initState() {
    fireStoreUpdateBloc = BlocProvider.of(context);
    textEditingController.text = widget.userModel.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildCustomAppBar('Profile Edit', AppBar()),
      body: BlocConsumer(
          bloc: fireStoreUpdateBloc,
          listener: (context, state) {
            if (state is FireStoreUpdateFinishedState) {
              NavigationHelper().gotoHomeScreen(context);
            }
          },
          builder: (context, state) {
            if (state is FireStoreUpdateUploadingState) {
              updateFireStore();
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return _buildBody();
            }
          }),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Padding _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildImage(),
          _buildTextField(),
        ],
      ),
    );
  }

  InkWell _buildFloatingActionButton(BuildContext context) {
    return InkWell(
      onTap: () {
        fireStoreUpdateBloc.add(FireStoreUpdateInitialUploadEvent());
      },
      child: Card(
        color: Colors.green,
        elevation: 16.0,
        shape: CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> updateFireStore() async {
    String url = widget.userModel.imgUrl;
    if (image != null) {
      painting.imageCache!.clear();
      UploadTask uploadTask = await DbHelper().upLoadImage(image!.path);
      url = await uploadTask.snapshot.ref.getDownloadURL();
    }
    print(url);
    DbHelper()
        .updateInfo(url, textEditingController.text, widget.userModel.uKey)
        .then((value) {
      if (value) {
        NavigationHelper().gotoHomeScreen(context);
      } else {
        fireStoreUpdateBloc.add(FireStoreUpdateErrorEvent());
      }
    });
  }

  Padding _buildTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          hintText: "Enter your name",
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              _showImageFromGallery();
            },
            child: image == null
                ? BuildNetworkImage(widget.userModel.imgUrl)
                : _buildCustomFileImage(),
          ),
        ),
        Positioned(
          top: 60.0,
          left: 75.0,
          child: InkWell(
            onTap: () {
              _showImageFromGallery();
            },
            child: Card(
                color: Colors.blue,
                elevation: 16.0,
                shape: CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.camera_alt,
                    size: 25.0,
                    color: Colors.white,
                  ),
                )),
          ),
        )
      ],
    );
  }

  Card _buildCustomFileImage() {
    return Card(
      elevation: 16.0,
      shape: CircleBorder(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Image.file(
          File(image!.path),
          fit: BoxFit.fill,
          height: 100.0,
          width: 100.0,
        ),
      ),
    );
  }

  _showImageFromGallery() async {
    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {});
    } catch (e) {
      print("Exception");
    }
  }
}
