import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/widgets/widgets.dart' show CastingCard;

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    print(movie.heroID);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(
          title: movie.title,
          backdrop: movie.fullBackdropPath,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            _PosterAndTitle(movie: movie),
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
  final Movie movie;
  const _PosterAndTitle({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroID!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,
                    style: textTheme.headlineSmall,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2),
                Text(
                  movie.originalTitle,
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
                      '${movie.voteAverage}',
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
          description != '' ? description : 'No hay sinapsis disponible.',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.titleMedium,
        ));
  }
}
