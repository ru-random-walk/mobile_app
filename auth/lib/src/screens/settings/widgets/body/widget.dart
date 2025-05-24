part of '../../page.dart';

class _UserSettingsBodyWidget extends StatelessWidget {
  final DetailedUserEntity profile;

  const _UserSettingsBodyWidget({required this.profile});

  @override
  Widget build(BuildContext context) {
    final divider = SizedBox(
      height: 2.toFigmaSize,
      width: double.infinity,
      child: ColoredBox(color: context.colors.base_5),
    );
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SettingsLogoutSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => const AuthPage(),
            ),
            (_) => false,
          );
        } else if (state is SettingsLogoutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Что-то пошло не так'),
            ),
          );
        }
      },
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Builder(builder: (context) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    20.toFigmaSize,
                    8.toFigmaSize,
                    20.toFigmaSize,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 8.toFigmaSize,
                    children: [
                      _UserAvatarAndNameWidget(profile),
                      _UserAdditionalInfoWidget(profile),
                      divider,
                      const _HelpWidget(),
                      divider,
                    ],
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.toFigmaSize),
            child: TextButton(
              style: ButtonStyle(
                overlayColor: WidgetStatePropertyAll(context.colors.main_5),
              ),
              onPressed: () {
                final settingsBloc = context.read<SettingsBloc>();
                settingsBloc.add(SettingsLogoutEvent());
              },
              child: Text(
                'Выйти из аккаунта',
                style: context.textTheme.bodyMRegularBase0.copyWith(
                  color: const Color(0xFFFF281A),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
