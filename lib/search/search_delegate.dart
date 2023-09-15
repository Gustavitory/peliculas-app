import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/providers.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar película';
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return const _EmptyResults();
    }
    final MoviesProvider moviesProvider =
        Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) return const _EmptyResults();
        final List<Movie> movies = snapshot.data;
        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, int index) => _ResultCard(movie: movies[index]));
      },
    );
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.movie_creation_outlined,
        color: Colors.black38,
        size: 100,
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final Movie movie;
  const _ResultCard({required this.movie});
  @override
  Widget build(BuildContext context) {
    movie.heroID = 'search-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroID!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Row(children: [
        const Icon(
          Icons.star_border_outlined,
          size: 16,
        ),
        const SizedBox(
          width: 5,
        ),
        Text('${movie.voteAverage}')
      ]),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
