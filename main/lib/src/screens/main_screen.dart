import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:main/src/screens/paths.dart';
import 'package:ui_utils/ui_utils.dart';

part 'bottom_nav_bar.dart';
part 'bottom_nav_bar_button.dart';

class MainPage extends StatefulWidget {
  final List<Widget> pages;

  const MainPage({
    super.key,
    required this.pages,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: widget.pages,
      ),
      bottomNavigationBar: _MainScreenBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
