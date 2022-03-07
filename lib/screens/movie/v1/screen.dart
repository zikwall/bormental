import 'dart:async';
import 'dart:ui';

// native
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// dependencies
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

// application
import 'package:bormental/transitions/slide_left.dart';
import 'package:bormental/screens/profile/screen.dart';

// local
import 'mock.dart';
import 'movie.dart';
import 'constants.dart';
import 'search.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> with AutomaticKeepAliveClientMixin<MovieScreen> {
  final CarouselController _carouselController = CarouselController();
  int _current = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    futureDiscoverMovie = fetchDiscoverMovie();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          backgroundColor: Colors.black,
          resizeToAvoidBottomInset: false,
          body: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                elevation: 1,
                snap: true,
                floating: true,
                pinned: true,
                toolbarHeight: 240,
                expandedHeight: 220,
                titleSpacing: 10,
                backgroundColor: Colors.black,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: _buildHeader(context),
                    ),
                  ],
                ),
                centerTitle: true,
                bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(80.0),
                    child: SearchBar(),
                ),
              )
            ],
            body: RefreshIndicator(
              color: kPrimaryColor,
              onRefresh: () {
                return Future.delayed(const Duration(milliseconds: 1500), () {
                  print("OK");
                });
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    popularCarousel(),
                    SizedBox(height: MediaQuery.of(context).size.height + 20),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

  Widget popularCarousel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 35),
          child: Text('Популярное', style: kSectionTitle),
        ),
        const SizedBox(height: 24),
        FutureBuilder<Movie>(
          future: futureDiscoverMovie,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildPopularCarousel(context, snapshot, _carouselController, (index, reason) {
                setState(() {
                  _current = index;
                });
              });
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${snapshot.error}', style: kErrorText),
                ],
              );
            }

            return Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

Widget _buildHeader(BuildContext context) {
  return InkWell(
    onTap: () {
      FocusScope.of(context).unfocus();
      Navigator.push(
          context, SlideRightToLeftRoute(page: const ProfileScreen()
      ));
    },
    borderRadius: BorderRadius.circular(10),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Привет, Андрей', style: kHeaderTitle),
              const SizedBox(height: 7),
              Text("Посмотрим, Что будет Дальше", style: kHeaderSubtitle),
            ],
          ),
          const CircleAvatar(
            backgroundImage: NetworkImage(
              "https://lh3.googleusercontent.com/ogw/ADea4I5KM87L_DrqXxuVO7xsFWG17sg2y_soXASSX6hS=s83-c-mo",
            ),
            radius: 30,
          ),
        ],
      ),
    ),
  );
}

Widget _buildPopularCarousel(
    BuildContext context,
    AsyncSnapshot<Movie> snapshot,
    CarouselController carouselController,
    Function(int index, CarouselPageChangedReason reason) onPageChanged
) {
  return SizedBox(
    height: 256,
    child: CarouselSlider(
      options: CarouselOptions(
          height: 256.0,
          aspectRatio: 16 / 9,
          viewportFraction: MediaQuery.of(context).orientation == Orientation.landscape ? 0.25 : 0.45,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayAnimationDuration:
          const Duration(milliseconds: 500),
          onPageChanged: onPageChanged
      ),
      carouselController: carouselController,
      items: [
        ...snapshot.data!.results!.map((item) => GestureDetector(
          onTap: () {
            //
          },
          child: Container(
            height: 256,
            width: 170,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: posterUrl + item.posterPath.toString(),
                fit: BoxFit.scaleDown,
                placeholder: (context, url) => ClipRRect( // make sure we apply clip it properly
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 11, sigmaY: 11),
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.grey.withOpacity(0.1),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )),
      ],
    ),
  );
}

Widget _buildBackgroundOverlay(BuildContext context, String imageUrl) {
  return SizedBox(
    height: double.infinity,
    width: MediaQuery.of(context).size.width,
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fill,
      color: Colors.black.withOpacity(0.7),
      colorBlendMode: BlendMode.darken,
    ),
  );
}

Widget _buildDefaultBackground(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: Image.asset(
      'assets/images/cover.jpg',
      fit: BoxFit.cover,
      color: Colors.black.withOpacity(0.7),
      colorBlendMode: BlendMode.darken,
    ),
  );
}