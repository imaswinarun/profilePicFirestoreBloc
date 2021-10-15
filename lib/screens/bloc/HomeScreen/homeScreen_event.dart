import 'package:equatable/equatable.dart';

class HomeScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeScreenInitialLoadEvent extends HomeScreenEvent {}

class HomeScreenRefreshEvent extends HomeScreenEvent {}
