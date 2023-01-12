const kfContentLoadingError = "Oops! Can't Connect to $kfAppName 😭";
const kfNoInternetConnectionMessage =
    "Make sure you have Internet connection and then try again";
const kfContentNotFoundMessage =
    "Pardon the interuption. This content is not available at the moment. Please consider checking back later.";
const kfTrimCollapsedText = " More +";

const kfContentRetreaveErrorMessage =
    "An error occurred while trying to retrieve the content.Please check your connection and try again.";

const dummyVideourl =
    "https://assets.mixkit.co/videos/preview/mixkit-group-of-friends-partying-happily-4640-large.mp4";
const kfAppName = "K Flix";
const dummyMovieImageUrl = "https://i.goojara.to/mb_228_228238.jpg";
const kfAppLogoAsset = "assets/images/kenya_flix_logo.png";
const kfMoviesBaseUrl = "https://www.goojara.to/watch-movies";
const kfSeriesBaseUrl = "https://www.goojara.to/watch-series";

String kfSearchIMDBRating(
        {required String query, required String? year, required String type}) =>
    "https://www.google.com/search?q=greys+Anatomy+imdb+rating";

const kfPopularMoviesUrl = "$kfMoviesBaseUrl-popular";
const kfPopularSeriesUrl = "$kfSeriesBaseUrl-popular";

const kfPopularMoviesDatabaseId = 81;
const kfPopularSeriesDatabaseId = 82;

const kfTMDBaseUrl = "https://api.themoviedb.org";
const kfTMDBAPIKEY = "727c59ab265fc8dfe32a7786b0cb2a96";
const kfOriginalTMDBImageUrl = "https://image.tmdb.org/t/p/original";

String kfTMDBSearchImagesUrl({required String type, required String id}) =>
    "https://api.themoviedb.org/3/$type/$id/images?api_key=$kfTMDBAPIKEY";

String kfTMDBSearchVideosUrl({required String type, required String id}) =>
    "https://api.themoviedb.org/3/$type/$id/videos?api_key=$kfTMDBAPIKEY";

String kfTMDBSearchMoviesORSeriesUrl(
        {required String type,
        required String? year,
        required String query,
        bool includeAdult = true}) =>
    "$kfTMDBaseUrl/3/search/$type?api_key=$kfTMDBAPIKEY&query=$query&include_adult=$includeAdult&year=$year";
String kfGetEpisodesUrl({required String id, required String currentSeason}) =>
    "https://api.themoviedb.org/3/tv/$id/season/$currentSeason?api_key=$kfTMDBAPIKEY";

String kfTMDBSearchByIdUrl({required String type, required String id}) =>
    "https://api.themoviedb.org/3/$type/$id?api_key=$kfTMDBAPIKEY";

String kfTMDBSearchCreditsUrl({required String type, required String id}) =>
    "https://api.themoviedb.org/3/$type/$id/credits?api_key=$kfTMDBAPIKEY";

String kfOMDBSearchMoviesOrSeriesUrl(
        {required String query, required String? year, required String type}) =>
    "http://www.omdbapi.com/?t=$query&apikey=f3ffdacf&type=$type&year=$year";

String kfGetCastInformation({required castId}) =>
    "https://api.themoviedb.org/3/person/$castId?api_key=727c59ab265fc8dfe32a7786b0cb2a96";

String grdcookie =
    "wooz=rfsplpsc5gk9gm9fu6trkrjh7r; utkap=dTIzda; xylay=CMhxBb; zgwtz=tZzCVk; thggn=KpOfGC; wyndr=DVFjZA; adpvd=rdGIeR; iagkh=GdArNS; umoua=LBHszh; khzfv=qjVoDk; pmllv=KSASIc; jsgzq=iFJzXx; kvkvg=cIPEet; thwcz=VMziuv; plxol=LrDZRv; odzca=zpPxyi; kjaaw=bwzeuM; fvwoa=srBfpm; ijlwu=qUvIGM; zcbgq=pxNeGy; aoycv=TWTyzx";

const kfPrevButtonLabel = "Prev";
const kfNextButtonLabel = "Next";

int kfmovieDetailSecondaryID = 101;
String kfMoviesDetailBaseUrl = "https://ww1.goojara.to";
String kfMoviesSearchUrl = "https://www.goojara.to/xhrr.php";

