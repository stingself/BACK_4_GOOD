import 'package:flutter/material.dart';
import 'dart:math' as math;
 
class RinneganPainter extends CustomPainter {
  final double rotation;
 
  RinneganPainter({required this.rotation});
 
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
 
    // --- Background ---
    final bgPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF5522AA),
          const Color(0xFF2D1166),
          const Color(0xFF0D0520),
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, bgPaint);
 
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
 
    // --- Concentric rings (Rinnegan pattern) ---
    final ringCount = 4;
    for (int i = 1; i <= ringCount; i++) {
      final r = radius * (0.2 + i * 0.17);
      if (r >= radius) break;
 
      final ringPaint = Paint()
        ..color = const Color(0xFF9966FF).withOpacity(0.25 + (ringCount - i) * 0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius * 0.022;
      canvas.drawCircle(Offset.zero, r, ringPaint);
    }
 
    // --- 6 tomoe arranged in circle (outer ring) ---
    _drawTomoeRing(canvas, radius, 6, radius * 0.62, const Color(0xFF220044));
 
    // --- 3 tomoe (inner ring) ---
    _drawTomoeRing(canvas, radius, 3, radius * 0.35, const Color(0xFF110033));
 
    canvas.restore();
 
    // --- Pupils: 6-segment radial lines from center ---
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation * 0.3);
 
    final linePaint = Paint()
      ..color = const Color(0xFF6633BB).withOpacity(0.5)
      ..strokeWidth = radius * 0.018
      ..strokeCap = StrokeCap.round;
 
    for (int i = 0; i < 6; i++) {
      final angle = i * math.pi / 3;
      canvas.drawLine(
        Offset(math.cos(angle) * radius * 0.08, math.sin(angle) * radius * 0.08),
        Offset(math.cos(angle) * radius * 0.18, math.sin(angle) * radius * 0.18),
        linePaint,
      );
    }
    canvas.restore();
 
    // --- Central pupil ---
    final pupilPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF110022),
          const Color(0xFF220044),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 0.2));
    canvas.drawCircle(center, radius * 0.2, pupilPaint);
 
    // --- Pupil highlight ---
    canvas.drawCircle(
      center.translate(-radius * 0.05, -radius * 0.05),
      radius * 0.05,
      Paint()..color = Colors.white.withOpacity(0.12),
    );
 
    // --- Outer glow ring ---
    canvas.drawCircle(
      center,
      radius - 1,
      Paint()
        ..color = const Color(0xFF9966FF).withOpacity(0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }
 
  void _drawTomoeRing(
      Canvas canvas, double radius, int count, double ringRadius, Color color) {
    for (int i = 0; i < count; i++) {
      final angle = i * 2 * math.pi / count;
      final cx = math.cos(angle) * ringRadius;
      final cy = math.sin(angle) * ringRadius;
 
      final r = radius * 0.09;
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
 
      // Tomoe dot
      canvas.drawCircle(Offset(cx, cy), r, paint);
 
      // Tail
      final tailAngle = angle + math.pi * 0.6;
      final tPath = Path();
      tPath.moveTo(cx, cy);
      tPath.quadraticBezierTo(
        cx + math.cos(tailAngle) * r * 2.2,
        cy + math.sin(tailAngle) * r * 2.2,
        cx + math.cos(tailAngle + 0.5) * r * 1.5,
        cy + math.sin(tailAngle + 0.5) * r * 1.5,
      );
      canvas.drawPath(tPath, paint..strokeWidth = r * 0.6 ..style = PaintingStyle.stroke ..strokeCap = StrokeCap.round);
    }
  }
 
  @override
  bool shouldRepaint(RinneganPainter oldDelegate) =>
      oldDelegate.rotation != rotation;
}
