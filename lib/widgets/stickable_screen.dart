import 'package:flutter/cupertino.dart';

class StickableScreen extends StatelessWidget {
  const StickableScreen({Key? key, required this.child, this.sticker}) : super(key: key);
  final Widget child;
  final List<Widget>? sticker;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        ...?sticker,
      ],
    );
  }
}
