import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_api_colling/state/all_post_states.dart';

import 'models/post.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: Center(child: Consumer(builder: (_, ref, __) {
        AllPostStates state = ref.watch(postsProvider);
        if (state is InnitialStateOfAllPostStates) {
          return const Text("Press FAB to Fetch PostsData");
        }
        if (state is LoadingStateOfAllPostStates) {
          return const CircularProgressIndicator();
        }
        if (state is ErrorStateOfAllPostStates) {
          return Text(state.message);
        }
        if (state is LoadedStateOfAllPostStates) {
          return _buildListView(state);
        }
        return const Text("Data not found");
      })),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          ref.read(postsProvider.notifier).fetchAllPosts();
        },
      ),
    );
  }

  Widget _buildListView(LoadedStateOfAllPostStates state) {
    return ListView.builder(
        itemCount: state.posts.length,
        itemBuilder: (_, index) {
          Post post = state.posts[index];
          return Card(
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(child: Text(post.id.toString())),
              title: Text(post.title.toUpperCase()),
              trailing: Text(post.userId.toString()),
            ),
          );
        });
  }
}
