import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_apps/bloc/fav/bloc_fav.dart';
import 'package:music_apps/pages/favorite/favorite_screen.dart';
import 'package:music_apps/pages/home/home_screen.dart';
import 'package:music_apps/utils/routes/Routes.dart';

void main() {
  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => BlocFav())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.home,
        routes: {
          Routes.home: (context) => const HomeScreen(),
          Routes.favorite: (context) => const FavoriteScreen(),
        },
      ),
    );
  }
}
