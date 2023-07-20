import 'package:flutter/material.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/widget/movie_list_item.dart';

class MovieList extends StatelessWidget {
  const MovieList({
    super.key,
    required this.movie,
    required this.onRemoveMovie,
  });
  final List<Movie> movie;
  final void Function(Movie movie) onRemoveMovie;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: movie.length,
      itemBuilder: (context, index) => Dismissible(
          key: ValueKey(movie[index]),
          onDismissed: (direction) {
            onRemoveMovie(movie[index]);
          },
          child: MovieItem(movie: movie[index])),
    );
  }
}
