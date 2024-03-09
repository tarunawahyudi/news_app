import 'package:flutter/material.dart';
import 'package:news_app/detail_page.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/common/style.dart';
import 'package:news_app/widgets/custom_scaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: primaryColor,
          onPrimary: Colors.black,
          secondary: secondaryColor,
        ),
        textTheme: myTextTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              )
            )
          )
        )
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName : (context) => const HomePage(),
        ArticleDetailPage.routeName : (context) => ArticleDetailPage(
          article: ModalRoute.of(context)?.settings.arguments as Article,
        ),
        ArticleWebView.routeName : (context) => ArticleWebView(
          url: ModalRoute.of(context)?.settings.arguments as String,
        ),
      },
    );
  }
}

class ArticleWebView extends StatelessWidget {
  static const routeName = '/article_web';

  final String url;
  const ArticleWebView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()..loadRequest(Uri.parse(url));
    return CustomScaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }

}