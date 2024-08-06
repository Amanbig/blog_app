import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:blog_app/services/blog_service.dart';

// States
abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<Blog> blogs;
  final List<Blog> favorites;

  BlogLoaded(this.blogs, {this.favorites = const []});

  @override
  List<Object> get props => [blogs, favorites];
}

class BlogError extends BlogState {
  final String message;

  BlogError(this.message);

  @override
  List<Object> get props => [message];
}

// Events
abstract class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

class FetchBlogs extends BlogEvent {}

class ToggleFavorite extends BlogEvent {
  final Blog blog;

  ToggleFavorite(this.blog);

  @override
  List<Object> get props => [blog];
}

class SearchQueryChanged extends BlogEvent {
  final String query;

  SearchQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

// Bloc
class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogService blogService;
  List<Blog> allBlogs = [];
  List<Blog> filteredBlogs = [];
  String searchQuery = '';

  BlogBloc(this.blogService) : super(BlogInitial()) {
    on<FetchBlogs>(_onFetchBlogs);
    on<ToggleFavorite>(_onToggleFavorite);
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

  Future<void> _onFetchBlogs(FetchBlogs event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    try {
      allBlogs = await blogService.fetchBlogs();
      _applySearchQuery(); // Filter blogs based on search query
      emit(BlogLoaded(filteredBlogs));
    } catch (e) {
      emit(BlogError('Failed to fetch blogs: ${e.toString()}'));
    }
  }

  void _onToggleFavorite(ToggleFavorite event, Emitter<BlogState> emit) {
    if (state is BlogLoaded) {
      final currentState = state as BlogLoaded;
      final favorites = List<Blog>.from(currentState.favorites);
      if (favorites.contains(event.blog)) {
        favorites.remove(event.blog);
      } else {
        favorites.add(event.blog);
      }
      emit(BlogLoaded(currentState.blogs, favorites: favorites));
    }
  }


  void _onSearchQueryChanged(SearchQueryChanged event, Emitter<BlogState> emit) {
    searchQuery = event.query;
    _applySearchQuery(); // Filter blogs based on search query
    if (state is BlogLoaded) {
      emit(BlogLoaded(filteredBlogs, favorites: (state as BlogLoaded).favorites));
    }
  }

  void _applySearchQuery() {
    filteredBlogs = allBlogs
        .where((blog) => blog.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }
}