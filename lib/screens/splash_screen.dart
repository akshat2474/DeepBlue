import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'deep_blue_home_page.dart';
import '../constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _particleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _particleController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));
    
    _slideAnimation = Tween<double>(
      begin: 30.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    ));
    
    _fadeController.forward();
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, _) => const DeepBlueHomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBlack,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/bg.png',
            fit: BoxFit.cover,
          ),
          
          // Deep ocean gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.backgroundBlack.withValues(alpha: .3),
                  AppColors.backgroundBlack.withValues(alpha:0.8),
                  AppColors.backgroundBlack.withValues(alpha:0.95),
                ],
              ),
            ),
          ),
          
          // Subtle animated particles (like ocean data points)
          AnimatedBuilder(
            animation: _particleController,
            builder: (context, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: DataPointPainter(_particleController.value),
              );
            },
          ),
          
          // Main content
          FadeTransition(
            opacity: _fadeAnimation,
            child: AnimatedBuilder(
              animation: _slideAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _slideAnimation.value),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          
                          // Clean DeepBlue branding
                          Text(
                            'DeepBlue',
                            style: TextStyle(
                              fontSize: 56,
                              fontWeight: FontWeight.w300,
                              color: AppColors.primaryWhite,
                              letterSpacing: 4,
                            ),
                          ),
                          
                          const SizedBox(height: 8),
                          
                          Container(
                            height: 2,
                            width: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.lightBlueAccent.withValues(alpha:0.8),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          Text(
                            'Ocean Intelligence Platform',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryWhite.withValues(alpha:0.9),
                              letterSpacing: 1.2,
                            ),
                          ),
                          
                          const SizedBox(height: 8),
                          
                          Text(
                            'Powered by Global Argo Float Network',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.greyText,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          
                          const SizedBox(height: 80),
                          
                          // Professional info card
                          Container(
                            padding: const EdgeInsets.all(32),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground.withValues(alpha:0.4),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.borderColor.withValues(alpha:0.3),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Real-Time Ocean Monitoring',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryWhite,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Access live data from 4,000+ autonomous Argo floats worldwide, providing unprecedented insights into ocean temperature profiles, salinity measurements, and deep-water circulation patterns.',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.greyText,
                                    height: 1.5,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                
                                // Clean stats display
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildCleanStat('4,000+', 'Active Floats'),
                                    _buildCleanStat('2,000m', 'Max Depth'),
                                    _buildCleanStat('Global', 'Coverage'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          const Spacer(),
                          
                          // Professional enter button
                          GestureDetector(
                            onTap: _navigateToHome,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 48,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.cardBackground,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppColors.borderColor,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'Enter Platform',
                                style: TextStyle(
                                  color: AppColors.primaryWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCleanStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryWhite,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.greyText,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _particleController.dispose();
    super.dispose();
  }
}

// Subtle data point animation (like floating data particles)
class DataPointPainter extends CustomPainter {
  final double animationValue;

  DataPointPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.lightBlueAccent.withValues(alpha:0.1)
      ..strokeCap = StrokeCap.round;

    final random = math.Random(123);
    
    // Create subtle floating data points
    for (int i = 0; i < 15; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final offset = math.sin(animationValue * 2 * math.pi + i) * 3;
      
      paint.color = Colors.lightBlueAccent.withValues(alpha:0.05 + random.nextDouble() * 0.1);
      canvas.drawCircle(
        Offset(x, y + offset),
        random.nextDouble() * 2 + 1,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
