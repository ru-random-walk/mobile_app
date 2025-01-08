part of '../page.dart';

class _PickedMapAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = context.textTheme.h5;
    return BlocBuilder<GeolocationBloc, GeolocationState>(
        builder: (context, state) {
      final text = switch (state) {
        GeolocationLoading _ => '...',
        GeolocationData _ => state.geolocation.toString(),
        GeolocationFailure _ => 'Ошибка',
      };
      return Align(
        alignment: Alignment.topCenter,
        child: Text(
          text,
          style: style,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      );
    });
  }
}
