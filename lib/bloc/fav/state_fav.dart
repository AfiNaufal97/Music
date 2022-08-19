import 'package:equatable/equatable.dart';
import 'package:music_apps/model/favotestdb.dart';

abstract class StateFav extends Equatable {}

class StateLoading extends StateFav {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class StateInit extends StateFav {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

// ignore: must_be_immutable
class StateError extends StateFav {
  String error;

  StateError({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

// ignore: must_be_immutable
class StateSuccessAddFav extends StateFav {
  int result;

  StateSuccessAddFav({required this.result});

  @override
  // TODO: implement props
  List<Object?> get props => [result];
}

class StateCheckFav extends StateFav {
  FavoritesDB? favoritesDB;

  StateCheckFav({required this.favoritesDB});

  @override
  // TODO: implement props
  List<Object?> get props => [favoritesDB];
}

class StateGetAll extends StateFav {
  List<FavoritesDB> favorites;

  StateGetAll({required this.favorites});

  @override
  // TODO: implement props
  List<Object?> get props => [favorites];
}
