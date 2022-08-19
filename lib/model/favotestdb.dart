class FavoritesDB {
  int? id;
  String title;
  String artist;
  String url;

  FavoritesDB(
      {this.id,
      required this.url,
      required this.artist,
      required this.title});

  factory FavoritesDB.fromJson(Map<String, dynamic> json) {
    return FavoritesDB(
        id: json['id'],
        url: json['url'],
        artist: json['artist'],
        title: json['title']);
  }

  Map<String, dynamic> toJson(){
    return {
      "id":id,
      "title":title,
      "artist":artist,
      "url":url
    };
  }
}
