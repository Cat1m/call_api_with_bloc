import 'package:call_api/bloc/photos/photos_bloc.dart';
import 'package:call_api/bloc/photos/photos_state.dart';
import 'package:call_api/bloc/posts/post_bloc.dart';
import 'package:call_api/bloc/posts/post_event.dart';
import 'package:call_api/bloc/posts/post_state.dart';
import 'package:call_api/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({Key? key}) : super(key: key);

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PhotosBloc>().add((PhotosFetched()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts APIs'),
      ),
      body: BlocBuilder<PhotosBloc, PhotosState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.initial:
              return const Center(child: CircularProgressIndicator());
            case Status.failure:
              return Text(state.message.toString());
            case Status.success:
              return ListView.builder(
                itemCount: state.photos.length,
                itemBuilder: (context, index) {
                  final item = state.photos[index];
                  return ListTile(
                    title: Column(
                      children: [
                        Text(item.albumId.toString()),
                        Text(item.title!),
                      ],
                    ),
                    // subtitle: Image.network(
                    //   item.thumbnailUrl!,
                    //   //height: 400,
                    //   width: double.infinity,
                    // ),
                  );
                },
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
