import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth/auth.dart';

import 'package:clubs/src/domain/entities/club/create_and_edit/club/input_field_group.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/club/button_create_group.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/tests/create_test_page.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/app_bar.dart'; 
import 'package:clubs/src/data/clubs_api_service.dart';

import 'package:clubs/src/data/remove_clubs/club_utils.dart';

part 'club/popup.dart';
part 'club/condition_string.dart';
part 'club/body.dart';
part 'get_id_user.dart';

class ClubFormScreen extends StatefulWidget {
  const ClubFormScreen({super.key});

  @override
  State<ClubFormScreen> createState() => _ClubFormScreenState();
}

class _ClubFormScreenState extends State<ClubFormScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? attempts;
  bool isConditionAdded = false;
  int infoCount = 1; 
  String conditionName = "";
  final ClubApiService clubApiService = ClubApiService();
  List<Map<String, dynamic>>? questions;

  void onConditionAdded(String condition, int count, String name, List<Map<String, dynamic>>? questionInputs) {
  setState(() {
    attempts = condition;
    infoCount = count;
    isConditionAdded = true;
    conditionName = name;
    if (questionInputs != null) {
      questions = questionInputs;
    }
  });
  }

  void removeCondition() {
    setState(() {
      isConditionAdded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return UserIdProvider(
    builder: (context, userId) {
      
      return ColoredBox(
        color: context.colors.base_0,
        child: SafeArea(
          child: Scaffold(
            appBar: const CreateAndEditPageAppBar(),
            body: GroupFormBody(
              nameController: nameController,
              descriptionController: descriptionController,
              isConditionAdded: isConditionAdded,
              conditionName: conditionName,
              infoCount: infoCount,
              onConditionAdded: onConditionAdded,
              removeCondition: removeCondition,
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
                    final description = descriptionController.text.trim();
                    if (name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Введите название группы')));
                      return;
                    }

                    Map<String, dynamic>? result;      
                    //await deleteAllUserClubs(userId: userId, apiService: ClubApiService());

                    if (!isConditionAdded) {
                      result = await createClub(
                        name: name, 
                        description: description.isEmpty ? null : description,
                        apiService: ClubApiService());
                    } else if (conditionName == "Запрос на вступление") {
                      result = await createClubWithConfirmApprovement(
                        name: name,
                        description: description.isEmpty ? null : description,
                        infoCount: infoCount,
                        apiService: ClubApiService(),
                      );
                    } else {
                      result = await createClubWithFormApprovement(
                        name: name,
                        description: description.isEmpty ? null : description,
                        questions: questions ?? [],
                        apiService: ClubApiService(),
                      );
                    }

                    if (result != null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Группа создана')));
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
    },);
  }
}

