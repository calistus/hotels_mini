import 'package:equatable/equatable.dart';

abstract class HotelsEvent extends Equatable {
  const HotelsEvent();

  @override
  List<Object?> get props => [];
}

class InitEvent extends HotelsEvent {}

class FetchHotels extends HotelsEvent {}

class FilterHotelByStar extends HotelsEvent {
  final int star;
  const FilterHotelByStar(this.star);
}

class SortHotelByPriceAsc extends HotelsEvent {
  const SortHotelByPriceAsc();
}

class SortHotelByPriceDesc extends HotelsEvent {
  const SortHotelByPriceDesc();
}
