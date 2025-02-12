import 'item_movie.dart';

class AllMovies {
  int page=0;
  List<Movie> results  =[]  ;

  AllMovies({required this.results});


  factory AllMovies.fromJson(Map<String, dynamic> json) {
    final List<Movie> movieList = [];
    if (json['results'] != null) {
      movieList.addAll(
        json['results'].map<Movie>((item) => Movie.fromJson(item)).toList(),
      );
    }
    return AllMovies(results: movieList);
  }

  List<Movie> getMovies() {
    return results;
  }
}


