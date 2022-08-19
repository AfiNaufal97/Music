import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_apps/bloc/fav/bloc_fav.dart';
import 'package:music_apps/bloc/fav/event_fav.dart';
import 'package:music_apps/model/favotestdb.dart';
import 'package:music_apps/music/list_music.dart';
import 'package:music_apps/styles/FontStyles.dart';
import '../../styles/color/color_app.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  FavoritesDB music;
  int index;

  DetailScreen({Key? key, required this.music, required this.index})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var player = AudioPlayer();
  bool isPLay = false;
  int? indexNow;
  String url = '';
  FavoritesDB? music;
  Duration? duration;

  void status(bool value) async {
    if (value) {
      await player.play();
      setState(() {
        duration = player.durationStream as Duration?;
      });
      print("duration ");
    } else {
      await player.stop();
    }
  }

  void next() {
    if (indexNow! == ListMusic.list.length - 1) {
      setState(() {
        indexNow = 0;
        music = ListMusic.list[indexNow!];
      });
    } else {
      setState(() {
        indexNow = indexNow! + 1;
        music = ListMusic.list[indexNow!];
      });
      print(indexNow!);
    }
  }

  void prev() {
    if (indexNow! == 0) {
      setState(() {
        indexNow = ListMusic.list.length - 1;
        music = ListMusic.list[indexNow!];
      });
    } else {
      setState(() {
        indexNow = indexNow! - 1;
        music = ListMusic.list[indexNow!];
      });
      print(indexNow!);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      url = widget.music.url;
      music = widget.music;
      indexNow = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp.backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorApp.black),
        actions: [
          GestureDetector(
              onTap: () {
                context.read<BlocFav>().add(EventAddFav(
                    favoritesDB: FavoritesDB(
                        artist: music!.artist,
                        title: music!.title,
                        url: music!.url)));
              },
              child: const Icon(
                Icons.favorite_border,
                size: 30,
                color: ColorApp.red,
              ))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/ic_music.png'))),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                music!.title.toString(),
                style: FontStyles.semiBold.copyWith(fontSize: 20),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(music!.artist,
                  style: FontStyles.medium
                      .copyWith(fontSize: 18, color: ColorApp.gray)),
              const SizedBox(
                height: 40,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () async {
                        prev();
                      },
                      child: Image.asset(
                        'assets/ic_prev.png',
                        width: 30,
                      )),
                  GestureDetector(
                      onTap: () async {
                        await player.setUrl(music!.url);
                        setState(() {
                          isPLay = !isPLay;
                        });
                        status(isPLay);
                      },
                      child: Image.asset(
                        'assets/${!isPLay ? 'ic_play' : 'ic_pause'}.png',
                        width: 30,
                      )),
                  GestureDetector(
                      onTap: () {
                        next();
                      },
                      child: Image.asset(
                        'assets/ic_next.png',
                        width: 30,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
