
import 'package:flutter/material.dart';

class HomePainter extends CustomPainter {
  final Color color;

  HomePainter({super.repaint, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final lapiz = Paint();

    lapiz.color = color;
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 10;

    path.moveTo(0, 0);
    path.lineTo(0, size.height*.25);
    path.arcToPoint(
      Offset(size.width*.3, size.height*.15),
      radius: Radius.circular(size.width*.32),
    );
    path.lineTo(size.width*.7, size.height*.16);
    path.arcToPoint(
      Offset(size.width, size.height*.07),
      radius: Radius.circular(size.width*.31),
      clockwise: false
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, lapiz);

    

    //? SEGUNDO DIBUJO
    path.reset();
    lapiz.color = Colors.grey;
    path.moveTo(0, size.height*.9);
    path.arcToPoint(
      Offset(size.width*.5, size.height),
      radius: Radius.circular(size.width*.29)
    );
    path.lineTo(0, size.height);

    
    
    canvas.drawPath(path, lapiz);

    //? TERCER DIBUJO
    path.reset();
    lapiz.color = color;
    path.moveTo(0, size.height);
    path.arcToPoint(
      Offset(size.width*.4, size.height),
      radius: const Radius.circular(1)
    );
    canvas.drawPath(path, lapiz);

    path.reset();
    path.moveTo(size.width*.85, size.height*.92);
    path.arcToPoint(
      Offset(size.width*.95, size.height*.97),
      radius: const Radius.circular(1)
    );
    path.arcToPoint(
      Offset(size.width*.85, size.height*.92),
      radius: const Radius.circular(1),
      clockwise: true
    );
    canvas.drawPath(path, lapiz);


  }

  @override
  bool shouldRepaint(HomePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(HomePainter oldDelegate) => false;
}