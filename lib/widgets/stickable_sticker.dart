import 'package:flutter/material.dart';
import 'package:stickable_screen_flutter/model/stickable_position.dart';

class StickableSticker extends StatefulWidget {
  const StickableSticker({
    Key? key,
    required this.child,
    this.delayShowing,
    this.position,
    this.draggable = false,
    this.height,
    this.width,
  }) : super(key: key);
  final Widget child;
  final int? delayShowing;
  final StickablePosition? position;
  final bool? draggable;
  final double? height;
  final double? width;
  @override
  State<StickableSticker> createState() => _StickableStickerState();
}

class _StickableStickerState extends State<StickableSticker> {
  bool _isShowing = false;
  late final ValueNotifier<StickablePosition> _position;

  @override
  void initState() {
    _position = ValueNotifier(widget.position ?? StickablePosition(left: 100, top: 100));
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
          Widget child = Stack(
            children: [
              widget.child,
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isShowing = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.2)
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            ],
          );
          return Positioned.directional(
            textDirection: Directionality.of(context),
            start: position.left,
            top: position.top,
            end: position.right,
            bottom: position.bottom,
            width: widget.width,
            height: widget.height,
            child: (widget.draggable!)
                ? Draggable(
                    maxSimultaneousDrags: 1,
                    feedback: SizedBox(
                      width: widget.width,
                      height: widget.height,
                      child: child,
                    ),
                    rootOverlay: true,
                    childWhenDragging: const SizedBox.shrink(),
                    onDragEnd: (details) => updatePosition(StickablePosition(
                      left: details.offset.dx,
                      top: details.offset.dy,
                    )),
                    child: child,
                  )
                : child,
          );
        },
      );
    }
    return const SizedBox.shrink();
  }

  void updatePosition(StickablePosition newPosition) {
    _position.value = newPosition;
  }
}
