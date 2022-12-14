import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels_mini/bloc/hotels/hotels_bloc.dart';
import 'package:hotels_mini/repository/hotel_repository.dart';
import 'package:hotels_mini/ui/home_screen.dart';

import 'bloc/hotels/hotels_event.dart';
import 'bloc/hotels/hotels_event.dart';
import 'bloc/simple_bloc_observer.dart';

Future<void> main() async {
  return BlocOverrides.runZoned(
    () async {
      runApp(MyApp());
    },
    blocObserver: BlocMonitor(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HotelsBloc>(
            create: (context) => HotelsBloc(hotelRepository: HotelRepository())
              ..add(FetchHotels()),
          ),
        ],
        child: MaterialApp(
          title: 'Hotel Mini',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen(),
        ));
  }
}
