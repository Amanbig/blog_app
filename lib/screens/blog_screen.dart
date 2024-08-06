import 'package:blog_app/blocs/blog_bloc.dart';
import 'package:blog_app/screens/error_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_app/components/blogs.dart';
import 'package:blog_app/components/search_bar.dart';

class BlogListScreen extends StatefulWidget {
  @override
  _BlogListScreenState createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    // Trigger initial fetch of blogs
    context.read<BlogBloc>().add(FetchBlogs());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Blog Explorer',
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
            return RefreshIndicator(
              onRefresh: () async {
                context.read<BlogBloc>().add(FetchBlogs());
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CustomSearchBar(
                      controller: _searchController,
                      onChanged: (query) {
                        context.read<BlogBloc>().add(SearchQueryChanged(query));
                      },
                    ),
                  ),
                  Expanded(
                    child: state.blogs.isEmpty
                        ? Center(child: Text('No blogs available', style: TextStyle(color: Colors.white)))
                        : ListView.builder(
                      itemCount: state.blogs.length,
                      itemBuilder: (context, index) {
                        final blog = state.blogs[index];
                        return Blogs(blog: blog);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is BlogError) {
            return EmptyStateScreen(
              message: 'Failed to load blogs: ${state.message}',
              onRetry: () {
                context.read<BlogBloc>().add(FetchBlogs());
              },
            );
          }
          return Center(child: Text('Unexpected state'));
        },
      ),
    );
  }
}
