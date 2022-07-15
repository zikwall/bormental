import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LocationWidget extends StatefulWidget {
  final Location location;

  const LocationWidget({
    required this.location,
    Key? key,
  }) : super(key: key);

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: isExpanded ? 40 : 100,
            width: isExpanded ? size.width * 0.78 : size.width * 0.7,
            height: isExpanded ? size.height * 0.6 : size.height * 0.5,
            child: ExpandedContentWidget(location: widget.location),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: isExpanded ? 150 : 100,
            child: GestureDetector(
              onPanUpdate: onPanUpdate,
              onTap: openDetailPage,
              child: ImageWidget(location: widget.location),
            ),
          ),
        ],
      ),
    );
  }

  void openDetailPage() {
    if (!isExpanded) {
      /// Tap to expand card
      setState(() => isExpanded = true);
      return;
    }

    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double>
            secondaryAnimation
            ) => DetailPage(location: widget.location, animation: animation),
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      setState(() {
        isExpanded = true;
      });
    } else if (details.delta.dy > 0) {
      setState(() {
        isExpanded = false;
      });
    }
  }
}

class ImageWidget extends StatelessWidget {
  final Location location;

  const ImageWidget({
    required this.location,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      /// space from white container
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: size.height * 0.5,
      width: size.width * 0.8,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 2, spreadRadius: 1),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Stack(
          children: [
            buildImage(),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildTopText(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildImage() => SizedBox.expand(
    child: Hero(
      tag: HeroTag.image(location.urlImage),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: Image.network(location.urlImage, fit: BoxFit.cover),
      ),
    ),
  );

  Widget buildTopText() => Text(
    location.name,
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  );
}

class Location {
  final String name;
  final String urlImage;
  final String latitude;
  final String longitude;
  final String addressLine1;
  final String addressLine2;
  final int starRating;
  final List<Review> reviews;
  final List<Review1> reviews1;

  Location({
    required this.reviews1,
    required this.reviews,
    required this.name,
    required this.urlImage,
    required this.latitude,
    required this.longitude,
    required this.addressLine1,
    required this.addressLine2,
    required this.starRating,
  });
}

class Review {
  final String username;
  final String urlImage;
  final String date;
  final String description;

  Review({
    required this.username,
    required this.urlImage,
    required this.date,
    required this.description,
  });
}

class Review1 {
  final String username;
  final String urlImage;
  final String date;
  final String description;

  Review1({
    required this.username,
    required this.urlImage,
    required this.date,
    required this.description,
  });
}

class DetailPage extends StatelessWidget {
  final Location location;
  final Animation<double> animation;

  const DetailPage({
    Key? key,
    required this.location,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    backgroundColor: Colors.white,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text('BIOGRAFIAS'),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.close),
          onPressed: Navigator.of(context).pop,
        ),
        const SizedBox(width: 10)
      ],
      leading: const Icon(Icons.search_outlined),
    ),
    body: Column(
      children: [
        Hero(
          tag: "${location}_background",
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox.expand(
                child: Hero(
                  tag: HeroTag.image(location.urlImage),
                  child: Image.network(location.urlImage, fit: BoxFit.cover),
                ),
              ),
              /*Container(
                    padding: const EdgeInsets.all(8),
                    child: LatLongWidget(location: location),
                  ),*/
            ],
          ),
        ),
        DetailedInfoWidget(location: location),
        Expanded(
          flex: 5,
          child: ReviewsWidget(location: location, animation: animation),
        ),
      ],
    ),
  );
}

class DetailedInfoWidget extends StatelessWidget {
  final Location location;

  const DetailedInfoWidget({
    required this.location,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: HeroTag.addressLine1(location),
          child: Text(location.addressLine1),
        ),
        SizedBox(height: 8),
        Hero(
          tag: HeroTag.addressLine2(location),
          child: Text(location.addressLine2),
        ),
        SizedBox(height: 8),
        Hero(
          tag: HeroTag.stars(location),
          child: StarsWidget(stars: location.starRating),
        ),
      ],
    ),
  );
}

class StarsWidget extends StatelessWidget {
  final int stars;

