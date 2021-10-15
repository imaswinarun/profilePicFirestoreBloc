import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profilePiCTask/screens/bloc/HomeScreen/homeScreen_bloc.dart';
import 'package:profilePiCTask/Screens/bloc/HomeScreen/homeScreen_state.dart';
import 'package:profilePiCTask/utils/buildCustomAppBar.dart';
import 'package:profilePiCTask/utils/buildNetworkImage.dart';
import 'package:profilePiCTask/utils/navigationHelper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenBloc homeScreenBloc;

  @override
  void initState() {
    homeScreenBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildCustomAppBar('Profile', AppBar()),
      body: BlocBuilder(
          bloc: homeScreenBloc,
          builder: (context, state) {
            if (state is HomeScreenLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return _buildBody(context);
            }
          }),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  InkWell _buildFloatingActionButton(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationHelper()
            .gotoProfileEditScreen(context, homeScreenBloc.userModel);
      },
      child: Card(
        color: Colors.blue,
        elevation: 16.0,
        shape: CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Padding _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          _buildName(context),
          _buildImage(),
        ],
      ),
    );
  }

  Align _buildImage() {
    return Align(
      alignment: Alignment.topCenter,
      child: BuildNetworkImage(homeScreenBloc.userModel.imgUrl),
    );
  }

  Card _buildName(BuildContext context) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.only(top: 50.0, left: 8.0, right: 8.0, bottom: 8.0),
      color: Colors.blue,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Howdy",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              " ${homeScreenBloc.userModel.name} ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
