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
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        switch (state) {
          case Authenticated _:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const MainPage(),
              ),
            );
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
    );
  }
}
