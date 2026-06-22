import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

const _white = Colors.white;

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({
    required this.currentIndex,
    required this.onChanged,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;

  static const _items = [
    Icons.home_outlined,
    Icons.article_outlined,
    Icons.work_outline,
    Icons.message_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final safeBottom = MediaQuery.paddingOf(context).bottom;

    final circleSize = 60.r;
    final circleRadius = circleSize / 2;
    final notchRadius = circleRadius + 5.r; // gap -> the ring around the circle
    final barHeight = 60.h;
    final navHeight = 75.h; // taller than before so the circle can poke up

    final barTop = navHeight - barHeight;        // bar top, in stack coords
    final circleCenterY = circleRadius;          // circle has top: 0
    final guestCenterDy = circleCenterY - barTop; // painter-relative (negative = above edge)

    final selectedIndex = currentIndex.clamp(0, _items.length - 1);

    return SizedBox(
      height: navHeight + safeBottom,
      child: Padding(
        padding: EdgeInsets.only(bottom: safeBottom),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / _items.length;
            final targetCenter = (itemWidth * selectedIndex) + (itemWidth / 2);

            return TweenAnimationBuilder<double>(
              tween: Tween<double>(end: targetCenter),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              builder: (context, centerX, _) {
                final circleLeft = centerX - circleRadius;

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Notched bar
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: barHeight,
                      child: CustomPaint(
                        painter: _NotchedBarPainter(
                          centerX: centerX,
                          notchRadius: notchRadius,
                          guestCenterDy: guestCenterDy,
                          color: Color(0xFF333333),
                          cornerRadius: 10.r,
                        ),
                      ),
                    ),

                    // Icons row (selected slot hidden, the circle shows it)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: barHeight,
                      child: Row(
                        children: List.generate(_items.length, (index) {
                          final selected = index == selectedIndex;
                          return Expanded(
                            child: _BottomBarIcon(
                              icon: _items[index],
                              hidden: selected,
                              onTap: () => onChanged(index),
                            ),
                          );
                        }),
                      ),
                    ),

                    // Selected black circle, cradled by the notch
                    Positioned(
                      left: circleLeft,
                      top: 0,
                      child: GestureDetector(
                        onTap: () => onChanged(selectedIndex),
                        child: Container(
                          height: circleSize,
                          width: circleSize,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 160),
                            transitionBuilder: (child, animation) =>
                                ScaleTransition(
                                  scale: animation,
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                ),
                            child: Container(
                              height: 50.r,
                              width: 50.r,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color:  Color(0xFF333333),// green circle
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _items[selectedIndex],
                                key: ValueKey(selectedIndex),
                                color: _white,
                                size: 23.r,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _BottomBarIcon extends StatelessWidget {
  const _BottomBarIcon({
    required this.icon,
    required this.hidden,
    required this.onTap,
  });

  final IconData icon;
  final bool hidden;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    customBorder: const CircleBorder(),
    child: Center(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 140),
        opacity: hidden ? 0 : 1,
        child: Icon(icon, color: _white, size: 24.r),
      ),
    ),
  );
}

/// Paints the dark bar with rounded top corners and a moving concave notch.
class _NotchedBarPainter extends CustomPainter {
  _NotchedBarPainter({
    required this.centerX,
    required this.notchRadius,
    required this.guestCenterDy,
    required this.color,
    required this.cornerRadius,
  });

  final double centerX;
  final double notchRadius;
  final double guestCenterDy; // painter-relative y of the notch circle center
  final Color color;
  final double cornerRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final host = Offset.zero & size;
    final guest = Rect.fromCircle(
      center: Offset(centerX, guestCenterDy),
      radius: notchRadius,
    );
    canvas.drawPath(
      _path(host, guest, cornerRadius),
      Paint()
        ..color = color
        ..isAntiAlias = true,
    );
  }

  // Notch geometry adapted from Flutter's CircularNotchedRectangle.
  Path _path(Rect host, Rect guest, double radius) {
    final double r = notchRadius;
    const double s1 = 15.0;
    const double s2 = 1.0;
    final double a = -r - s2;
    final double b = host.top - guest.center.dy;
    final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = math.sqrt(r * r - p2xA * p2xA);
    final double p2yB = math.sqrt(r * r - p2xB * p2xB);

    final p = List<Offset>.filled(6, Offset.zero);
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);
    p[3] = Offset(-p[2].dx, p[2].dy);
    p[4] = Offset(-p[1].dx, p[1].dy);
    p[5] = Offset(-p[0].dx, p[0].dy);
    for (var i = 0; i < p.length; i++) {
      p[i] += guest.center;
    }

    return Path()
      ..moveTo(host.left, host.top + radius)
      ..arcToPoint(Offset(host.left + radius, host.top),
          radius: Radius.circular(radius))
      ..lineTo(p[0].dx, p[0].dy)
      ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
      ..arcToPoint(p[3], radius: Radius.circular(r), clockwise: false)
      ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
      ..lineTo(host.right - radius, host.top)
      ..arcToPoint(Offset(host.right, host.top + radius),
          radius: Radius.circular(radius))
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }

  @override
  bool shouldRepaint(_NotchedBarPainter old) =>
      old.centerX != centerX ||
          old.notchRadius != notchRadius ||
          old.guestCenterDy != guestCenterDy ||
          old.color != color ||
          old.cornerRadius != cornerRadius;
}
