import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profilePiCTask/models/userModel.dart';
import 'package:profilePiCTask/screens/bloc/FireStoreUpdate/firestoreUpdate_bloc.dart';
import 'package:profilePiCTask/screens/bloc/HomeScreen/homeScreen_bloc.dart';
import 'package:profilePiCTask/Screens/bloc/HomeScreen/homeScreen_event.dart';
import 'package:profilePiCTask/screens/homeScreen.dart';
import 'package:profilePiCTask/screens/profileEditScreen.dart';

class NavigationHelper {
  void gotoProfileEditScreen(BuildContext context, UserModel userModel) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => BlocProvider(
        create: (context) => FireStoreUpdateBloc(),
        child: ProfileEditScreen(userModel),
      ),
    ));
  }

  void gotoHomeScreen(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) => BlocProvider(
        create: (context) =>
            HomeScreenBloc()..add(HomeScreenInitialLoadEvent()),
        child: HomeScreen(),
      ),
    ));
  }
}
