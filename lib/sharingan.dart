import 'package:flutter/material.dart';
import 'dart:math' as math;
 
class SharinganPainter extends CustomPainter {
  final double rotation;
 
  SharinganPainter({required this.rotation});
 
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
 
    // --- Background eye circle ---
    final bgPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF8B0000),
          const Color(0xFF3D0000),
          const Color(0xFF1A0000),
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
 
    canvas.drawCircle(center, radius, bgPaint);
 
    // --- Outer ring ---
    final ringPaint = Paint()
      ..color = const Color(0xFF000000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.06;
    canvas.drawCircle(center, radius * 0.92, ringPaint);
 
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);
 
    // --- 3 Tomoe (magatama) ---
    for (int i = 0; i < 3; i++) {
      canvas.save();
      canvas.rotate(i * 2 * math.pi / 3);
 
      final tomoeOffset = Offset(0, -radius * 0.45);
 
      // Tomoe body (teardrop)
      final tPath = Path();
      final r = radius * 0.13;
      tPath.addOval(Rect.fromCircle(center: tomoeOffset, radius: r));
 
      final tailEnd = Offset(tomoeOffset.dx + radius * 0.15, tomoeOffset.dy + radius * 0.2);
      tPath.moveTo(tomoeOffset.dx, tomoeOffset.dy + r);
      tPath.quadraticBezierTo(
        tomoeOffset.dx + radius * 0.18,
        tomoeOffset.dy + radius * 0.18,
        tailEnd.dx,
        tailEnd.dy,
      );
      tPath.quadraticBezierTo(
        tomoeOffset.dx + radius * 0.1,
        tomoeOffset.dy + radius * 0.28,
        tomoeOffset.dx - r * 0.5,
        tomoeOffset.dy + r * 1.2,
      );
 
      final tomeoPaint = Paint()
        ..color = const Color(0xFF0A0000)
        ..style = PaintingStyle.fill;
      canvas.drawPath(tPath, tomeoPaint);
 
      canvas.restore();
    }
 
    // --- Inner spinning ring detail ---
    final detailPaint = Paint()
      ..color = const Color(0xFF000000).withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.025;
    canvas.drawCircle(Offset.zero, radius * 0.6, detailPaint);
 
    canvas.restore();
 
    // --- Central pupil ---
    final pupilPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF000000),
          const Color(0xFF1A0000),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius * 0.22));
    canvas.drawCircle(center, radius * 0.22, pupilPaint);
 
    // --- Pupil highlight ---
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.15);
    canvas.drawCircle(
      center.translate(-radius * 0.06, -radius * 0.06),
      radius * 0.06,
      highlightPaint,
    );
 
    // --- Outer border glow ---
    final borderPaint = Paint()
      ..color = const Color(0xFFCC0000).withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius - 1, borderPaint);
  }
 
  @override
  bool shouldRepaint(SharinganPainter oldDelegate) =>
      oldDelegate.rotation != rotation;
}
