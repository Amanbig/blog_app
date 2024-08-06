import 'package:flutter/material.dart';
import 'package:blog_app/screens/main_screen.dart';
import 'package:blog_app/services/blog_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: RepositoryProvider(
        create: (context) => BlogService(),
        child: MainScreen(),
      ),
    );
  }
}
