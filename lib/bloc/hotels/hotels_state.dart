import 'package:equatable/equatable.dart';

import '../../model/HotelModel.dart';

class HotelsState extends Equatable {
  const HotelsState();

  @override
  List<Object?> get props => [];
}

class HotelsInitial extends HotelsState {}

class HotelsLoaded extends HotelsState {
  final List<HotelModel> hotels;
  const HotelsLoaded({required this.hotels});

  @override
  List<Object?> get props => [hotels];
}

class HotelsLoading extends HotelsState {}

class HotelsError extends HotelsState {
  final String message;

  const HotelsError(this.message);
}
