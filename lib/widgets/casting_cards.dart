import 'package:flutter/material.dart';

class CastingCard extends StatelessWidget {
  const CastingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 209,
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 30),
      child: ListView.builder(
        itemBuilder: (_, ind) => const _CastCard(),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
      ),
    );
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard({super.key});

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
            child: const FadeInImage(
              image: NetworkImage('https://via.placeholder.com/150x300'),
              placeholder: AssetImage('assets/no-image.jpg'),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Actor.name asdasd',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