const kfGoogleIconImageAsset = "assets/images/icons8-google-480.png";
const kfYoutubeIconImageAsset = "assets/images/icons8-youtube-480.png";

Map<String, String> searchMoviesHeader = {
  "Cookie":
      "aGooz=73jn49bcget1sgjmctl6pkqqkn; d0813dbe=7baddbc1a09caeacce81ac; _555e=CCDD440DAC4E18CF3817A51864146370E99B29F7; 67e2bb18=5606022a16e07a375dd083; _1281=3A8235ECC3D78D818C0AE42734120C2DAD571563; AdskeeperStorage=%7B%220%22%3A%7B%22svspr%22%3A%22https%3A%2F%2Fwww.goojara.to%2FmwOG47%22%2C%22svsds%22%3A1%7D%2C%22C1374985%22%3A%7B%22page%22%3A1%7D%7D; 747a99a6=a06b494648f83745dbfd12; _03db=54659A7E10BAC798D61F9BB1BAECD3FB5DDBAFEB; 6de08a84=0a8454d4353e09387580ea; 0b4c70a3=fec2f2a58ce05fbbd59954",
  // "Accept-Encoding": "gzip, deflate, br",
  // "Accept-Language": "en-US,en;q=0.9,sw;q=0.8",
  // "Content-Length": "6",
  "Content-Type": "application/x-www-form-urlencoded",
  // "Origin": "https://www.goojara.to",
  // "Referer": "http://www.goojara.to/",
  // "sec-ch-ua":
  //     "${"Chromium"};v=${"106"},${"Google Chrome"};v=${"106"},${"Not;A=Brand"};v=${"99"}}",
  // "sec-ch-ua-mobile":"70",
  // "sec-ch-ua-platform": "Linux",
  // "sec-fetch-dest": "empty",
  // "sec-fetch-mode": "cors",
  // "sec-fetch-site": "same-origin",
  // "User-Agent":
  //     "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36"
};

List<int> kfPopularMoviesIDs = List.generate(10, (index) => index + 60);
List<int> kfPopularSeriesIDs = List.generate(10, (index) => index + 70);

const int kfGenreHorizontalImages = 15;

const List<Map<String, dynamic>> trendingNowMovies = [
  {
    "display_title": "Trending Now On $kfAppName",
    "id": 54,
    "url": kfMoviesBaseUrl
  }
];

const List<Map<String, dynamic>> trendingNowSeries = [
  {
    "display_title": "Trending Now On $kfAppName",
    "id": 55,
    "url": kfSeriesBaseUrl
  }
];

