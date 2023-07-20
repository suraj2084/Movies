import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMEd();

class MovieBucket {
  const MovieBucket({
    required this.movieitem,
  });
  final List<Movie> movieitem;
}

class Movie {
  Movie({required this.title, required this.date, required this.director})
      : id = uuid.v4();
  final String id;
  final String title;
  final DateTime date;
  final String director;
  String get formattedDate {
    return formatter.format(date);
  }
}
