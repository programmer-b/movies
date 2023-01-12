import 'package:movies/Models/kf_movie_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class KFMovieDatabase {
  static final KFMovieDatabase instance = KFMovieDatabase._init();
  static Database? _database;
  KFMovieDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('movies.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableMovies (
  ${MovieFields.id} $idType,
   ${MovieFields.genreGeneratedMovieData} $textType,
   ${MovieFields.tmdbID} $idType,
   ${MovieFields.year} $textType,
   ${MovieFields.backdropsPath} $textType,
   ${MovieFields.posterPath} $textType,
   ${MovieFields.releaseDate} $textType,
   ${MovieFields.overview} $textType,
   ${MovieFields.title} $textType,
   ${MovieFields.homeUrl} $textType
)
''');
  }

  Future<KFMovieModel> create(KFMovieModel movie) async {
    final db = await instance.database;
    final id = await db.insert(tableMovies, movie.toJson());
    return movie.copy(id: id);
  }

  Future<KFMovieModel?> readMovie(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableMovies,
        columns: MovieFields.values,
        where: '${MovieFields.id} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return KFMovieModel.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<KFMovieModel>> readAllMovies() async {
    final db = await instance.database;

    final result = await db.query(tableMovies);
    return result.map((json) => KFMovieModel.fromJson(json)).toList();
  }

  Future<int> update(KFMovieModel movie) async {
    final db = await instance.database;
    return db.update(tableMovies, movie.toJson(),
        where: '${MovieFields.id} = ?', whereArgs: [movie.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db
        .delete(tableMovies, where: '${MovieFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
