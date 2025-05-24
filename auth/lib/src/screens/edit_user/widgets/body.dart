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

  @override
  void initState() {
    super.initState();
    nameEditingController.text = widget.profile.fullName;
    aboutEditingController.text = widget.profile.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: CustomButton(
            text: 'Готово',
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
