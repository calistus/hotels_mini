import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:hotels_mini/bloc/hotels/hotels_bloc.dart';
import 'package:hotels_mini/bloc/hotels/hotels_state.dart';
import 'package:hotels_mini/model/HotelModel.dart';
import 'package:hotels_mini/ui/hotel_detail_screen.dart';
import 'package:hotels_mini/utilities/colors_util.dart';

import '../utilities/ui_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  late String searchKey;
  late HotelsBloc hotelsBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            expandedHeight: 80.0,
            backgroundColor: ColorsUtil.primaryColor,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Hotels Mini',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10.0,
            ),
          ),
          BlocConsumer<HotelsBloc, HotelsState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is HotelsLoading) {
                return SliverToBoxAdapter(
                    child: UIUtils.showCircularLoader("Loading Hotels..."));
              } else if (state is HotelsLoaded) {
                return state.hotels.isNotEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return _buildHotel(index, state.hotels[index]);
                        }, childCount: state.hotels.length),
                      )
                    : SliverToBoxAdapter(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            SizedBox(
                              height: 100,
                            ),
                            Text("We are heading there"),
                            Text(
                                "Seems like we don't have this Hotel yet. Please check back later")
                          ],
                        ),
                      );
              } else if (state is HotelsError) {
                return SliverToBoxAdapter(
                    child: UIUtils.showError(state.message));
              }
              return SliverToBoxAdapter(child: Container());
            },
          )
        ],
      ),
    );
  }

  Widget _buildHotel(int index, HotelModel hotel) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(children: <Widget>[
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) =>
                    //           FullPhotoScreen(url: Hotel.image),
                    //     ));
                  },
                  child: hotel.gallery!.isEmpty
                      ? Image.network(
                          "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-1-scaled-1150x647.png",
                          width: double.infinity,
                        )
                      : CachedNetworkImage(
                          imageUrl: hotel.gallery![0],
                          imageBuilder: (context, imageProvider) => Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                // colorFilter: ColorFilter.mode(
                                //     Colors.red, BlendMode.colorBurn)
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Image.network(
                            "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-1-scaled-1150x647.png",
                            width: double.infinity,
                          ),
                        ),
                ),
                Positioned(
                    bottom: 20.0,
                    right: 10.0,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      color: Colors.white,
                      child: Text(
                        hotel.price.toString() + " ${hotel.currency}",
                      ),
                    ))
              ]),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HotelDetailScreen(hotel: hotel),
                      ));
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        hotel.name!,
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        hotel.location!.address! + ", " + hotel.location!.city!,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      RatingStars(
                        value: double.parse(hotel.stars.toString()),
                        onValueChanged: (v) {
                          setState(() {
                            //value = v;
                          });
                        },
                        starBuilder: (index, color) => Icon(
                          Icons.star,
                          color: color,
                        ),
                        starCount: 5,
                        starSize: 20,
                        valueLabelColor: const Color(0xff9b9b9b),
                        valueLabelTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                        valueLabelRadius: 10,
                        maxValue: 5,
                        starSpacing: 2,
                        maxValueVisibility: true,
                        valueLabelVisibility: true,
                        animationDuration: Duration(milliseconds: 1000),
                        valueLabelPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 8),
                        valueLabelMargin: const EdgeInsets.only(right: 8),
                        starOffColor: const Color(0xffe7e8ea),
                        starColor: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
