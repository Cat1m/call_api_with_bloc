import 'package:call_api/bloc/posts/post_bloc.dart';
import 'package:call_api/bloc/posts/post_event.dart';
import 'package:call_api/bloc/posts/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add((PostFetched()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts APIs'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.initial:
              return const Center(child: CircularProgressIndicator());
            case PostStatus.failure:
              return Text(state.message.toString());
            case PostStatus.success:
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final item = state.posts[index];
                  return ListTile(
                    title: Column(
                      children: [
                        Text(item.userId.toString()),
                        Text(item.title.toString()),
                      ],
                    ),
                    subtitle: Text(item.body.toString()),
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