const List<Map<String, dynamic>> movies = [
  {
    "display_title": "Action",
    "genre": "action",
    "url": "$kfMoviesBaseUrl-genre-Action",
    "id": 0
  },

  {
    "display_title": "Mystery",
    "genre": "mystery",
    "url": "$kfMoviesBaseUrl-genre-News",
    "id": 16
  },

  {
    "display_title": "Biography",
    "genre": "biography",
    "url": "$kfMoviesBaseUrl-genre-Biography",
    "id": 3
  },
  {
    "display_title": "Comedy",
    "genre": "comedy",
    "url": "$kfMoviesBaseUrl-genre-Comedy",
    "id": 4
  },
  {
    "display_title": "Crime",
    "genre": "crime",
    "url": "$kfMoviesBaseUrl-genre-Crime",
    "id": 5
  },

  {
    "display_title": "Drama",
    "genre": "drama",
    "url": "$kfMoviesBaseUrl-genre-Drama",
    "id": 7
  },
  {
    "display_title": "Adventure",
    "genre": "adventure",
    "url": "$kfMoviesBaseUrl-genre-Adventure",
    "id": 1
  },
  {
    "display_title": "Thrillers",
    "genre": "thriller",
    "url": "$kfMoviesBaseUrl-genre-Thriller",
    "id": 23
  },
  {
    "display_title": "Family",
    "genre": "family",
    "url": "$kfMoviesBaseUrl-genre-Family",
    "id": 8
  },

  {
    "display_title": "Animations",
    "genre": "animation",
    "url": "$kfMoviesBaseUrl-genre-Animation",
    "id": 2
  },
  {
    "display_title": "Fantasy",
    "genre": "fantasy",
    "url": "$kfMoviesBaseUrl-genre-Fantasy",
    "id": 9
  },
  {
    "display_title": "Film-Noir",
    "genre": "action",
    "url": "$kfMoviesBaseUrl-genre-Film-Noir",
    "id": 10
  },
  // {
  //   "display_title": "Game-Show",
  //   "genre": "game-show",
  //   "url": "$kfMoviesBaseUrl-genre-Game-Show",
  //   "id": 11
  // },
  {
    "display_title": "History",
    "genre": "history",
    "url": "$kfMoviesBaseUrl-genre-History",
    "id": 12
  },
  {
    "display_title": "Horror",
    "genre": "horror",
    "url": "$kfMoviesBaseUrl-genre-Horror",
    "id": 13
  },

  {
    "display_title": "Musical",
    "genre": "musical",
    "url": "$kfMoviesBaseUrl-genre-Musical",
    "id": 15
  },
  {
    "display_title": "Documentary",
    "genre": "documentary",
    "url": "$kfMoviesBaseUrl-genre-Documentary",
    "id": 6
  },

  {
    "display_title": "News",
    "genre": "news",
    "url": "$kfMoviesBaseUrl-genre-News",
    "id": 17
  },
  // {
  //   "display_title": "Reality TV",
  //   "genre": "reality-tv",
  //   "url": "$kfMoviesBaseUrl-genre-Reality-TV",
  //   "id": 18
  // },
  {
    "display_title": "Romance",
    "genre": "romance",
    "url": "$kfMoviesBaseUrl-genre-Romance",
    "id": 19
  },
  {
    "display_title": "Sci-fi",
    "genre": "sci-fi",
    "url": "$kfMoviesBaseUrl-genre-Sci-Fi",
    "id": 20
  },
  {
    "display_title": "Sports",
    "genre": "sport",
    "url": "$kfMoviesBaseUrl-genre-Sport",
    "id": 21
  },
  // {
  //   "display_title": "Talk Show",
  //   "genre": "talk-show",
  //   "url": "$kfMoviesBaseUrl-genre-Talk-Show",
  //   "id": 22
  // },

  {
    "display_title": "War",
    "genre": "war",
    "url": "$kfMoviesBaseUrl-genre-War",
    "id": 24
  },
  {
    "display_title": "Music",
    "genre": "music",
    "url": "$kfMoviesBaseUrl-genre-Music",
    "id": 14
  },
  {
    "display_title": "Western",
    "genre": "western",
    "url": "$kfMoviesBaseUrl-genre-Western",
    "id": 25
  },
  // {
  //   "display_title": "Adults",
  //   "genre": "adult",
  //   "url": "$kfMoviesBaseUrl-genre-Adult",
  //   "id": 26
  // },
];

