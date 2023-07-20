import 'package:flutter/material.dart';
import 'package:movies/model/movie_model.dart';

class NewMovie extends StatefulWidget {
  const NewMovie({super.key, required this.onAddMovie});
  final void Function(Movie movie) onAddMovie;
  @override
  State<NewMovie> createState() {
    return _NewMovie();
  }
}

class _NewMovie extends State<NewMovie> {
  final _titleController = TextEditingController();
  final _directorController = TextEditingController();

  DateTime? _selectedDate;
  List<Movie> addMovie = [];
  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(DateTime.monthsPerYear);
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitMovieItem() {
    if (_titleController.text.trim().isEmpty ||
        _directorController.text.trim().isEmpty ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Okay"))
          ],
          title: const Text("Invaild Input"),
          content: const Text(
              "Please Make Sure a valid title, Director Name, date was entered."),
        ),
      );
      return;
    }
    widget.onAddMovie(Movie(
      title: _titleController.text,
      director: _directorController.text,
      date: _selectedDate!,
    ));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _directorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            keyboardType: TextInputType.text,
            maxLength: 20,
            decoration: const InputDecoration(
              label: Text("Title"),
              hintText: "Enter the Title",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            width: 5,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _directorController,
                  keyboardType: TextInputType.text,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    label: Text("Director"),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? " No Date Selected"
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _showDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete),
                label: const Text("Cencel"),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                onPressed: _submitMovieItem,
                icon: const Icon(Icons.save),
                label: const Text("Save"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
