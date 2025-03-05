part of 'page.dart';

class _SplashScreen extends StatefulWidget {
  @override
  State<_SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<_SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SplashCubit>().checkAuth();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        switch (state) {
          case ProfileLoading():
          case ProfileData():
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const MainPage(),
              ),
            );
          case ProfileError():
          // TODO: Handle this case.
        }
      },
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          switch (state) {
            case Authenticated _:
              profileBloc.add(ProfileLoadEvent());
            case Unauthenticated():
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => const AuthPage(),
                ),
              );
            default:
          }
        },
        child: Scaffold(
          backgroundColor: context.colors.base_0,
          body: Center(
            child: AppLogo(),
          ),
        ),
      ),
    );
  }
}
