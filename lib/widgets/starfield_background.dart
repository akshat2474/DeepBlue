import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../constants/app_colors.dart';

class AnimatedStarfieldBackground extends StatefulWidget {
  const AnimatedStarfieldBackground({Key? key}) : super(key: key);

  @override
  State<AnimatedStarfieldBackground> createState() =>
      _AnimatedStarfieldBackgroundState();
}

class _AnimatedStarfieldBackgroundState
    extends State<AnimatedStarfieldBackground>
    with TickerProviderStateMixin {
  late AnimationController _orbitController;
  late AnimationController _cometController;
  late List<OrbitingStar> stars;
  Comet? activeComet;
  double _lastCometTime = 0;

  @override
  void initState() {
    super.initState();

    // Very slow orbital rotation (2 minutes per full rotation)
    _orbitController = AnimationController(
      duration: const Duration(seconds: 120),
      vsync: this,
    )..repeat();

    _cometController =
        AnimationController(duration: const Duration(seconds: 15), vsync: this)
          ..addListener(() {
            _checkForNewComet();
          })
          ..repeat();

    _generateStars();
  }

  void _checkForNewComet() {
    if (activeComet == null &&
        _cometController.value > 0.4 &&
        (_cometController.value - _lastCometTime) > 0.35) {
      if (math.Random().nextDouble() < 0.15) {
        _spawnComet();
        _lastCometTime = _cometController.value;
      }
    }
  }

  void _spawnComet() {
    final random = math.Random();
    setState(() {
      activeComet = Comet(
        // Start from right side of screen
        startX: 1.1 + random.nextDouble() * 0.3, // Beyond right edge
        startY: random.nextDouble() * 0.4 - 0.1, // Near top of screen
        // End on left side
        endX: -0.3 - random.nextDouble() * 0.3, // Beyond left edge
        endY: random.nextDouble() * 1.2 + 0.4, // Lower on screen
        size: random.nextDouble() * 1.5 + 1.2,
        startTime: DateTime.now().millisecondsSinceEpoch,
        duration: 4000 + random.nextInt(2000),
      );
    });
  }

  void _generateStars() {
    final random = math.Random(42);
    stars = List.generate(200, (index) {
      return OrbitingStar(
        initialX: random.nextDouble() * 2 - 0.5, // Spread beyond screen edges
        initialY: random.nextDouble() * 2 - 0.5,
        size: random.nextDouble() * 1.8 + 0.5,
        opacity: random.nextDouble() * 0.7 + 0.2,
        twinkleSpeed: random.nextDouble() * 0.8 + 0.3,
        distance:
            random.nextDouble() * 800 + 200, // Distance from center for orbit
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: Listenable.merge([_orbitController, _cometController]),
        builder: (context, child) {
          if (activeComet != null) {
            final elapsed =
                DateTime.now().millisecondsSinceEpoch - activeComet!.startTime;
            if (elapsed > activeComet!.duration) {
              activeComet = null;
            }
          }

          return CustomPaint(
            painter: OrbitalStarfieldPainter(
              stars: stars,
              orbitProgress: _orbitController.value,
              activeComet: activeComet,
              currentTime: DateTime.now().millisecondsSinceEpoch,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _orbitController.dispose();
    _cometController.dispose();
    super.dispose();
  }
}

class OrbitingStar {
  final double initialX;
  final double initialY;
  final double size;
  final double opacity;
  final double twinkleSpeed;
  final double distance;

  OrbitingStar({
    required this.initialX,
    required this.initialY,
    required this.size,
    required this.opacity,
    required this.twinkleSpeed,
    required this.distance,
  });
}

class Comet {
  final double startX;
  final double startY;
  final double endX;
  final double endY;
  final double size;
  final int startTime;
  final int duration;

  Comet({
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    required this.size,
    required this.startTime,
    required this.duration,
  });
}

class OrbitalStarfieldPainter extends CustomPainter {
  final List<OrbitingStar> stars;
  final double orbitProgress;
  final Comet? activeComet;
  final int currentTime;

  OrbitalStarfieldPainter({
    required this.stars,
    required this.orbitProgress,
    this.activeComet,
    required this.currentTime,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Screen center for orbital rotation
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Orbital rotation angle
    final rotationAngle = -orbitProgress * 2 * math.pi;

    // Draw orbiting stars
    for (final star in stars) {
      // Convert star position to relative coordinates from center
      final relativeX = (star.initialX - 0.5) * size.width;
      final relativeY = (star.initialY - 0.5) * size.height;

      // Apply orbital rotation
      final rotatedX =
          relativeX * math.cos(rotationAngle) -
          relativeY * math.sin(rotationAngle);
      final rotatedY =
          relativeX * math.sin(rotationAngle) +
          relativeY * math.cos(rotationAngle);

      // Final position on screen
      final finalX = centerX + rotatedX;
      final finalY = centerY + rotatedY;

      // Only draw if visible on screen (with some margin)
      if (finalX >= -50 &&
          finalX <= size.width + 50 &&
          finalY >= -50 &&
          finalY <= size.height + 50) {
        // Twinkling effect
        final twinkle =
            0.5 +
            0.5 * math.sin(orbitProgress * star.twinkleSpeed * 4 * math.pi);
        final currentOpacity = (star.opacity * twinkle).clamp(0.15, 0.85);

        paint.color = Colors.white.withOpacity(currentOpacity);
        canvas.drawCircle(Offset(finalX, finalY), star.size, paint);
      }
    }

    // Draw comet (same as before)
    if (activeComet != null) {
      final elapsed = currentTime - activeComet!.startTime;
      final progress = (elapsed / activeComet!.duration).clamp(0.0, 1.0);

      if (progress <= 1.0) {
        final currentX = _lerp(
          activeComet!.startX,
          activeComet!.endX,
          progress,
        );
        final currentY = _lerp(
          activeComet!.startY,
          activeComet!.endY,
          progress,
        );

        if (currentX >= -0.1 &&
            currentX <= 1.1 &&
            currentY >= -0.1 &&
            currentY <= 1.1) {
          // Comet head
          paint.color = Colors.white.withOpacity(0.95 - progress * 0.4);
          canvas.drawCircle(
            Offset(currentX * size.width, currentY * size.height),
            activeComet!.size,
            paint,
          );

          // Comet tail
          final directionX = activeComet!.endX - activeComet!.startX;
          final directionY = activeComet!.endY - activeComet!.startY;
          final magnitude = math.sqrt(
            directionX * directionX + directionY * directionY,
          );

          if (magnitude > 0) {
            final normalizedX = directionX / magnitude;
            final normalizedY = directionY / magnitude;

            for (int i = 1; i <= 10; i++) {
              final segmentRatio = i / 10.0;
              final tailDistance = 45.0 * segmentRatio;

              final tailX = currentX - normalizedX * tailDistance / size.width;
              final tailY = currentY - normalizedY * tailDistance / size.height;

              final opacity =
                  (0.7 * (1.0 - segmentRatio) * (1.0 - progress * 0.3));
              final segmentSize =
                  activeComet!.size * (1.0 - segmentRatio * 0.6);

              paint.color = Colors.white.withOpacity(opacity.clamp(0.0, 1.0));
              canvas.drawCircle(
                Offset(tailX * size.width, tailY * size.height),
                segmentSize,
                paint,
              );
            }
          }
        }
      }
    }
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
