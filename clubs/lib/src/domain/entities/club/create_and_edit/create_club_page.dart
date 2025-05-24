import 'dart:typed_data';

import 'package:clubs/src/data/db/data_source/club_photo.dart';
import 'package:clubs/src/data/image/repository/cache.dart';
import 'package:clubs/src/data/image/repository/sender.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth/auth.dart';
import 'package:collection/collection.dart';

import 'package:clubs/src/domain/entities/club/create_and_edit/club/input_field_group.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/club/button_create_group.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/tests/create_test_page.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/app_bar.dart';
import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:clubs/src/domain/entities/club/text_format/question_format.dart';
import 'package:clubs/src/domain/entities/club/text_format/inspector_format.dart';
import 'package:clubs/utils/qraphql_error_utils.dart';

part 'club/popup.dart';
part 'club/condition_string.dart';
part 'club/body.dart';
part 'get_id_user.dart';
part 'approvement_updater.dart';

class ClubFormScreen extends StatefulWidget {
  final String? initialName;
  final String? initialDescription;
  final bool initialIsConditionAdded;
  final String? initialConditionName;
  final int initialInfoCount;
  final List<Map<String, dynamic>>? initialQuestions;
  final int inspectorAndAdminCount;
  final bool isEditMode;
  final String? clubId;
  final String? approvementId;

  const ClubFormScreen({
    super.key,
    this.initialName,
    this.initialDescription,
    this.initialIsConditionAdded = false,
    this.initialConditionName,
    this.initialInfoCount = 1,
    this.initialQuestions,
    this.inspectorAndAdminCount = 1,
    this.isEditMode = false,
    this.clubId,
    this.approvementId,
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
  Uint8List? imageBytes;
  List<Map<String, dynamic>>? questions;
  final ClubApiService clubApiService = ClubApiService();
  final _imagePicker = ImagePickerRepository();
  late final SetPhotoForObjectWithId _imageSetter;

  @override
  void initState() {
    super.initState();
    _imageSetter = SetPhotoForObjectWithId(
      sender: RemoteImageClubRepostory(),
      dbInfo: ClubPhotoDatabaseInfoDataSource(
        context.read(),
      ),
      cache: CacheClubImageRepository(),
    );
    nameController = TextEditingController(text: widget.initialName ?? '');
    descriptionController =
        TextEditingController(text: widget.initialDescription ?? '');
    isConditionAdded = widget.initialIsConditionAdded;
    conditionName = widget.initialConditionName ?? '';
    infoCount = widget.initialInfoCount;
    questions = widget.initialQuestions;
  }

  void onConditionAdded(
      String name, int count, List<Map<String, dynamic>>? questionInputs) {
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

  Future<void> _pickImage() async {
    final res = await _imagePicker.getImage();
    res.fold((err) {
      String errorMessage;
      if (err is ImageNotPickedError) {
        return;
      }
      if (err is TooBigImageError) {
        errorMessage = 'Размер файла не должен превышать 5МБ';
      } else {
        errorMessage = 'Что-то пошло не так';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }, (imageBytes) {
      setState(() {
        this.imageBytes = imageBytes;
      });
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
            questions: questions,
            inspectorAndAdminCount: widget.inspectorAndAdminCount,
            onConditionAdded: onConditionAdded,
            removeCondition: removeCondition,
            isEditMode: widget.isEditMode,
            onChooseImage: _pickImage,
            imageBytes: imageBytes,
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 20.toFigmaSize, vertical: 4.toFigmaSize),
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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Введите название группы')));
                      return;
                    }
                    if (imageBytes == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Добавьте фото группы')));
                      return;
                    }

                    try {
                      Map<String, dynamic>? result;
                      String? clubId;

                      if (widget.isEditMode && widget.clubId != null) {
                        await ApprovementUpdater.handleConditionUpdate(
                          context: context,
                          apiService: clubApiService,
                          clubId: widget.clubId!,
                          initialIsConditionAdded:
                              widget.initialIsConditionAdded,
                          isConditionAdded: isConditionAdded,
                          initialConditionName: widget.initialConditionName,
                          conditionName: conditionName,
                          initialInfoCount: widget.initialInfoCount,
                          infoCount: infoCount,
                          initialQuestions: widget.initialQuestions,
                          questions: questions,
                          approvementId: widget.approvementId,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: context.colors.main_50,
                            content: Text('Группа обновлена',
                                style: context.textTheme.bodySMediumBase0),
                          ),
                        );
                      } else {
                        if (!isConditionAdded) {
                          result = await createClub(
                              name: name,
                              description:
                                  description.isEmpty ? null : description,
                              apiService: ClubApiService());
                          clubId = result?['data']?['createClub']?['id'];
                        } else if (conditionName == "Запрос на вступление") {
                          result = await createClubWithConfirmApprovement(
                            name: name,
                            description:
                                description.isEmpty ? null : description,
                            infoCount: infoCount,
                            apiService: ClubApiService(),
                          );
                          clubId = result?['data']
                              ?['createClubWithConfirmApprovement']?['id'];
                        } else {
                          result = await createClubWithFormApprovement(
                            name: name,
                            description:
                                description.isEmpty ? null : description,
                            questions: questions ?? [],
                            apiService: ClubApiService(),
                          );
                          clubId = result?['data']
                              ?['createClubWithFormApprovement']?['id'];
                        }

                        if (handleGraphQLErrors(context, result,
                            fallbackMessage: 'Не удалось создать группу')) {
                          return;
                        }
                        if (imageBytes != null) {
                          try {
                            await _imageSetter(
                              SetObjectPhotoArgs(
                                imageBytes: imageBytes!,
                                objectId: clubId!,
                              ),
                            );
                          } catch (e) {
                            if (context.mounted) {
                              showErrorSnackbar(
                                context,
                                'Произошла ошибка при загрузке фото',
                              );
                            }
                          }
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: context.colors.main_50,
                            content: Text('Группа создана',
                                style: context.textTheme.bodySMediumBase0),
                          ),
                        );
                      }
                      Navigator.pop(context, true);
                    } catch (e) {
                      print(e);
                      showErrorSnackbar(context, 'Произошла ошибка');
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
