part of '../../page.dart';

class _HelpWidget extends StatelessWidget {
  const _HelpWidget();

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
              'Помощь',
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
                    'Email для связи',
                    style: context.textTheme.bodyLRegular.copyWith(
                      color: context.colors.base_70,
                    ),
                  ),
                  SizedBox(height: 4.toFigmaSize),
                  Flexible(
                    child: Text(
                      'randomwalk@gmail.com',
                      style: context.textTheme.bodyXLRegular.copyWith(
                        color: context.colors.base_90,
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
