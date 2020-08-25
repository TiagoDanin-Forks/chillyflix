import 'dart:convert';
import 'package:http/http.dart' as http;


class TolokaService {
  String baseUrl = 'https://tf.auct.eu';

  Future<List<Movie>> getMovies(int page) async {
    if (page < 1) page = 1;
    var res = await http.get('$baseUrl/?format=json&page=$page');
    var movies = List<Movie>();
    if (res.statusCode == 200) {
      jsonDecode(res.body)['data'].forEach((item) => movies.add(Movie.fromJson(item)));
    } else {
      print(res.statusCode);
      print(res.body);
    }
    return movies;
  }
}

class Movie {
  String kinobazaSlug;
  int kinobazaVotes;
  int kinobazaRating;
  int imdbTop250;
  int imdbId;
  String rated;
  String title;
  String titleUk;
  int runtime;
  int year;
  String actors;
  String plot;
  String plotUk;
  int metascore;
  double imdbRating;
  int imdbVotes;
  bool hasPoster;
  String poster;
  List<Genres> genres;
  List<Countries> countries;
  List<Threads> threads;

  Movie(
      {this.kinobazaSlug,
      this.kinobazaVotes,
      this.kinobazaRating,
      this.imdbTop250,
      this.imdbId,
      this.rated,
      this.title,
      this.titleUk,
      this.runtime,
      this.year,
      this.actors,
      this.plot,
      this.plotUk,
      this.metascore,
      this.imdbRating,
      this.imdbVotes,
      this.hasPoster,
      this.genres,
      this.countries,
      this.threads});

  Movie.fromJson(Map<String, dynamic> json) {
    kinobazaSlug = json['kinobaza_slug'];
    kinobazaVotes = json['kinobaza_votes'];
    kinobazaRating = json['kinobaza_rating'];
    imdbTop250 = json['imdb_top_250'];
    imdbId = json['imdb_id'];
    rated = json['rated'];
    title = json['title'];
    titleUk = json['title_uk'].replaceAll("&quot;",'"');
    runtime = json['runtime'];
    year = json['year'];
    actors = json['actors'];
    plot = json['plot'];
    plotUk = json['plot_uk'];
    metascore = json['metascore'];
    imdbRating = json['imdb_rating'].toDouble();
    imdbVotes = json['imdb_votes'];
    hasPoster = json['has_poster'] != 0;
    if (hasPoster) {
      poster = "https://i.auct.eu/posters/$imdbId.jpg";
    }
    if (json['genres'] != null) {
      genres = new List<Genres>();
      json['genres'].forEach((v) {
        genres.add(new Genres.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      countries = new List<Countries>();
      json['countries'].forEach((v) {
        countries.add(new Countries.fromJson(v));
      });
    }
    if (json['threads'] != null) {
      threads = new List<Threads>();
      json['threads'].forEach((v) {
        threads.add(new Threads.fromJson(v));
      });
    }
  }
}

class Genres {
  int id;
  String name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Countries {
  int id;
  String name;
  String nameUk;

  Countries({this.id, this.name, this.nameUk});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameUk = json['name_uk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_uk'] = this.nameUk;
    return data;
  }
}

class Threads {
  int id;
  String title;
  int imdbId;
  String torrentSize;

  Threads({this.id, this.title, this.imdbId, this.torrentSize});

  Threads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imdbId = json['imdb_id'];
    torrentSize = json['torrent_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['imdb_id'] = this.imdbId;
    data['torrent_size'] = this.torrentSize;
    return data;
  }
}
