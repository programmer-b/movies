class KFTMDBSearchImagesModel {
  KFTMDBSearchImagesModel({
    required this.backdrops,
    required this.id,
    required this.logos,
    required this.posters,
  });
  late final List<Backdrops> backdrops;
  late final int id;
  late final List<Logos> logos;
  late final List<Posters> posters;
  
  KFTMDBSearchImagesModel.fromJson(Map<String, dynamic> json){
    backdrops = List.from(json['backdrops']).map((e)=>Backdrops.fromJson(e)).toList();
    id = json['id'];
    logos = List.from(json['logos']).map((e)=>Logos.fromJson(e)).toList();
    posters = List.from(json['posters']).map((e)=>Posters.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['backdrops'] = backdrops.map((e)=>e.toJson()).toList();
    data['id'] = id;
    data['logos'] = logos.map((e)=>e.toJson()).toList();
    data['posters'] = posters.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Backdrops {
  Backdrops({
    required this.aspectRatio,
    required this.height,
     this.iso_639_1,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });
  late final double aspectRatio;
  late final int height;
  late final String? iso_639_1;
  late final String filePath;
  late final double? voteAverage;
  late final int voteCount;
  late final int width;
  
  Backdrops.fromJson(Map<String, dynamic> json){
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso_639_1 = null;
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['aspect_ratio'] = aspectRatio;
    data['height'] = height;
    data['iso_639_1'] = iso_639_1;
    data['file_path'] = filePath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['width'] = width;
    return data;
  }
}

class Logos {
  Logos({
    required this.aspectRatio,
    required this.height,
    required this.iso_639_1,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });
  late final double aspectRatio;
  late final int height;
  late final String iso_639_1;
  late final String filePath;
  late final int voteAverage;
  late final int voteCount;
  late final int width;
  
  Logos.fromJson(Map<String, dynamic> json){
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso_639_1 = json['iso_639_1'];
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['aspect_ratio'] = aspectRatio;
    data['height'] = height;
    data['iso_639_1'] = iso_639_1;
    data['file_path'] = filePath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['width'] = width;
    return data;
  }
}

class Posters {
  Posters({
    required this.aspectRatio,
    required this.height,
     this.iso_639_1,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });
  late final double aspectRatio;
  late final int height;
  late final String? iso_639_1;
  late final String filePath;
  late final double? voteAverage;
  late final int voteCount;
  late final int width;
  
  Posters.fromJson(Map<String, dynamic> json){
    aspectRatio = json['aspect_ratio'];
    height = json['height'];
    iso_639_1 = null;
    filePath = json['file_path'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['aspect_ratio'] = aspectRatio;
    data['height'] = height;
    data['iso_639_1'] = iso_639_1;
    data['file_path'] = filePath;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['width'] = width;
    return data;
  }
}