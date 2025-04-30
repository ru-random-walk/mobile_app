import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:clubs/src/domain/entities/club/create_and_edit/club/input_field_group.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/club/button_create_group.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/tests/create_test_page.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/app_bar.dart'; 
import 'package:clubs/src/data/create_club_service.dart';

part 'club/popup.dart';
part 'club/condition_string.dart';

class GroupFormScreen extends StatefulWidget {
  const GroupFormScreen({super.key});

  @override
  State<GroupFormScreen> createState() => _GroupFormScreenState();
}

class _GroupFormScreenState extends State<GroupFormScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? attempts;
  bool isConditionAdded = false;
  int infoCount = 1; 
  String conditionName = "";
  final ClubApiService clubApiService = ClubApiService();


  void onConditionAdded(String condition, int count, String name) {
  setState(() {
    attempts = condition;
    infoCount = count;
    isConditionAdded = true;
    conditionName = name;
  });
  }

  void removeCondition() {
    setState(() {
      isConditionAdded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        child: Scaffold(
          appBar: const CreateAndEditPageAppBar(),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 20.toFigmaSize,
              vertical: 8.toFigmaSize,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.toFigmaSize),
                    child: SizedBox(
                      width: 120.toFigmaSize,
                      height: 120.toFigmaSize,
                      child: Image.asset(
                        'packages/clubs/assets/images/avatar.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.toFigmaSize),
                // Button
                SizedBox(height: 12.toFigmaSize),
                Text('Название группы', style: context.textTheme.bodyXLMedium),
                SizedBox(height: 8.toFigmaSize),
                TextFieldGroup(
                  num: 1,
                  controller: nameController,
                  title: 'Название',
                ),
                SizedBox(height: 20.toFigmaSize),

                Text('Описание', style: context.textTheme.bodyXLMedium),
                SizedBox(height: 8.toFigmaSize),
                TextFieldGroup(
                  num: 3,
                  controller: descriptionController,
                  title: 'Описание',
                ),

                SizedBox(height: 20.toFigmaSize),

                Text('Условия для вступления', style: context.textTheme.bodyXLMedium),
                SizedBox(height: 8.toFigmaSize),

                if (!isConditionAdded)
                  CreateGroupButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return _AddTestDialog(
                            onConditionAdded: onConditionAdded,
                            infoCount: infoCount,
                            conditionName: conditionName,
                          );
                        },
                      ).then((result) {
                        if (result != null) {
                          String testName = result['testName'];
                          int questionCount = result['questionCount'];

                          setState(() {
                            conditionName = testName; 
                            isConditionAdded = true; 
                            infoCount = questionCount; 
                          });
                        }
                      });
                    },
                  ),
                if (isConditionAdded)
                  ConditionString(
                    infoCount: infoCount,
                    isConditionAdded: isConditionAdded,
                    onTap: removeCondition,
                    conditionTitle: conditionName,
                  ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.toFigmaSize, vertical: 4.toFigmaSize),
            child: SizedBox(
              width: double.infinity,
              child: CustomButton(
                size: ButtonSize.M,
                type: ButtonType.primary,
                color: ButtonColor.green,
                text: 'Готово',
                onPressed: () async {
                  final name = nameController.text.trim();
                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Введите название группы')));
                    return;
                  }

                  final result = await clubApiService.createClub(name);

                  if (result != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Группа создана: ${result['name']}')));
                    Navigator.pop(context); 
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Не удалось создать группу')));
                  }
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
}

