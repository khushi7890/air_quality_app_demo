import 'package:flutter/material.dart';
import 'dart:math';

class AQIWheel extends StatelessWidget {
  final double aqi;

  const AQIWheel({super.key, required this.aqi});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(300, 150), // width x height
      painter: AQIPainter(aqi),
    );
  }
}


class AQIPainter extends CustomPainter {
  final double aqi;
  AQIPainter(this.aqi);

  // 6 AQI categories

  // Colors
  final List<Color> colors = [
    Color(0xFFB4D18A), // 0–50  → Good
    Color(0xFFE8C965), // 51–100 → Moderate
    Color(0xFFE49C63), // 101–150 → Unhealthy for Sensitive Groups
    Color(0xFFD46765), // 151–200 → Unhealthy
    Color(0xFFA573A9), // 201–300 → Very Unhealthy
    Color(0xFF744C74), // 301+ → Hazardous
  ];

  // Labels
  final List<String> labels = [
    "Good",
    "Moderate",
    "Unhealthy for Sensitive Groups",
    "Unhealthy",
    "Very Unhealthy",
    "Hazardous"
  ];

  // Numerical Ranges
  final List<String> ranges = [
    "0-50",
    "51-100",
    "101-150",
    "151-200",
    "201-300",
    "300+"
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2.2;
    final startAngle = pi; // top half starts at 180°
    final sweepAngle = pi; // full half-circle
    final segmentSweep = sweepAngle / colors.length;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 100
      ..strokeCap = StrokeCap.butt;

    // Draw each color segment evenly spaced
    const double gap = 0.02; //
    for (int i = 0; i < colors.length; i++) {
      paint.color = colors[i];
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle + (i * segmentSweep) + (gap / 2),
        segmentSweep - gap,
        false,
        paint,
      );
    }

    // Draw needle
    final normalizedAQI = (aqi.clamp(0, 400)/ 400); // between 0–1
    final needleAngle = startAngle + (normalizedAQI * sweepAngle);
    final needlePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3;

    final needleEnd = Offset(
      center.dx + (radius - 15) * cos(needleAngle),
      center.dy + (radius - 15) * sin(needleAngle),
    );

    canvas.drawLine(center, needleEnd, needlePaint);
    canvas.drawCircle(center, 8, Paint()..color = Colors.black);

    // AQI text
    final aqiPainter = TextPainter(
      text: TextSpan(
        text: 'AQI: ${aqi.toInt()}',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    aqiPainter.layout();
    aqiPainter.paint(
      canvas,
      Offset(center.dx - aqiPainter.width / 2, center.dy - radius * 2),
    );

    // Category Description
    final int category =  (aqi/50).toInt();
    final categoryPainter = TextPainter(
      text: TextSpan(
        text: labels[category],
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    categoryPainter.layout();
    categoryPainter.paint(
      canvas,
      Offset(center.dx - aqiPainter.width / 2, center.dy - radius * 1.75),
    );

    // Dominant pollutant text
    final pollutantPainter = TextPainter(
      text: const TextSpan(
        text: 'Dominant pollutant: pm2.5',
        style: TextStyle(
          fontSize: 14,
          color: Colors.black87,
          fontWeight: FontWeight.w400,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    pollutantPainter.layout();
    pollutantPainter.paint(
      canvas,
      Offset(center.dx - pollutantPainter.width / 2, center.dy + 25),
    );

    // Draw category labels
    final labelPainter =
    TextPainter(textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    for (int i = 0; i < ranges.length; i++) {
      final angle = startAngle + (i + 0.5) * segmentSweep;
      final labelOffset = Offset(
        center.dx + (radius - 10) * cos(angle),
        center.dy + (radius - 10) * sin(angle) - 10,
      );
      labelPainter.text = TextSpan(
        text: ranges[i],
        style: const TextStyle(
          fontSize: 10,
          color: Colors.black,
        ),
      );
      labelPainter.layout();
      labelPainter.paint(
        canvas,
        labelOffset - Offset(labelPainter.width / 2, labelPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
