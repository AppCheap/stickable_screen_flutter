import 'package:flutter/material.dart';
import 'package:stickable_screen_flutter/stickable_screen_flutter.dart';

class VoucherSticker extends StatefulWidget {
  const VoucherSticker({Key? key}) : super(key: key);

  @override
  State<VoucherSticker> createState() => _VoucherStickerState();
}

class _VoucherStickerState extends State<VoucherSticker> {
  bool _isShowing = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_isShowing) {
      return StickableSticker(
        delayShowing: 1000,
        position: StickablePosition(
          left: size.width - 150,
          top: size.height - 100
        ),
        draggable: true,
        width: 150,
        height: 50,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Image.asset(
              "assets/images/voucher.png",
              fit: BoxFit.cover,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isShowing = false;
                });
              },

              child: Container(
                alignment: Alignment.topRight,
                width: 20,
                height: 20,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black.withOpacity(0.5)),
                child: const Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
