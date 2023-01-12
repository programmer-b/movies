class KFTMDBSearchTvByIdModel {
  KFTMDBSearchTvByIdModel({
    required this.adult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });
  late final bool? adult;
  late final String? backdropPath;
  late final List<CreatedBy>? createdBy;
  late final List<int>? episodeRunTime;
  late final String? firstAirDate;
  late final List<Genres>? genres;
  late final String? homepage;
  late final int? id;
  late final bool? inProduction;
  late final List<String>? languages;
  late final String? lastAirDate;
  late final LastEpisodeToAir? lastEpisodeToAir;
  late final String? name;
  late final NextEpisodeToAir? nextEpisodeToAir;
  late final List<Networks>? networks;
  late final int numberOfEpisodes;
  late final int numberOfSeasons;
  late final List<String>? originCountry;
  late final String? originalLanguage;
  late final String? originalName;
  late final String? overview;
  late final double? popularity;
  late final String? posterPath;
  late final List<ProductionCompanies>? productionCompanies;
  late final List<ProductionCountries>? productionCountries;
  late final List<Seasons>? seasons;
  late final List<SpokenLanguages>? spokenLanguages;
  late final String? status;
  late final String? tagline;
  late final String? type;
  late final double? voteAverage;
  late final int? voteCount;
  
  KFTMDBSearchTvByIdModel.fromJson(Map<String, dynamic> json){
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    createdBy = List.from(json['created_by']).map((e)=>CreatedBy.fromJson(e)).toList();
    episodeRunTime = List.castFrom<dynamic, int>(json['episode_run_time']);
    firstAirDate = json['first_air_date'];
    genres = List.from(json['genres']).map((e)=>Genres.fromJson(e)).toList();
    homepage = json['homepage'];
    id = json['id'];
    inProduction = json['in_production'];
    languages = List.castFrom<dynamic, String>(json['languages']);
    lastAirDate = json['last_air_date'];
    lastEpisodeToAir = LastEpisodeToAir.fromJson(json['last_episode_to_air']);
    name = json['name'];
    nextEpisodeToAir = NextEpisodeToAir?.fromJson(json['next_episode_to_air'] ?? {});
    networks = List.from(json['networks']).map((e)=>Networks.fromJson(e)).toList();
    numberOfEpisodes = json['number_of_episodes'];
    numberOfSeasons = json['number_of_seasons'];
    originCountry = List.castFrom<dynamic, String>(json['origin_country']);
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    productionCompanies = List.from(json['production_companies']).map((e)=>ProductionCompanies.fromJson(e)).toList();
    productionCountries = List.from(json['production_countries']).map((e)=>ProductionCountries.fromJson(e)).toList();
    seasons = List.from(json['seasons']).map((e)=>Seasons.fromJson(e)).toList();
    spokenLanguages = List.from(json['spoken_languages']).map((e)=>SpokenLanguages.fromJson(e)).toList();
    status = json['status'];
    tagline = json['tagline'];
    type = json['type'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['created_by'] = createdBy?.map((e)=>e.toJson()).toList();
    data['episode_run_time'] = episodeRunTime;
    data['first_air_date'] = firstAirDate;
    data['genres'] = genres?.map((e)=>e.toJson()).toList();
    data['homepage'] = homepage;
    data['id'] = id;
    data['in_production'] = inProduction;
    data['languages'] = languages;
    data['last_air_date'] = lastAirDate;
    data['last_episode_to_air'] = lastEpisodeToAir?.toJson();
    data['name'] = name;
    data['next_episode_to_air'] = nextEpisodeToAir?.toJson();
    data['networks'] = networks?.map((e)=>e.toJson()).toList();
    data['number_of_episodes'] = numberOfEpisodes;
    data['number_of_seasons'] = numberOfSeasons;
    data['origin_country'] = originCountry;
    data['original_language'] = originalLanguage;
    data['original_name'] = originalName;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['production_companies'] = productionCompanies?.map((e)=>e.toJson()).toList();
    data['production_countries'] = productionCountries?.map((e)=>e.toJson()).toList();
    data['seasons'] = seasons?.map((e)=>e.toJson()).toList();
    data['spoken_languages'] = spokenLanguages?.map((e)=>e.toJson()).toList();
    data['status'] = status;
    data['tagline'] = tagline;
    data['type'] = type;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    required this.profilePath,
  });
  late final int id;
  late final String creditId;
  late final String name;
  late final int gender;
  late final String profilePath;
  
  CreatedBy.fromJson(Map<String, dynamic> json){
    id = json['id'];
    creditId = json['credit_id'];
    name = json['name'];
    gender = json['gender'];
    profilePath = json['profile_path'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['credit_id'] = creditId;
    data['name'] = name;
    data['gender'] = gender;
    data['profile_path'] = profilePath;
    return data;
  }
}

class Genres {
  Genres({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;
  
  Genres.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class LastEpisodeToAir {
  LastEpisodeToAir({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.showId,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });
  late final String airDate;
  late final int episodeNumber;
  late final int id;
  late final String name;
  late final String overview;
  late final String productionCode;
  late final int runtime;
  late final int seasonNumber;
  late final int showId;
  late final String stillPath;
  late final double voteAverage;
  late final int voteCount;
  
  LastEpisodeToAir.fromJson(Map<String, dynamic> json){
    airDate = json['air_date'] ?? "";
    episodeNumber = json['episode_number'] ?? 0;
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    overview = json['overview'] ?? "";
    productionCode = json['production_code'] ?? "";
    runtime = json['runtime'] ?? 0;
    seasonNumber = json['season_number'] ?? 0;
    showId = json['show_id'] ?? 0;
    stillPath = json['still_path'] ?? "";
    voteAverage = json['vote_average']?.toDouble() ?? 0.0;
    voteCount = json['vote_count'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['air_date'] = airDate;
    data['episode_number'] = episodeNumber;
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['production_code'] = productionCode;
    data['runtime'] = runtime;
    data['season_number'] = seasonNumber;
    data['show_id'] = showId;
    data['still_path'] = stillPath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}

class NextEpisodeToAir {
  NextEpisodeToAir({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
     this.runtime,
    required this.seasonNumber,
    required this.showId,
     this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });
  late final String airDate;
  late final int episodeNumber;
  late final int id;
  late final String name;
  late final String overview;
  late final String productionCode;
  late final dynamic runtime;
  late final int seasonNumber;
  late final int showId;
  late final dynamic stillPath;
  late final double voteAverage;
  late final int voteCount;
  
  NextEpisodeToAir.fromJson(Map<String, dynamic> json){
    airDate = json['air_date'] ?? "";
    episodeNumber = json['episode_number'] ?? 0;
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    overview = json['overview'] ?? "";
    productionCode = json['production_code'] ?? "";
    runtime = json['runtime'] ?? "";
    seasonNumber = json['season_number'] ?? 0;
    showId = json['show_id'] ?? 0;
    stillPath = json['still_path'] ?? "";
    voteAverage = json['vote_average']?.toDouble() ?? 0.0;
    voteCount = json['vote_count'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['air_date'] = airDate;
    data['episode_number'] = episodeNumber;
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['production_code'] = productionCode;
    data['runtime'] = runtime;
    data['season_number'] = seasonNumber;
    data['show_id'] = showId;
    data['still_path'] = stillPath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}

class Networks {
  Networks({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });
  late final int id;
  late final String name;
  late final String logoPath;
  late final String originCountry;
  
  Networks.fromJson(Map<String, dynamic> json){
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    logoPath = json['logo_path'] ?? "";
    originCountry = json['origin_country'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['logo_path'] = logoPath;
    data['origin_country'] = originCountry;
    return data;
  }
}

class ProductionCompanies {
  ProductionCompanies({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });
  late final int id;
  late final String logoPath;
  late final String name;
  late final String originCountry;
  
  ProductionCompanies.fromJson(Map<String, dynamic> json){
    id = json['id'] ?? 0;
    logoPath = json['logo_path'] ?? "";
    name = json['name'] ?? "";
    originCountry = json['origin_country'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['logo_path'] = logoPath;
    data['name'] = name;
    data['origin_country'] = originCountry;
    return data;
  }
}

class ProductionCountries {
  ProductionCountries({
    required this.iso_3166_1,
    required this.name,
  });
  late final String iso_3166_1;
  late final String name;
  
  ProductionCountries.fromJson(Map<String, dynamic> json){
    iso_3166_1 = json['iso_3166_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['iso_3166_1'] = iso_3166_1;
    data['name'] = name;
    return data;
  }
}

class Seasons {
  Seasons({
     this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });
  late final String? airDate;
  late final int episodeCount;
  late final int id;
  late final String name;
  late final String overview;
  late final String posterPath;
  late final int seasonNumber;
  
  Seasons.fromJson(Map<String, dynamic> json){
    airDate = json["air_date"] ?? "";
    episodeCount = json['episode_count'] ?? 0;
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    overview = json['overview'] ?? "";
    posterPath = json['poster_path'] ?? "";
    seasonNumber = json['season_number'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['air_date'] = airDate;
    data['episode_count'] = episodeCount;
    data['id'] = id;
    data['name'] = name;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['season_number'] = seasonNumber;
    return data;
  }
}

class SpokenLanguages {
  SpokenLanguages({
    required this.englishName,
    required this.iso_639_1,
    required this.name,
  });
  late final String englishName;
  late final String iso_639_1;
  late final String name;
  
  SpokenLanguages.fromJson(Map<String, dynamic> json){
    englishName = json['english_name'] ?? "";
    iso_639_1 = json['iso_639_1'] ?? "";
    name = json['name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['english_name'] = englishName;
    data['iso_639_1'] = iso_639_1;
    data['name'] = name;
    return data;
  }
}