  const StarsWidget({
    required this.stars,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allStars = List.generate(stars, (index) => index);

    return Row(
      children: allStars
          .map((star) => Container(
        margin: EdgeInsets.only(right: 4),
        child: Icon(Icons.star_rate, size: 18, color: Colors.blueGrey),
      ))
          .toList(),
    );
  }
}

List<Location> locations = [
  Location(
    name: 'John Lennon',
    urlImage: 'https://koenig-media.raywenderlich.com/uploads/2017/12/GOOGLE_MAPS_SCREENSHOT11_1.png',
    addressLine1: 'Biografía',
    addressLine2: 'John Lennon',
    starRating: 4,
    reviews: Reviews1.allReviews1, longitude: '', reviews1: [], latitude: '',
  ),
  Location(
    name: 'QUEEN',
    urlImage: 'https://koenig-media.raywenderlich.com/uploads/2017/12/GOOGLE_MAPS_SCREENSHOT11_1.png',
    addressLine1: 'Biografia',
    addressLine2: 'Quenn',
    starRating: 4,
    reviews: Reviews.allReviews,  longitude: '', reviews1: [], latitude: '',
  ),
];

class ReviewsWidget extends StatelessWidget {
  final Location location;
  final Animation<double> animation;

  const ReviewsWidget({
    required this.location,
    required this.animation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.separated(
      itemCount: location.reviews.length,
      padding: EdgeInsets.all(16),
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final review = location.reviews[index];

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) => FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Interval(0.2, 1, curve: Curves.easeInExpo),
            ),
            child: child,
          ),
          child: buildReview(review),
        );
      });

  Widget buildReview(Review review) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: HeroTag.avatar(review, locations.indexOf(location)),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.black12,
                backgroundImage: NetworkImage(review.urlImage),
              ),
            ),
            Text(
              review.username,
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(),
            Text(
              review.date,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            Icon(Icons.thumb_up_alt_outlined, size: 14)
          ],
        ),
        SizedBox(height: 8),
        Text(
          review.description,
          style: TextStyle(color: Colors.black54),
        ),
      ],
    ),
  );
}

class HeroTag {
  static String image(String urlImage) => urlImage;

  static String addressLine1(Location location) =>
      location.name + location.addressLine1;

  static String addressLine2(Location location) =>
      location.name + location.addressLine2;

  static String stars(Location location) =>
      location.name + location.starRating.toString();

  static String avatar(Review review, int position) =>
      review.urlImage + position.toString();
}

class Reviews {
  static List<Review> allReviews = [
    Review(
      date: 'formada en 1970 ',
      username: 'Quenn',
      urlImage: 'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?s=200',
      description:
      'Queen es una banda británica de rock formada en 1970 en Londres por el cantante y pianista Freddie Mercury, el guitarrista Brian May, el baterista Roger Taylor y el bajista John Deacon.'
          'Si bien el grupo ha presentado bajas de dos de sus miembros (Mercury, fallecido en 1991, y Deacon, retirado en 1997), los integrantes restantes, Brian May y Roger Taylor,'
          'continúan trabajando bajo el nombre Queen, por lo que la banda aún se considera activa.',
    ),
    Review(
      date: '1973 a 1995',
      username: 'Discografia',
      urlImage: 'https://sammyplaysdirty.com/user-avatar-pic3/',
      description: '1973: Queen \n\n'
          '1974: Queen II, Sheer Heart Attack\n\n'
          '1975: A Night at the Opera\n\n'
          '1976: A Day at the Races\n\n'
          '1977: News of the World\n\n'
          '1978: Jazz\n\n'
          '1980: The Game,Flash Gordon (banda sonora)\n\n'
          '1982: Hot Space\n\n'
          '1984: The Works\n\n'
          '1986: A Kind of Magic\n\n'
          '1989: The Miracle\n\n'
          '1991: Innuendo\n\n'
          '1995: Made in Heaven\n\n',
    ),
    Review(
      date: '10',
      username: 'TOP',
      urlImage: 'https://soho.com.au/properties/sold/18-6-14-darley-street-darlinghurst-nsw-2010-australia',
      description: '1- Bohemian Rhapsody From A Night at the Opera (1975) \n\n'
          '2- We Will Rock You / We Are the Champions From News of the World (1977)\n\n'
          '3- Another One Bites the Dust\n\n'
          '4- Under Pressure (with David Bowie)\n\n'
          '5- Fat Bottomed Girls\n\n'
          '6- Crazy Little Thing Called Love\n\n'
          '7- Somebody to Love\n\n'
          '8- Killer Queen\n\n'
          '9- Tie Your Mother Down\n\n'
          '10- Stone Cold Crazy\n\n',
    ),
  ];
}

