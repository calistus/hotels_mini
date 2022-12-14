import 'package:bloc/bloc.dart';
import 'package:hotels_mini/model/HotelModel.dart';

import '../../repository/hotel_repository.dart';
import 'hotels_event.dart';
import 'hotels_state.dart';

class HotelsBloc extends Bloc<HotelsEvent, HotelsState> {
  final HotelRepository hotelRepository;
  HotelsBloc({required this.hotelRepository}) : super(HotelsInitial()) {
    on<FetchHotels>(_onFetchHotel);
    on<FilterHotelByStar>(_onFilterHotelByStar);
    on<SortHotelByPriceAsc>(_onSortHotelByPriceAsc);
    on<SortHotelByPriceDesc>(_onSortHotelByPriceDesc);
  }

  void _onFetchHotel(FetchHotels event, Emitter<HotelsState> emit) async {
    try {
      emit(HotelsLoading());
      List<HotelModel>? hotel = await hotelRepository.fetchHotels();
      emit(HotelsLoaded(hotels: hotel!));
    } catch (e) {
      emit(HotelsError(e.toString()));
    }
  }

  void _onFilterHotelByStar(
      FilterHotelByStar event, Emitter<HotelsState> emit) async {
    try {
      emit(HotelsLoading());
      List<HotelModel>? hotels = await hotelRepository.fetchHotels();
      hotels = filterHotelByStars(event.star, hotels!);
      emit(HotelsLoaded(hotels: hotels));
    } catch (e) {
      emit(HotelsError(e.toString()));
    }
  }

  void _onSortHotelByPriceDesc(
      SortHotelByPriceDesc event, Emitter<HotelsState> emit) async {
    try {
      emit(HotelsLoading());
      List<HotelModel>? hotels = await hotelRepository.fetchHotels();
      hotels!.sort((b, a) => a.price!.compareTo(b.price!));
      emit(HotelsLoaded(hotels: hotels));
    } catch (e) {
      emit(HotelsError(e.toString()));
    }
  }

  void _onSortHotelByPriceAsc(
      SortHotelByPriceAsc event, Emitter<HotelsState> emit) async {
    try {
      emit(HotelsLoading());
      List<HotelModel>? hotels = await hotelRepository.fetchHotels();
      hotels!.sort((a, b) => a.price!.compareTo(b.price!));
      emit(HotelsLoaded(hotels: hotels));
    } catch (e) {
      emit(HotelsError(e.toString()));
    }
  }

  List<HotelModel> filterHotelByStars(int star, List<HotelModel> hotels) {
    return hotels.where((hotel) => hotel.stars == star).toList();
  }
}
