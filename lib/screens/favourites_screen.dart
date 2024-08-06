import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_app/blocs/blog_bloc.dart';
import 'package:blog_app/components/blogs.dart';

class FavoriteBlogsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Favorites',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.white,
              fontFamily: 'Raleway',
            ),
          ),
        ),
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BlogLoaded) {
            final favorites = state.favorites;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<BlogBloc>().add(FetchBlogs());
              },
              child: favorites.isEmpty
                  ? Center(child: Text('No favorites yet', style: TextStyle(color: Colors.white)))
                  : ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final blog = favorites[index];
                  return Blogs(blog: blog);
                },
              ),
            );
          } else if (state is BlogError) {
            return Center(child: Text(state.message, style: TextStyle(color: Colors.red)));
          }
          return Center(child: Text('Unexpected state'));
        },
      ),
    );
  }
}
