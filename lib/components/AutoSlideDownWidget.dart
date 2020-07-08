import 'package:flutter/material.dart';

class AutoSlideDownWidget extends StatefulWidget {
  final Widget child;
  final bool hide;

  const AutoSlideDownWidget({Key key, this.child, this.hide = false}) : super(key: key);
  @override
  _AutoSlideDownWidgetState createState() => _AutoSlideDownWidgetState();
}

class _AutoSlideDownWidgetState extends State<AutoSlideDownWidget>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 400));
    super.initState();
  }


  @override
  void didUpdateWidget(AutoSlideDownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.hide!=widget.hide){
      if(widget.hide){
        controller.forward(from:controller.value);
      }else{
        controller.reverse(from: controller.value);
      }
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(0.0, 1.0),
      ).animate(controller),
      child: widget.child, // child is the value returned by pageBuilder
    );
  }
}
