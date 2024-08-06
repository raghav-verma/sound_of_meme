class RemoteDataBaseConstants {
  static const String baseUrl = 'http://143.244.131.156:8000';
  //Headers
  static const String authorizationHeader = 'Authorization';
  static const String authorizationBearer = 'Bearer ';
  static const String accept = 'Accept';
  static const String acceptValue = '*/*';
  static const String connection = 'Connection';
  static const String connectionValue = 'keep-alive';
  static const String page = 'page';
  static const String id = 'id';
  static const String detail = 'detail';
  static const String audioMediaType = 'audio';
  static const String audioMediaSubType = 'mpeg';
  static const String file = 'file';
  static const String prompt = 'prompt';
  static const String lyrics = 'lyrics';
  //Endpoints
  static const String loginEndPoint = '/login';
  static const String signUpEndPoint = '/signup';
  static const String googleLoginEndPoint = '/googlelogin';
  static const String allSongsEndPoint = '/allsongs';
  static const String userSongsEndPoint = '/usersongs';
  static const String getSongByIdEndPoint = '/getsongbyid';
  static const String createEndPoint = '/create';
  static const String createCustomEndPoint = '/createcustom';
  static const String userDetailsEndPoint = '/user';
  static const String viewEndPoint = '/view';
  static const String likeEndPoint = '/like';
  static const String disLikeEndPoint = '/dislike';
  static const String cloneSongEndPoint = '/clonesong';
}
