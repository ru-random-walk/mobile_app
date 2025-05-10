part of 'create_club_page.dart';

class UserIdProvider extends StatelessWidget {
  final Widget Function(BuildContext context, String userId) builder;

  const UserIdProvider({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return switch (state) {
          ProfileLoading() => const Center(child: CircularProgressIndicator()),
          ProfileData() => builder(context, state.user.id),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
