import 'package:clubs/src/domain/entities/club/group_list/widgets/widget_group.dart';
import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

import 'package:clubs/src/domain/entities/club/group_list/widgets/filters_group/filters_button.dart';
import 'package:clubs/src/domain/entities/club/group_list/widgets/add_button.dart';

part 'group_list/widgets/app_bar/app_bar.dart';
part 'group_list/widgets/app_bar/search_paint.dart';
part 'group_list/widgets/app_bar/search_button.dart';
part 'group_list/widgets/filters_group/group_filters.dart';
part 'group_list/widgets/body_data.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final List<Map<String, String>> groups = [
    {"title": "Прогульщики", "subtitle": "0 участников", "image": "👯‍♂️"},
    {"title": "Магия Миядзаки", "subtitle": "76 участников", "image": "🧙‍♂️"},
    {"title": "Театралы", "subtitle": "5 участников", "image": "🎭"},
    {"title": "Смекругляшки", "subtitle": "100 участников", "image": "🐻"},
    {"title": "Собрание Каге", "subtitle": "5 участников", "image": "🌀"},
    {"title": "Книгоман", "subtitle": "42 участника", "image": "📚"},
    {"title": "Звездочеты", "subtitle": "88 участника", "image": "🌟"},
    {"title": "Художники", "subtitle": "13 участников", "image": "🎭"},
    {"title": "Смекругляшки", "subtitle": "100 участников", "image": "🐻"},
    {"title": "Смекругляшки", "subtitle": "100 участников", "image": "🐻"},
  ];

  int _selectedFilterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _GroupListAppBar(),
      body: Column(
        children: [
          SizedBox(height: 8.toFigmaSize),
          
           GroupFilters(
            selectedIndex: _selectedFilterIndex,
            onFilterChanged: (index) {
              setState(() {
                _selectedFilterIndex = index;
              });
            },
          ),

          SizedBox(height: 8.toFigmaSize),
          GroupListBodyData(groups: groups),
          SizedBox(height: 8.toFigmaSize),
        ],
      ),
      floatingActionButton: AddGroupButton(
        onPressed: () {
          // Логика для добавления новой группы
        },
      ),
    );
  }
}
