import 'package:flutter/foundation.dart';
import 'package:riverpod_api_colling/models/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/http_get_service.dart';

final postsProvider =
    StateNotifierProvider<AllPostStatesNotifier, AllPostStates>(
        (ref) => AllPostStatesNotifier());

@immutable
abstract class AllPostStates {}

class InnitialStateOfAllPostStates extends AllPostStates {}

class LoadingStateOfAllPostStates extends AllPostStates {}

class LoadedStateOfAllPostStates extends AllPostStates {
  LoadedStateOfAllPostStates({required this.posts});
  final List<Post> posts;
}

class ErrorStateOfAllPostStates extends AllPostStates {
  ErrorStateOfAllPostStates({required this.message});
  final String message;
}

class AllPostStatesNotifier extends StateNotifier<AllPostStates> {
  AllPostStatesNotifier() : super(InnitialStateOfAllPostStates());
  final HttpGetService _httpGetService = HttpGetService();

  Future<void> fetchAllPosts() async {
    try {
      state = LoadingStateOfAllPostStates();
      List<Post> allPosts = await _httpGetService.getAllPosts();
      state = LoadedStateOfAllPostStates(posts: allPosts);
    } catch (e) {
      state = ErrorStateOfAllPostStates(message: e.toString());
    }
  }
}
