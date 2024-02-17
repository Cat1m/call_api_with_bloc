import 'package:call_api/PhotosScreen.dart';
import 'package:call_api/PostsScreen.dart';
import 'package:call_api/bloc/photos/photos_bloc.dart';
import 'package:call_api/bloc/posts/post_bloc.dart';
import 'package:call_api/repository/api_client.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PostBloc(),
        ),
        BlocProvider(
          create: (_) => PhotosBloc(ApiClient(http.Client())),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        home: const PhotosScreen(),
      ),
    );
  }
}
