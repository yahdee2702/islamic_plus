import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_plus/components/horizontal_expanded.dart';
import 'package:islamic_plus/themes/islamic_theme.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Top
          HorizontaExpanded(
            child: CustomPaint(
              painter: TopOvalPainter(
                curveHeight: 60.0,
                color: IslamicTheme.anotherBlack,
              ),
              child: SizedBox(
                height: 350,
                child: SafeArea(
                  child: Column(
                    children: const [
                      SizedBox(height: 52),
                      Text(
                        "Islamic+",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 27),
                      SizedBox(
                        width: 257,
                        child: Text(
                          "Everything a muslim needs in one application",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 75),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              MainScreenNavButton(
                name: "Al-Qur'an",
                asset: "assets/svgs/ic_quran.svg",
                destination: "/quran",
              ),
              MainScreenNavButton(
                name: "Do'a",
                asset: "assets/svgs/ic_dua.svg",
                destination: "/doa",
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MainScreenNavButton extends StatelessWidget {
  final String asset;
  final String name;
  final String destination;
  const MainScreenNavButton({
    Key? key,
    required this.name,
    required this.asset,
    required this.destination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, destination);
          },
          child: Card(
            color: IslamicTheme.anotherBlack,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  asset,
                  height: 63,
                  width: 63,
                  color: Colors.white,
                ),
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                IslamicTheme.defaultRadius,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

class TopOvalPainter extends CustomPainter {
  late final double _curveHeight;
  late final Color _color;
  TopOvalPainter({
    required double curveHeight,
    required Color color,
  }) {
    _curveHeight = curveHeight;
    _color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final p = Path();
    p.lineTo(0, size.height - _curveHeight);
    p.relativeQuadraticBezierTo(
        size.width / 2, 2 * _curveHeight, size.width, 0);
    p.lineTo(size.width, 0);
    p.close();

    canvas.drawPath(p, Paint()..color = _color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
