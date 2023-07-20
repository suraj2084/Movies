import 'package:flutter/material.dart';
import 'package:movies/Screens/movie_list.dart';
import 'package:movies/Screens/new_movie.dart';
import 'package:movies/model/movie_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  final List<Movie> _registeredMovie = [
    Movie(
      title: "Matrix",
      director: "Suraj",
      date: DateTime.now(),
    ),
    Movie(
      title: "Dil Mange More",
      director: "Tushar",
      date: DateTime.now(),
    ),
  ];
  void _addMovie(Movie movie) {
    setState(() {
      _registeredMovie.add(movie);
    });
  }

  void _removeMovie(Movie movie) {
    final movieIndex = _registeredMovie.indexOf(movie);
    setState(() {
      _registeredMovie.remove(movie);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Movie Delte"),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredMovie.insert(movieIndex, movie);
            });
          }),
    ));
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewMovie(
              onAddMovie: _addMovie,
            ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No Expense found. start adding some!"),
    );
    if (_registeredMovie.isNotEmpty) {
      mainContent = MovieList(
        movie: _registeredMovie,
        onRemoveMovie: _removeMovie,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [mainContent],
      ),
    );
  }
}
