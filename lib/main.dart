import 'package:app_dashboard_news/firebase_options.dart';
import 'package:app_dashboard_news/pages/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'provider/article_provider.dart';
import 'provider/category_provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // name: 'demoapp',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ArticleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
