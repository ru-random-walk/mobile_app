import 'package:chats/chats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:main/src/screens/main/paths.dart';
import 'package:matcher_service/matcher_service.dart';
import 'package:ui_utils/ui_utils.dart';

part 'bottom_nav_bar.dart';
part 'bottom_nav_bar_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final pages = [
    const MatcherPage(),
    const Center(
      child: Text('2'),
    ),
    const ChatsListPage(),
    const Center(
      child: Text('4'),
    ),
  ];

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        child: Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: pages,
          ),
          bottomNavigationBar: _MainScreenBottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
