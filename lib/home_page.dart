import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/article_list_page.dart';
import 'package:news_app/platform_widget.dart';
import 'package:news_app/common/style.dart';
import 'package:news_app/ui/settings_page.dart';

class HomePage extends StatefulWidget {

  static const routeName = '/home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _bottomNavIndex == 0 ? ArticleListPage() : SettingsPage(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Headline',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          )
        ],
        onTap: (selected) {
          setState(() {
            _bottomNavIndex = selected;
          });
        },
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: secondaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Headline',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          )
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 1:
            return const SettingsPage();
          default:
            return const ArticleListPage();
        }
      },
    );
  }
}