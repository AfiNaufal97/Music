import 'package:equatable/equatable.dart';
import 'package:music_apps/model/favotestdb.dart';

abstract class EventFav extends Equatable{
}

class EventAddFav extends EventFav{
  FavoritesDB favoritesDB;
  EventAddFav({required this.favoritesDB});

  @override
  // TODO: implement props
  List<Object?> get props => [favoritesDB];
}

class EventCheckData extends EventFav{
  FavoritesDB favoritesDB;
  EventCheckData({required this.favoritesDB});

  @override
  // TODO: implement props
  List<Object?> get props => [favoritesDB];

}

class EventGetAll extends EventFav{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

