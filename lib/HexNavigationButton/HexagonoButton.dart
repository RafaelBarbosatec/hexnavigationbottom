
import 'package:flutter/material.dart';

class HexagonoButton extends StatefulWidget{

  final Color color;
  final Color endColor;
  final GestureTapCallback onTap;
  final double size;
  final Icon icon;

  HexagonoButton({
    Key key,
    this.color = Colors.orange,
    this.onTap,
    this.size = 60.0,
    this.icon,
    this.endColor})
      : super(key: key);

  @override
  HexagonoButtonState createState() => new HexagonoButtonState();
}

class HexagonoButtonState extends State<HexagonoButton> with SingleTickerProviderStateMixin{

  Animation<double> animation;
  AnimationController controller;
  double _elevation = 2.0;

  @override
  void initState() {
    super.initState();

    controller = new AnimationController(
        duration: Duration(milliseconds: 300), vsync: this);

    var curve = new CurvedAnimation(parent: controller, curve: Curves.easeOut);

    animation = new Tween(begin: 2.0, end: 4.0).animate(curve)
      ..addListener(() {
        setState(() {
          _elevation = animation.value;
        });
      });
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (pan){
        controller.forward();
      },
      onTapUp: (pan){
        controller.reverse(from: _elevation);
      },
      onTapCancel: (){
        controller.reverse(from: _elevation);
      },
      child: Container(
        height: widget.size,
        width: widget.size*0.9,
        child: new Stack(
          alignment: Alignment.center,
          children: <Widget>[
            new CustomPaint(
              painter: new _HexagonoLogo(color: widget.color, endColor: widget.endColor, elevation: _elevation),
              size:  new Size(widget.size, widget.size),
            ),
            new Icon(widget.icon.icon,color: widget.icon.color, size: widget.size*0.5),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

}

class _HexagonoLogo extends CustomPainter{

  final Color color;
  final Color endColor;
  double elevation = 2.0;

  _HexagonoLogo({this.color = Colors.orange,this.elevation = 2.0,this.endColor});

  @override
  void paint(Canvas canvas, Size size) {

    var r = 2.0;
    var rect = new Offset(0.0, 0.0)&new Size(size.width, size.height);
    var paint = new Paint();
    paint..color = color
      ..strokeWidth = 2.0
      ..shader = new LinearGradient(colors: [color, endColor != null ? endColor:color ],
          begin: Alignment.topRight, end: Alignment.bottomLeft, tileMode:
          TileMode.clamp).createShader(rect)
      ..style = PaintingStyle.fill;

    var path = new Path();

    path.moveTo(1*size.width/2 + (r*2.5), 0*size.height/4 + r); //.

    path.lineTo(2*size.width/2 - r, 1*size.height/4 - r);//
    path.quadraticBezierTo(2*size.width/2, 1*size.height/4, 2*size.width/2, size.height/4 + r);
    path.lineTo(2*size.width/2, 3*size.height/4 - r);// \
    path.quadraticBezierTo(2*size.width/2, 3*size.height/4, 2*size.width/2 - r, 3*size.height/4 + r);
    path.lineTo(1*size.width/2 + (r*2), 4*size.height/4 - r);// \
    path.quadraticBezierTo(1*size.width/2, 4*size.height/4, 1*size.width/2 - (r*2), 4*size.height/4 - r);
    path.lineTo(0*size.width/2 + r, 3*size.height/4 + r);// \
    path.quadraticBezierTo(0*size.width/2, 3*size.height/4, 0*size.width/2 , 3*size.height/4 - r);
    path.lineTo(0*size.width/2, 1*size.height/4 + r);// \
    path.quadraticBezierTo(0*size.width/2, 1*size.height/4, 0*size.width/2 + r, 1*size.height/4 - r);
    path.lineTo(1*size.width/2 - (r*2), 0*size.height/4 + r);// \
    path.quadraticBezierTo(1*size.width/2, 0*size.height/4, 1*size.width/2 + (r*2.5), 0*size.height/4 + r);

    canvas.drawShadow(path, Colors.grey[500], elevation, false);
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(_HexagonoLogo oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate.elevation != elevation;
  }

}