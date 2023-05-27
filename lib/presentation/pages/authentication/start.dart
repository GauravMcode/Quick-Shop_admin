import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool _startText = false;
  int? _index = 0;
  bool isLast = false;
  bool _oneIteration = false;
  int duration = 1000;
  List<Color> colors = [const Color(0xffffa502), const Color(0xff2f3542)];
  List<Color> gradColors = [const Color(0xffced6e0), const Color(0xff2f3542)];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: [
              LinearGradient(colors: gradColors.reversed.toList(), begin: Alignment.topLeft, end: Alignment.bottomCenter, stops: const [0.2, 0.99]),
              LinearGradient(colors: gradColors.reversed.toList(), begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: const [0.2, 0.99]),
              LinearGradient(colors: gradColors.reversed.toList(), begin: Alignment.topRight, end: Alignment.bottomCenter, stops: const [0.2, 0.99]),
            ][_index ?? 2]),
            child: Column(
              children: [
                !_startText
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Join the \nCommunity of sellers & \n get',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                !_startText
                    ? const SizedBox.shrink()
                    : SizedBox(
                        width: size.width * 0.4,
                        height: size.height * 0.2,
                        child: IndexedStack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.antiAlias,
                          index: _index ?? 2,
                          children: [
                            AnimatedOpacity(
                              opacity: _index == 0 ? 1.0 : 0,
                              duration: Duration(milliseconds: duration),
                              child: Lottie.asset(
                                'assets/97517-phone-payments-seth.json',
                                width: 200,
                                height: 200,
                                fit: BoxFit.fill,
                              ),
                            ),
                            AnimatedOpacity(
                              opacity: _index == 1 ? 1.0 : 0,
                              duration: Duration(milliseconds: duration),
                              child: Lottie.asset(
                                'assets/50399-dashboard.json',
                                width: 200,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                            AnimatedOpacity(
                              opacity: _index == 2 && !isLast ? 1.0 : 0,
                              duration: Duration(milliseconds: duration),
                              child: Lottie.asset(
                                'assets/35193-delivery.json',
                                width: 200,
                                height: 200,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedTextKit(
                    onNext: (p0, p1) {
                      setState(() {
                        _startText = true;
                        _index = p1 ? 2 : p0;
                        p1 ? isLast = true : isLast = false;
                        if (_oneIteration == false && p1) {
                          _oneIteration = true;
                        }
                      });
                    },
                    animatedTexts: [
                      _startText
                          ? TyperAnimatedText(' \n', speed: Duration.zero)
                          : TyperAnimatedText(
                              'Join the \nCommunity of sellers & \n get',
                              textStyle: Theme.of(context).textTheme.labelLarge,
                              speed: const Duration(milliseconds: 60),
                            ),
                      ColorizeAnimatedText(
                        'Instant Payments',
                        textStyle: Theme.of(context).textTheme.titleLarge!,
                        speed: const Duration(milliseconds: 110),
                        colors: gradColors.reversed.toList(),
                      ),
                      ColorizeAnimatedText(
                        'Admin Dashboard',
                        textStyle: Theme.of(context).textTheme.titleLarge!,
                        speed: const Duration(milliseconds: 110),
                        colors: gradColors.reversed.toList(),
                      ),
                      ColorizeAnimatedText(
                        'Quick Delievery',
                        textStyle: Theme.of(context).textTheme.titleLarge!,
                        speed: const Duration(milliseconds: 110),
                        colors: gradColors.reversed.toList(),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    repeatForever: true,
                    pause: _startText ? Duration(milliseconds: duration) : const Duration(milliseconds: 0),
                  ),
                ),
                const Spacer(),
                AnimatedOpacity(
                  opacity: _oneIteration ? 1 : 0,
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeIn,
                  child: AuthButtons(size: size),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthButtons extends StatelessWidget {
  const AuthButtons({super.key, required this.size});
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Already a Member?', style: TextStyle(color: Theme.of(context).primaryColorDark.withOpacity(0.8), fontSize: 15)),
        SizedBox(width: size.width - 100, child: ElevatedButton(onPressed: () => Navigator.of(context).pushNamed('/sign-in'), child: const Text('Log-in'))),
        const SizedBox(height: 50),
        Text('New here? then why to wait!', style: TextStyle(color: Theme.of(context).primaryColorDark.withOpacity(0.8), fontSize: 15)),
        SizedBox(width: size.width - 100, child: ElevatedButton(onPressed: () => Navigator.of(context).pushNamed('/sign-up'), child: const Text('Create an Account'))),
        const SizedBox(height: 10)
      ],
    );
  }
}
