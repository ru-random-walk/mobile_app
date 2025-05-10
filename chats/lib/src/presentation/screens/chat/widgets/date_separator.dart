part of '../page.dart';

class _ChatDateSeparatorWidget extends StatelessWidget {
  final DateTime date;

  const _ChatDateSeparatorWidget({
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43.toFigmaSize,
      child: Align(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            16.toFigmaSize,
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 4.toFigmaSize,
              sigmaY: 4.toFigmaSize,
            ),
            child: ColoredBox(
              color: const Color.fromARGB(145, 234, 234, 234),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.toFigmaSize,
                  vertical: 4.toFigmaSize,
                ),
                child: Text(
                  _getDate(date),
                  style: context.textTheme.bodyMRegularBase70,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _getDate(DateTime date) {
  final now = DateTime.now();
  final differenceInDays = now.difference(date).inDays;
  final difference = now.day - date.day;
  if (difference == 0 && differenceInDays < 2) return 'Сегодня';
  if (difference == 1 && differenceInDays < 2) return 'Вчера';
  final isThisYear = date.year == now.year;
  final year = isThisYear ? '' : ' ,${date.year} г.';
  return DateFormat('dd MMMM', 'ru').format(date) + year;
}
