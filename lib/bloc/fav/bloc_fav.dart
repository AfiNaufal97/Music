import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_apps/bloc/fav/event_fav.dart';
import 'package:music_apps/bloc/fav/state_fav.dart';
import 'package:music_apps/localdb/favorites.dart';

class BlocFav extends Bloc<EventFav, StateFav> {
  BlocFav() : super(StateInit()) {
    on<EventFav>((event, emit) async {
      if (event is EventAddFav) {
        try {
          emit(StateLoading());
          Favorites db = Favorites();
          await db.database();
          var result = await db.insert(event.favoritesDB.toJson());
          emit(StateSuccessAddFav(result: result));
        } catch (e) {
          emit(StateError(error: e.toString()));
        }
      }

      if (event is EventCheckData) {
        try {
          emit(StateLoading());
          Favorites db = Favorites();
          await db.database();
          var result = await db.search(event.favoritesDB);
          emit(StateCheckFav(favoritesDB: result));
        } catch (e) {
          emit(StateError(error: e.toString()));
        }
      }

      if (event is EventGetAll) {
        try {
          emit(StateLoading());
          Favorites db = Favorites();
          await db.database();
          var result = await db.getAllFav();
          emit(StateGetAll(favorites: result));
        } catch (e) {
          emit(StateError(error: e.toString()));
        }
      }


    });
  }
}
