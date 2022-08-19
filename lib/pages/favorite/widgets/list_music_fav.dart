import 'package:flutter/material.dart';
import 'package:music_apps/styles/FontStyles.dart';
import 'package:music_apps/styles/color/color_app.dart';

// ignore: must_be_immutable
class ListMusicFavWidget extends StatelessWidget {
  String imageCover;
  String title;
  String artist;
  String url;
  void Function()? funcDelete;
  void Function() func;

  ListMusicFavWidget(
      {Key? key,
      this.imageCover = 'assets/ic_music.png',
      this.funcDelete,
      required this.title,
      required this.artist,
      required this.url,
      required this.func})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: ColorApp.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Image.asset(
            imageCover,
            width: 80,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(children: [
                Text(
                  title,
                  style: FontStyles.semiBold.copyWith(
                    fontSize: 18,
                  ),
                ),
              ]),
              Wrap(children: [
                Text(title,
                    style: FontStyles.medium
                        .copyWith(fontSize: 15, color: ColorApp.gray)),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
