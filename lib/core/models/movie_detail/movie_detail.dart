import 'package:json_annotation/json_annotation.dart';
import 'package:movies_app/core/models/movie_list/movie_list.dart';

part 'movie_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieDetail {
  bool adult;

  @JsonKey(name: 'backdrop_path')
  String? backdropPath;

  int budget;

  List<MovieDetailGenre> genres;

  String homepage;

  int id;

  @JsonKey(name: 'imdb_id')
  String imdbId;

  @JsonKey(name: 'original_language')
  String originalLanguage;

  @JsonKey(name: 'original_title')
  String originalTitle;

  String overview;

  double popularity;

  @JsonKey(name: 'poster_path')
  String posterPath;

  @JsonKey(name: 'production_companies')
  List<MovieDetailProductionCompany> productionCompanies;

  @JsonKey(name: 'production_countries')
  List<MovieDetailProductionCountry> productionCountries;

  @JsonKey(name: 'release_date')
  String releaseDate;

  int revenue;

  int runtime;

  @JsonKey(name: 'spoken_languages')
  List<MovieDetailSpokenLanguage> spokenLanguages;

  String status;

  String tagline;

  String title;

  bool video;

  @JsonKey(name: 'vote_average')
  double voteAverage;

  @JsonKey(name: 'vote_count')
  int voteCount;

  MovieDetail({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailToJson(this);

  MovieList getMovieList() {
    return MovieList(
      adult: this.adult,
      backdropPath: this.backdropPath,
      genreIds: this.genres.map((e) => e.id).toList(),
      id: this.id,
      originalLanguage: this.originalLanguage,
      originalTitle: this.originalTitle,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      releaseDate: this.releaseDate,
      title: this.title,
      video: this.video,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MovieDetailGenre {
  int id;
  String name;

  MovieDetailGenre({
    required this.id,
    required this.name,
  });

  factory MovieDetailGenre.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailGenreFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailGenreToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MovieDetailProductionCompany {
  int id;

  @JsonKey(name: 'logo_path')
  String? logoPath;

  String name;

  @JsonKey(name: 'origin_country')
  String originCountry;

  MovieDetailProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory MovieDetailProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailProductionCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailProductionCompanyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MovieDetailProductionCountry {
  @JsonKey(name: 'iso_3166_1')
  String iso31661;

  String name;

  MovieDetailProductionCountry({
    required this.iso31661,
    required this.name,
  });

  factory MovieDetailProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailProductionCountryFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailProductionCountryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MovieDetailSpokenLanguage {
  @JsonKey(name: 'english_name')
  String englishName;

  @JsonKey(name: 'iso_639_1')
  String iso6391;

  String name;

  MovieDetailSpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory MovieDetailSpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailSpokenLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailSpokenLanguageToJson(this);
}
