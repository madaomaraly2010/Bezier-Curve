import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController animationController;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        //  mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedBuilder(
                animation: animationController,
                child: Container(
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 150
                  // child: Image.asset(
                  //   "images/p3.jpg",
                  //   height: 150,
                  //   width: MediaQuery.of(context).size.width * 0.9,
                  //   fit: BoxFit.fill,
                  // ),
                ),
                builder: (context, child) {
                  return ClipPath(
                      clipper: MyClipper(controller: animationController),
                      child: child);
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //  animationController.reset();
          animationController.repeat();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

enum BezierDirection { Top, Bottom }

class MyClipper extends CustomClipper<Path> {
  final Animation<double> controller;
  Animation animation;
  final BezierDirection bezierDirection;
  // final Animatable<double> tween = Tween<double>(begin: 0.0, end: 1.0)
  //     .chain(CurveTween(curve: Curves.easeOutCubic));
  MyClipper({this.controller, this.bezierDirection = BezierDirection.Top}) {
    animation = _createAnimation(this.controller);
  }

  _createAnimation(controller) {
    return TweenSequence([
      TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: Curves.easeOutCubic)),
          weight: 50),
      TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 0.0)
              .chain(CurveTween(curve: Curves.easeOutCubic)),
          weight: 50)
    ]).animate(controller);
  }

  @override
  Path getClip(Size size) {
    //print("${this.animation.value}");
    Animation anim = this.animation;
    return _getPath(size, 20, anim);
  }

  _getPath(Size size, double height, Animation anim) {
    var path = Path();

    if (this.bezierDirection == BezierDirection.Bottom)
      path.lineTo(0, size.height - height + (height * anim.value));
    else if (this.bezierDirection == BezierDirection.Top)
      path.lineTo(0, height - (height * anim.value));

    List<BezierCurve> list = _getBezierList(size, height, anim);

    list.forEach((bezier) {
      path.quadraticBezierTo(bezier.controlPoint.dx, bezier.controlPoint.dy,
          bezier.endPoint.dx, bezier.endPoint.dy);
    });

    if (this.bezierDirection == BezierDirection.Bottom)
      path.lineTo(size.width, 0);
    else if (this.bezierDirection == BezierDirection.Top) {
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    }
    path.close();

    return path;
  }

  _getBezierList(Size size, double height, Animation anim) {
    switch (this.bezierDirection) {
      case BezierDirection.Bottom:
        return [
          BezierCurve(
            controlPoint: Offset(
                (size.width * 0.25), size.height - ((height * 2) * anim.value)),
            endPoint: Offset(size.width * 0.5,
                size.height - height + ((height / 2) * anim.value)),
          ),
          BezierCurve(
            controlPoint: Offset(size.width * 0.75,
                size.height - (height * 2) + (height * 3) * anim.value),
            endPoint: Offset(
                size.width, size.height - height - ((height / 2) * anim.value)),
          )
        ];
        break;

      case BezierDirection.Top:
        return [
          BezierCurve(
            controlPoint:
                Offset((size.width * 0.25), 0 + ((height * 2) * anim.value)),
            endPoint:
                Offset(size.width * 0.5, height - ((height*0.2) * anim.value)  ),
          ),
          BezierCurve(
            controlPoint: Offset(
                size.width * 0.75, (height * 2) - ((height * 2) * anim.value)),
            endPoint: Offset(size.width, 0 + ((height) * anim.value)),
          )
        ];
        break;
      default:
    }
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

class BezierCurve {
  final Offset endPoint;
  final Offset controlPoint;

  BezierCurve({this.endPoint, this.controlPoint});
}

// class MyClipper extends CustomClipper<Path> {
//   final Animation<double> controller;
//   Animation animation;
//   // final Animatable<double> tween = Tween<double>(begin: 0.0, end: 1.0)
//   //     .chain(CurveTween(curve: Curves.easeOutCubic));
//   MyClipper({this.controller}){
//     animation = _createAnimation(this.controller);
//   }

// _createAnimation(controller){
//  return TweenSequence(
//     [TweenSequenceItem(
//        tween: Tween<double>(begin: 0.0, end: 1.0)
//        .chain(CurveTween(curve: Curves.easeOutCubic)),
//        weight: 50
//     ),
//     TweenSequenceItem(
//        tween: Tween<double>(begin: 1.0, end: 0.0)
//        .chain(CurveTween(curve: Curves.easeOutCubic)),
//        weight: 50
//     )
//     ]
//   ).animate(controller);
// }

//   @override
//   Path getClip(Size size) {
//     //print("${this.animation.value}");
//     Animation anim = this.animation;
//     var path = Path();
//     path.lineTo(0, size.height - 50 + (50 * tween.transform(anim.value)));

//     List<BezierCurve> list =_getBezierList(size, 50, anim) ;

//     list.forEach((bezier) {
//       path.quadraticBezierTo(bezier.controlPoint.dx, bezier.controlPoint.dy,
//           bezier.endPoint.dx, bezier.endPoint.dy);
//     });
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }

// _getBezierList(Size size,double height,Animation anim){
// return [
//       BezierCurve(
//         controlPoint: Offset((size.width * 0.25),
//             size.height - ((height * 2) * tween.transform(anim.value))),
//         endPoint: Offset(size.width * 0.5,
//             size.height - height + ((height/2) * tween.transform(anim.value))),
//       ),
//       BezierCurve(
//         controlPoint: Offset(size.width * 0.75,
//             size.height - (height * 2) + (height * 3) * tween.transform(anim.value)),
//         endPoint: Offset(
//             size.width, size.height - height - ((height/2) * tween.transform(anim.value))),
//       )
//     ];
// }
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     // TODO: implement shouldReclip
//     return true;
//   }
// }
