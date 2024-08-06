import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BlogService {
  final String url = dotenv.env['API_URL'] ?? 'default_value';
  final String adminSecret = dotenv.env['API_KEY'] ?? 'default_value';

  Future<List<Blog>> fetchBlogs() async {
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> blogsJson = data['blogs'];
        print(data[0]);
        return blogsJson.map((json) => Blog.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load blogs');
      }
    } catch (e) {
      throw Exception('Error fetching blogs: $e');
    }
  }
}

class Blog {
  final String id; // Unique identifier for each blog
  final String title;
  final String imageUrl;
  // Add other fields as needed

  Blog({
    required this.id,
    required this.title,
    required this.imageUrl,
    // Initialize other fields
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image_url'],
    );
  }
}
