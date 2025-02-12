class Movie{
  bool adult =false;
  List<int>? genre_ids ;
  int id =0;
  String  backdrop_path ='';
  String original_language ="";
  String original_title ='';
  String poster_path ='';
  String overview ='';
  String release_date ='';
  String title ="";
  double popularity =0.0;
  double vote_average =0.0;
  int vote_count =0;
  bool video =false;

  Movie({required this.id,required this.title,required this.poster_path
    ,required this.overview,required this.adult});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      poster_path: json['poster_path'],
      overview: json['overview'],
      adult: json['adult'],
    );
  }
}