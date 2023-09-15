import 'package:flutter/material.dart';
import 'package:movies_app/providers/providers.dart';
import 'package:movies_app/search/search_delegate.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: MovieSearchDelegate());
            },
            icon: const Icon(Icons.search_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        //para manejar el desbordamiento vertical
        child: Column(
          children: [
            //completed: card swiper ✔✔✔✔✔✔
            //tarjetas principales:
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            //completed: Listado horizontal de peliculas
            MovieSlider(
                movies: moviesProvider.popularMovies,
                listTitle: 'Populares!',
                nextPage: () => moviesProvider.nextPopularPage())
          ],
        ),
      ),
    );
  }
}
