import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/providers.dart';
import 'package:provider/provider.dart';

class CastingCard extends StatelessWidget {
  final int id;
  const CastingCard({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getCast(id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: const BoxConstraints(maxWidth: 300),
            height: 180,
            width: double.infinity,
            child: const CupertinoActivityIndicator(),
          );
        }
        final List<Cast> cast = snapshot.data;
        return Container(
          height: 209,
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 30),
          child: ListView.builder(
            itemBuilder: (_, ind) => _CastCard(
              name: cast[ind].name,
              photo: cast[ind].fullProfilePath,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: cast.length,
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final String name;
  final String photo;
  const _CastCard({required this.name, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              image: NetworkImage(photo),
              placeholder: const AssetImage('assets/no-image.jpg'),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
