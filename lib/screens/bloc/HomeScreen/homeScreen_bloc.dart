import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profilePiCTask/Screens/bloc/HomeScreen/homeScreen_event.dart';
import 'package:profilePiCTask/Screens/bloc/HomeScreen/homeScreen_state.dart';
import 'package:profilePiCTask/models/userModel.dart';
import 'package:profilePiCTask/utils/dbHelper.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitialState());

  UserModel userModel = UserModel(imgUrl: '', userId: 0, name: 'userName',uKey: '');

  @override
  Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {
    if (event is HomeScreenInitialLoadEvent) {
      yield HomeScreenLoadingState();
      userModel = await DbHelper().getUserInfo();
      yield HomeScreenFetchedState();
    }
  }
}
