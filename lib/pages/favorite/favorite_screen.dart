import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_apps/bloc/fav/bloc_fav.dart';
import 'package:music_apps/bloc/fav/event_fav.dart';
import 'package:music_apps/bloc/fav/state_fav.dart';
import 'package:music_apps/model/favotestdb.dart';
import 'package:music_apps/pages/detail/detail_screen.dart';
import 'package:music_apps/pages/home/widgets/list_music.dart';
import '../../styles/FontStyles.dart';
import '../../styles/color/color_app.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    context.read<BlocFav>().add(EventGetAll());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Music',
          style: FontStyles.semiBold.copyWith(color: ColorApp.black),
        ),
        centerTitle: true,
        backgroundColor: ColorApp.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorApp.black),
      ),
      body: BlocBuilder<BlocFav, StateFav>(
        builder: (context, state) {
          if (state is StateGetAll) {
            return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.favorites.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                      key: Key(state.favorites[index].id!.toString()),
                      onDismissed: (direction) {},
                      child: ListMusicWidget(
                          imageCover: 'assets/ic_music.png',
                          title: state.favorites[index].title,
                          artist: state.favorites[index].artist,
                          url: state.favorites[index].url,
                          func: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                          music: FavoritesDB(
                                              url: state.favorites[index].url,
                                              title:
                                                  state.favorites[index].title,
                                              artist: state
                                                  .favorites[index].artist),
                                          index: index,
                                        )));
                          }));
                });
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
