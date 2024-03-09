import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'model/article.dart';

class NewsListPage extends StatelessWidget {

  static const routeName = '/article_list';
  const NewsListPage({super.key});

  @override
  title: const Text('News App'),
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString('assets/articles.json'),
        builder: (context, snapshot) {
          final List<Article> articles = parseArticles(snapshot.data);
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return _buildArticleItem(context, articles[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildArticleItem(BuildContext context, Article article) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
        article.urlToImage,
        width: 100,
        errorBuilder: (ctx, error, _) => const Center(child: Icon(Icons.error)),
      ),
      title: Text(article.title),
      subtitle: Text(article.author),
      onTap: () {
        Navigator.pushNamed(context, ArticleDetailPage.routeName, arguments: article);
      },
    );
  }
}