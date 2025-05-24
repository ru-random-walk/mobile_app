part of '../page.dart';

class _EditUserInfoBodyWidget extends StatefulWidget {
  final DetailedUserEntity profile;

  const _EditUserInfoBodyWidget(this.profile);

  @override
  State<_EditUserInfoBodyWidget> createState() =>
      _EditUserInfoBodyWidgetState();
}

class _EditUserInfoBodyWidgetState extends State<_EditUserInfoBodyWidget> {
  final nameEditingController = TextEditingController();
  final aboutEditingController = TextEditingController();
  Uint8List? newImage;
  final _canPressButton = ValueNotifier<bool>(false);

  bool get isNameChanged =>
      nameEditingController.text != widget.profile.fullName;

  bool get isAboutChanged =>
      aboutEditingController.text != (widget.profile.description ?? '');

  void _validateCanPressButton() {
    final isNewImageSetted = newImage != null;
    _canPressButton.value =
        (isNameChanged || isAboutChanged || isNewImageSetted) &&
            nameEditingController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    nameEditingController.text = widget.profile.fullName;
    aboutEditingController.text = widget.profile.description ?? '';
    nameEditingController.addListener(_validateCanPressButton);
    aboutEditingController.addListener(_validateCanPressButton);
  }

  void setNewImage(Uint8List image) {
    newImage = image;
    _validateCanPressButton();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserSettingsBloc, UserSettingsState>(
      listener: (context, state) {
        if (state is UserSettingsUpdateResult) {
          if (state.success) {
            Navigator.of(context).pop();
          } else {
            if (state.updatingAvatarError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Не удалось обновить аватар',
                  ),
                ),
              );
            }
            if (state.updatingInfoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Не удалось обновить данные профиля',
                  ),
                ),
              );
            }
          }
        }
      },
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.toFigmaSize),
                child: Column(
                  spacing: 16.toFigmaSize,
                  children: [
                    _EditableBlockWidget(
                      title: 'Имя',
                      controller: nameEditingController,
                      maxLines: 1,
                    ),
                    _EditableBlockWidget(
                      title: 'О себе',
                      controller: aboutEditingController,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.toFigmaSize),
            child: ValueListenableBuilder(
              valueListenable: _canPressButton,
              builder: (context, value, child) => CustomButton(
                text: 'Готово',
                disabled: !value,
                onPressed: () {
                  final bloc = context.read<UserSettingsBloc>();
                  final isUserInfoChanged = isNameChanged || isAboutChanged;
                  final aboutMe = aboutEditingController.text;
                  final updateInfo = isUserInfoChanged
                      ? UpdateUserInfoEntity(
                          fullName: nameEditingController.text,
                          aboutMe: aboutMe.isEmpty ? null : aboutMe,
                        )
                      : null;
                  final localNewImage = newImage;
                  final updateImage = localNewImage != null
                      ? SetObjectPhotoArgs(
                          imageBytes: localNewImage,
                          objectId: widget.profile.id,
                        )
                      : null;
                  if (updateInfo == null && updateImage == null) return;
                  bloc.add(
                    UpdateUserSettings(
                      updateInfo: updateInfo,
                      photo: updateImage,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameEditingController.removeListener(_validateCanPressButton);
    aboutEditingController.removeListener(_validateCanPressButton);
    nameEditingController.dispose();
    aboutEditingController.dispose();
  }
}
