import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * .5,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    return SizedBox(
      width: double.infinity, //COMPLETED: todo el hancho posible segun el padre
      height: size.height *
          .5, //COMPLETED: esto debe ser adaptable(completado en la linea 9 con mediaquery)
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * .6,
        itemHeight: size.height * .4,
        itemBuilder: (BuildContext context, int index) {
          //para usar las imagenes creamos la carpeta assets y luego modificamos la seccion de assets en pubspec
          final movie = movies[index];

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'details', arguments: movie);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