class Reviews1 {
  static List<Review> allReviews1 = [
    Review(
      date: '9 de octubre de 1940',
      username: 'Jhonn Lennon',
      urlImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6sGddmMZFZCqb7aJFx5eV-8FGj2gJWz7abGntj8IuyYdAv7W2HEJyi5WY3xbpLLzf-Zg&usqp=CAU',
      description:
      'John Winston Lennon nació una noche en que Liverpool sufría un ataque aéreo alemán. Su padre era marino mercante y estaba fuera de casa con frecuencia. Siendo aún muy pequeño, su madre le dejó al cuidado de su hermana para irse a vivir con otro hombre.' +
          'En el colegio, John Lennon no era buen alumno y mostraba tener un carácter rebelde haciendo el payaso en clase. A pesar de los esfuerzos de su tía por que terminara sus estudios, no llegó a concluirlos.' +
          'Ya en 1956 formó su primera banda, llamada The Quarrymen, y al año siguiente conoció a Paul McCartney, que se unió al grupo, que pronto se llamó The Beatles.',
    ),
    Review(
      date: 'años 1970 y 1980',
      username: 'Discografia',
      urlImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6sGddmMZFZCqb7aJFx5eV-8FGj2gJWz7abGntj8IuyYdAv7W2HEJyi5WY3xbpLLzf-Zg&usqp=CAU',
      description:
      '1970	John Lennon/Plastic Ono Band Primer álbum de estudio Lanzamiento: 11 de diciembre de 1970'
          'Discográfica: Apple / EMI\n\n'
          '1971	Imagine Segundo álbum de estudio Lanzamiento: 9 de septiembre de 1971'
          ' Discográfica: Apple / EMI \n\n'
          '1972	Some Time in New York City Tercer álbum de estudio / álbum en directo Lanzamiento: 12 de junio de 1972'
          'Discográfica: Apple / EMI \n\n'
          '1973	Mind Games Cuarto álbum de estudio Lanzamiento: 16 de noviembre de 1973'
          'Discográfica: Apple / EMI\n\n'
          '1974	Walls and Bridges Quinto álbum de estudio Lanzamiento: 4 de octubre de 1974'
          'Discográfica: Apple / EMI\n\n'
          '1975	Rock n Roll Sexto álbum de estudio Lanzamiento: 21 de febrero de 1975'
          'Discográfica: Apple / EMI\n\n'
          '1980	Double Fantasy Séptimo álbum de estudio Lanzamiento: 17 de noviembre de 1980'
          'Discográfica: Geffen / Capitol\n\n'
          '1984	Milk and Honey Octavo álbum de estudio Lanzamiento: 27 de enero de 1984'
          'Discográfica: EMI\n\n',
    ),
    Review(
      date: '10',
      username: 'TOP',
      urlImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6sGddmMZFZCqb7aJFx5eV-8FGj2gJWz7abGntj8IuyYdAv7W2HEJyi5WY3xbpLLzf-Zg&usqp=CAU',
      description: '1-"Give Peace a Chance"	1969\n\n	'
          '2-"Cold Turkey"	1969 \n\n'
          '3-"Instant Karma!"	1970\n\n'
          '4-"Imagine" (sólo en Estados Unidos)	1971\n\n	'
          '5-"Woman is the Nigger of the World"	1972\n\n'
          '6-"Mind Games"	1973\n\n	'
          '7-"Whatever Gets You Thru The Night"	1974\n\n'
          '8-"Stand By Me"	1975\n\n'
          '9-"Imagine" (sólo en Reino Unido)	1975\n\n	'
          '10-"Happy Xmas (War is Over)" (reentrada)	1980\n\n',
    ),
  ];
}

class ExpandedContentWidget extends StatelessWidget {
  final Location location;

  const ExpandedContentWidget({
    required this.location,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Hero(
          tag: "${location}_background",
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
        Hero(
          tag: HeroTag.addressLine1(location),
          child: Text(location.addressLine1),
        ),
        SizedBox(height: 8),
        buildAddressRating(location: location),
        SizedBox(height: 12),
        buildReview(location: location)
      ],
    ),
  );

  Widget buildAddressRating({
    required Location location,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Hero(
            tag: HeroTag.addressLine2(location),
            child: Text(
              location.addressLine2,
              style: TextStyle(color: Colors.black45),
            ),
          ),
          Hero(
            tag: HeroTag.stars(location),
            child: StarsWidget(stars: location.starRating),
          ),
        ],
      );

  Widget buildReview({
    required Location location,
  }) =>
      Row(
        children: location.reviews.map((review) {
          final pageIndex = locations.indexOf(location);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Hero(
              tag: HeroTag.avatar(review, pageIndex),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.black12,
                backgroundImage: AssetImage(review.urlImage),
              ),
            ),
          );
        }).toList(),
      );
}

class LocationsWidget extends StatefulWidget {
  @override
  _LocationsWidgetState createState() => _LocationsWidgetState();
}

class _LocationsWidgetState extends State<LocationsWidget> {
  @override
  Widget build(BuildContext context) {
    return LocationWidget(location: locations[0]);
  }
}