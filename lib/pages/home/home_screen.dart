import 'package:flutter/material.dart';
import 'package:music_apps/pages/detail/detail_screen.dart';
import 'package:music_apps/pages/home/widgets/list_music.dart';
import 'package:music_apps/styles/FontStyles.dart';
import '../../music/list_music.dart';
import '../../styles/color/color_app.dart';
import '../../utils/routes/Routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.backgroundColor,
      appBar: AppBar(
        title: Text(
          'List Music',
          style: FontStyles.semiBold.copyWith(color: ColorApp.black),
        ),
        centerTitle: true,
        backgroundColor: ColorApp.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorApp.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.favorite);
              },
              child: const Icon(
                Icons.favorite,
                size: 30,
                color: ColorApp.black,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: ListMusic.list
              .map((e) => ListMusicWidget(
                    imageCover: 'assets/ic_music.png',
                    title: e.title,
                    artist: e.artist,
                    url: e.url,
                    func: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                  music: e,
                                  index: ListMusic.list.indexOf(e),
                                ))),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
