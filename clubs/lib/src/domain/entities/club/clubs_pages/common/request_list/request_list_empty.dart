part of 'request_list_screen.dart';

class RequestListEmpty extends StatelessWidget {

  const RequestListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.toFigmaSize,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, 
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Нет новых запросов',
              style: context.textTheme.h5.copyWith(
                color: context.colors.base_90),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.toFigmaSize),
            Text('Когда кто-то захочет вступить в группу, они появятся здесь',
              style: context.textTheme.bodyMItalic.copyWith(
                color: context.colors.base_50),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
