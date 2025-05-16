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
import 'package:clubs/src/domain/entities/club/text_format/question_format.dart';
import 'package:clubs/src/domain/entities/club/text_format/inspector_format.dart';

part 'club/popup.dart';
part 'club/condition_string.dart';
part 'club/body.dart';
part 'get_id_user.dart';

class ClubFormScreen extends StatefulWidget {
  final String? initialName;
  final String? initialDescription;
  final bool initialIsConditionAdded;
  final String? initialConditionName;
  final int initialInfoCount;
  final List<Map<String, dynamic>>? initialQuestions;

  const ClubFormScreen({
    super.key,
    this.initialName,
    this.initialDescription,
    this.initialIsConditionAdded = false,
    this.initialConditionName,
    this.initialInfoCount = 1,
    this.initialQuestions,
  });

  @override
  State<ClubFormScreen> createState() => _ClubFormScreenState();
}

class _ClubFormScreenState extends State<ClubFormScreen> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late bool isConditionAdded;
  late String conditionName;
  late int infoCount;
  List<Map<String, dynamic>>? questions;
  final ClubApiService clubApiService = ClubApiService();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialName ?? '');
    descriptionController = TextEditingController(text: widget.initialDescription ?? '');
    isConditionAdded = widget.initialIsConditionAdded;
    conditionName = widget.initialConditionName ?? '';
    infoCount = widget.initialInfoCount;
    questions = widget.initialQuestions;
  }

  void onConditionAdded(String name, int count, List<Map<String, dynamic>>? questionInputs) {
  setState(() {
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
    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        child: Scaffold(
          appBar: const CreateAndEditPageAppBar(),
          body: ClubFormBody(
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
                    final data = result['data'];
                    final errors = result['errors'];

                    if (data != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: context.colors.main_50,
                          content: Text('Группа создана', style: context.textTheme.bodySMediumBase0),
                        ),
                      );
                      Navigator.pop(context, true);
                    } else {
                      String errorMessage = 'Не удалось создать группу';

                      if (errors != null) {
                        if (errors.any((e) =>
                            e.toString().contains('maximum count of clubs') ||
                            e.toString().contains('You are reached maximum count of clubs'))) {
                          errorMessage = 'Вы не можете создать больше 3 групп';
                        }
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Произошла ошибка при отправке запроса')),
                    );
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

