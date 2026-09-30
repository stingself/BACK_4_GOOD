Home screen · DART
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'sharingan_painter.dart';
import 'rinnegan_painter.dart';
 
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
 
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
 
class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotateController;
  late AnimationController _pulseController;
  late AnimationController _glowController;
  late AnimationController _textController;
 
  late Animation<double> _rotateAnim;
  late Animation<double> _pulseAnim;
  late Animation<double> _glowAnim;
  late Animation<double> _textAnim;
 
  @override
  void initState() {
    super.initState();
 
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
 
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
 
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
 
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);
 
    _rotateAnim = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.linear),
    );
 
    _pulseAnim = Tween<double>(begin: 0.92, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
 
    _glowAnim = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
 
    _textAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeInOut),
    );
  }
 
  @override
  void dispose() {
    _rotateController.dispose();
    _pulseController.dispose();
    _glowController.dispose();
    _textController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final eyeSize = size.width * 0.38;
 
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [
              Color(0xFF1A0505),
              Color(0xFF0A0A0A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              const SizedBox(height: 20),
              Text(
                'SHARINGAN  ×  RINNEGAN',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.3),
                  fontSize: 11,
                  letterSpacing: 4,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 50),
 
              // Eyes Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Sharingan Eye
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _rotateAnim,
                      _pulseAnim,
                      _glowAnim,
                    ]),
                    builder: (context, child) {
                      return Column(
                        children: [
                          Transform.scale(
                            scale: _pulseAnim.value,
                            child: Container(
                              width: eyeSize,
                              height: eyeSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFCC0000)
                                        .withOpacity(_glowAnim.value * 0.7),
                                    blurRadius: 30,
                                    spreadRadius: 8,
                                  ),
                                  BoxShadow(
                                    color: const Color(0xFFFF3333)
                                        .withOpacity(_glowAnim.value * 0.3),
                                    blurRadius: 60,
                                    spreadRadius: 15,
                                  ),
                                ],
                              ),
                              child: CustomPaint(
                                painter: SharinganPainter(
                                  rotation: _rotateAnim.value,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Sharingan',
                            style: TextStyle(
                              color: const Color(0xFFCC0000)
                                  .withOpacity(0.85),
                              fontSize: 13,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
 
                  // Rinnegan Eye
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _rotateAnim,
                      _pulseAnim,
                      _glowAnim,
                    ]),
                    builder: (context, child) {
                      return Column(
                        children: [
                          Transform.scale(
                            scale: _pulseAnim.value,
                            child: Container(
                              width: eyeSize,
                              height: eyeSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF6633AA)
                                        .withOpacity(_glowAnim.value * 0.7),
                                    blurRadius: 30,
                                    spreadRadius: 8,
                                  ),
                                  BoxShadow(
                                    color: const Color(0xFF9966FF)
                                        .withOpacity(_glowAnim.value * 0.3),
                                    blurRadius: 60,
                                    spreadRadius: 15,
                                  ),
                                ],
                              ),
                              child: CustomPaint(
                                painter: RinneganPainter(
                                  rotation: -_rotateAnim.value * 0.6,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Rinnegan',
                            style: TextStyle(
                              color: const Color(0xFF9966FF)
                                  .withOpacity(0.85),
                              fontSize: 13,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
 
              const SizedBox(height: 70),
 
              // "I'M BACK" text with glow
              AnimatedBuilder(
                animation: _textAnim,
                builder: (context, child) {
                  return Column(
                    children: [
                      // Divider line
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 1,
                            color: const Color(0xFFCC0000).withOpacity(0.5),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFCC0000)
                                  .withOpacity(_textAnim.value),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 60,
                            height: 1,
                            color: const Color(0xFF6633AA).withOpacity(0.5),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
 
                      // Main text
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Glow layer
                          Text(
                            "I'M BACK",
                            style: TextStyle(
                              fontSize: 46,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 10,
                              foreground: Paint()
                                ..maskFilter = MaskFilter.blur(
                                  BlurStyle.normal,
                                  12 * _textAnim.value,
                                )
                                ..color = const Color(0xFFCC0000)
                                    .withOpacity(0.5 * _textAnim.value),
                            ),
                          ),
                          // Actual text
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                Color(0xFFFF4444),
                                Color(0xFFFFFFFF),
                                Color(0xFFAA66FF),
                              ],
                              stops: [0.0, 0.5, 1.0],
                            ).createShader(bounds),
                            child: const Text(
                              "I'M BACK",
                              style: TextStyle(
                                fontSize: 46,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
 
                      const SizedBox(height: 14),
                      Text(
                        '— and this time, nothing can stop me —',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.25),
                          fontSize: 11,
                          letterSpacing: 2,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  );
                },
              ),
 
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
 
