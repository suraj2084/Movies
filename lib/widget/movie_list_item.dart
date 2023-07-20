import 'package:flutter/material.dart';
import 'package:movies/model/movie_model.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    super.key,
    required this.movie,
  });
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            Text(movie.title),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(movie.director),
                const Spacer(),
                Row(
                  children: [
                    const SizedBox(
                      width: 4,
                    ),
                    Text(movie.formattedDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
