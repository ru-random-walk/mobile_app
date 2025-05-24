part of '../../page.dart';

class _UserAdditionalInfoWidget extends StatelessWidget {
  final DetailedUserEntity profile;

  const _UserAdditionalInfoWidget(this.profile);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.toFigmaSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 12.toFigmaSize,
          children: [
            Text(
              'Аккаунт',
              style: context.textTheme.bodyLMedium.copyWith(
                color: context.colors.main_70,
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Почта',
                    style: context.textTheme.bodyLRegular.copyWith(
                      color: context.colors.base_70,
                    ),
                  ),
                  SizedBox(height: 4.toFigmaSize),
                  Flexible(
                    child: Text(
                      profile.email,
                      style: context.textTheme.bodyXLRegular.copyWith(
                        color: context.colors.base_90,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'О себе',
                    style: context.textTheme.bodyLRegular.copyWith(
                      color: context.colors.base_70,
                    ),
                  ),
                  SizedBox(height: 4.toFigmaSize),
                  Flexible(
                    child: Text(
                      profile.description ?? 'Пусто',
                      style: context.textTheme.bodyXLRegular.copyWith(
                        color: profile.description == null
                            ? context.colors.base_20
                            : context.colors.base_90,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
