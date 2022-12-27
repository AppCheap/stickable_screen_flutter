import 'package:flutter/material.dart';

class StickableSticker extends StatefulWidget {
  const StickableSticker({
    Key? key,
    required this.child,
    this.delayShowing,
    this.position,
    this.draggable = false,
    this.horizontalRatio = 0.5,
    required this.maxWidth,
  }) : super(key: key);
  final Widget child;
  final int? delayShowing;
  final Offset? position;
  final bool? draggable;
  final double? horizontalRatio;
  final double maxWidth;
  @override
  State<StickableSticker> createState() => _StickableStickerState();
}

class _StickableStickerState extends State<StickableSticker> {
  bool _isShowing = false;
  late final ValueNotifier<Offset> _position;
  late double _width;

  @override
  void initState() {
    _position = ValueNotifier(widget.position ?? const Offset(100, 100));
    _width = widget.maxWidth * widget.horizontalRatio!;
    Future.delayed(Duration(milliseconds: widget.delayShowing ?? 0), () {
      setState(() {
        _isShowing = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isShowing) {
      return ValueListenableBuilder(
        valueListenable: _position,
        builder: (context, position, _) {
          return Positioned(
            left: position.dx,
            top: position.dy,
            child: (widget.draggable!)
                ? Draggable(
                    maxSimultaneousDrags: 1,
                    feedback: SizedBox(
                      width: _width,
                      child: widget.child,
                    ),
                    childWhenDragging: const SizedBox.shrink(),
                    onDragEnd: (details) => updatePosition(details.offset),
                    child: SizedBox(
                      width: _width,
                      child: widget.child,
                    ),
                  )
                : SizedBox(
                    width: _width,
                    child: widget.child,
                  ),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }

  void updatePosition(Offset newPosition) {
    _position.value = newPosition;
  }
}
