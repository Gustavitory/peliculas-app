import 'package:flutter/material.dart';
import 'package:movies_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          )
        ],
      ),
      body: const SingleChildScrollView(
        //para manejar el desbordamiento vertical
        child: Column(
          children: [
            //TODO: card swiper ✔✔✔✔✔✔
            //tarjetas principales:
            CardSwiper(),
            //TODO: Listado horizontal de peliculas
            MovieSlider(),
            MovieSlider(),
            MovieSlider()
          ],
        ),
      ),
    );
  }
}