const List<Map<String, dynamic>> series = [
  {
    "display_title": "Action",
    "genre": "action",
    "url": "$kfSeriesBaseUrl-genre-Action",
    "id": 27
  },
  {
    "display_title": "Adventure",
    "genre": "adventure",
    "url": "$kfSeriesBaseUrl-genre-Adventure",
    "id": 28
  },
  {
    "display_title": "Animations",
    "genre": "animation",
    "url": "$kfSeriesBaseUrl-genre-Animation",
    "id": 29
  },
  {
    "display_title": "Biography",
    "genre": "biography",
    "url": "$kfSeriesBaseUrl-genre-Biography",
    "id": 30
  },
  {
    "display_title": "Comedy",
    "genre": "comedy",
    "url": "$kfSeriesBaseUrl-genre-Comedy",
    "id": 31
  },
  {
    "display_title": "Crime",
    "genre": "crime",
    "url": "$kfSeriesBaseUrl-genre-Crime",
    "id": 32
  },
  {
    "display_title": "Documentary",
    "genre": "documentary",
    "url": "$kfSeriesBaseUrl-genre-Documentary",
    "id": 33
  },
  {
    "display_title": "Drama",
    "genre": "drama",
    "url": "$kfSeriesBaseUrl-genre-Drama",
    "id": 34
  },
  {
    "display_title": "Family",
    "genre": "family",
    "url": "$kfSeriesBaseUrl-genre-Family",
    "id": 35
  },
  {
    "display_title": "Fantasy",
    "genre": "fantasy",
    "url": "$kfSeriesBaseUrl-genre-Fantasy",
    "id": 36
  },
  {
    "display_title": "Game-Show",
    "genre": "game-show",
    "url": "$kfSeriesBaseUrl-genre-Game-Show",
    "id": 38
  },
  {
    "display_title": "History",
    "genre": "history",
    "url": "$kfSeriesBaseUrl-genre-History",
    "id": 39
  },
  {
    "display_title": "Horror",
    "genre": "horror",
    "url": "$kfSeriesBaseUrl-genre-Horror",
    "id": 40
  },
  {
    "display_title": "Music",
    "genre": "music",
    "url": "$kfSeriesBaseUrl-genre-Music",
    "id": 41
  },
  {
    "display_title": "Mystery",
    "genre": "mystery",
    "url": "$kfSeriesBaseUrl-genre-News",
    "id": 43
  },
  {
    "display_title": "Reality TV",
    "genre": "reality-tv",
    "url": "$kfSeriesBaseUrl-genre-Reality-TV",
    "id": 45
  },
  {
    "display_title": "Romance",
    "genre": "romance",
    "url": "$kfSeriesBaseUrl-genre-Romance",
    "id": 46
  },
  {
    "display_title": "Sci-fi",
    "genre": "sci-fi",
    "url": "$kfSeriesBaseUrl-genre-Sci-Fi",
    "id": 47
  },
  {
    "display_title": "Sports",
    "genre": "sport",
    "url": "$kfSeriesBaseUrl-genre-Sport",
    "id": 48
  },
  {
    "display_title": "Talk Show",
    "genre": "talk-show",
    "url": "$kfSeriesBaseUrl-genre-Talk-Show",
    "id": 49
  },
  {
    "display_title": "Thrillers",
    "genre": "thriller",
    "url": "$kfSeriesBaseUrl-genre-Thriller",
    "id": 50
  },
  {
    "display_title": "War",
    "genre": "war",
    "url": "$kfSeriesBaseUrl-genre-War",
    "id": 51
  },
  {
    "display_title": "Western",
    "genre": "western",
    "url": "$kfSeriesBaseUrl-genre-Western",
    "id": 52
  },
];

final List<Map<String, String>> genres = [
  {"name": 'Action', "path": "-genre-Action"},
  {"name": 'Adventure', "path": "-genre-Adventure"},
  {"name": 'Animation', "path": "-genre-Animation"},
  {"name": 'Biography', "path": "-genre-Biography"},
  {"name": 'Comedy', "path": "-genre-Comedy"},
  {"name": 'Crime', "path": "-genre-Crime"},
  {"name": 'Documentary', "path": "-genre-Documentary"},
  {"name": 'Drama', "path": "-genre-Drama"},
  {"name": 'Family', "path": "-genre-Family"},
  {"name": 'Fantasy', "path": "-genre-Fantasy"},
  {"name": 'Film-Noir', "path": "-genre-Film-Noir"},
  {"name": 'Game-Show', "path": "-genre-Game-Show"},
  {"name": 'History', "path": "-genre-History"},
  {"name": 'Horror', "path": "-genre-Horror"},
  {"name": 'Music', "path": "-genre-Music"},
  {"name": 'Musical', "path": "-genre-Musical"},
  {"name": 'Mystery', "path": "-genre-Mystery"},
  {"name": 'News', "path": "-genre-News"},
  {"name": 'Reality-TV', "path": "-genre-Reality-TV"},
  {"name": 'Romance', "path": "-genre-Romance"},
  {"name": 'Sci-Fi', "path": "-genre-Sci-Fi"},
  {"name": 'Sport', "path": "-genre-Sport"},
  {"name": 'Talk-Show', "path": "-genre-Talk-Show"},
  {"name": 'Thriller', "path": "-genre-Thriller"},
  {"name": 'War', "path": "-genre-War"},
  {"name": 'Western', "path": "-genre-Western"},
];

final List<Map<String, String>> category = [
  {
    "name": "Movies",
    "url": kfMoviesBaseUrl,
  },
  {
    "name": "Series",
    "url": kfSeriesBaseUrl,
  }
];

String webCookie =
    "wooz=rfsplpsc5gk9gm9fu6trkrjh7r; utkap=dTIzda; xylay=CMhxBb; zgwtz=tZzCVk; thggn=KpOfGC; wyndr=DVFjZA; adpvd=rdGIeR; iagkh=GdArNSad";
