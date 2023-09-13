import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/widgets/widgets.dart' show CastingCard;

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(
          title: movie.title,
          backdrop: movie.fullBackdropPath,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            _PosterAndTitle(
              title: movie.title,
              originalTitle: movie.originalTitle,
              poster: movie.fullPosterImg,
              rate: movie.voteAverage,
            ),
            _Overview(
              description: movie.overview,
            ),
            CastingCard(
              id: movie.id,
            )
          ]),
        )
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final String title;
  final String backdrop;
  const _CustomAppBar({super.key, required this.title, required this.backdrop});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10),
          color: Colors.black12,
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(backdrop),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final String poster;
  final String title;
  final String originalTitle;
  final double rate;
  const _PosterAndTitle(
      {required this.poster,
      required this.title,
      required this.originalTitle,
      required this.rate});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(poster),
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: textTheme.headlineSmall,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                Text(
                  originalTitle,
                  style: textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_outline,
                      size: 15,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '$rate',
                      style: textTheme.bodySmall,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final String description;
  const _Overview({required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Text(
          description,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.titleMedium,
        ));
  }
}
