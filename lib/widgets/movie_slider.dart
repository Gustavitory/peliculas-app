import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';

class MovieSlider extends StatelessWidget {
  final List<Movie> movies;
  final String? listTitle;
  final dynamic Function() nextPage;

  const MovieSlider(
      {Key? key, required this.movies, this.listTitle, required this.nextPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: 273,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (listTitle != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              listTitle!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        _Carousel(movies: movies, nextPage: nextPage)
      ]),
    );
  }
}

//La barra baja significa que es un widget privado de este archivo
class _Carousel extends StatefulWidget {
  final List<Movie> movies;
  final dynamic Function() nextPage;

  const _Carousel({Key? key, required this.movies, required this.nextPage})
      : super(key: key);

  @override
  State<_Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<_Carousel> {
  final ScrollController scrollController = ScrollController();
  bool loading = false;
  Future fetchData() async {
    if (loading) return;
    loading = true;
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 500));
    await widget.nextPage();
    loading = false;
    setState(() {});
    if (scrollController.position.pixels >=
        (scrollController.position.maxScrollExtent - 500)) {
      scrollController.animateTo(scrollController.position.pixels + 120,
          duration: const Duration(milliseconds: 250),
          curve: Curves.fastOutSlowIn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) fetchData();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.movies.length,
        itemBuilder: (BuildContext context, int index) {
          final Movie movie = widget.movies[index];
          return _CarouselCard(movie: movie);
        },
      ),
    );
  }
}

class _CarouselCard extends StatelessWidget {
  final Movie movie;

  const _CarouselCard({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'details', arguments: movie);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
