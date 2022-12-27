import 'package:flutter/material.dart';
import 'package:stickable_screen_flutter/stickable_screen_flutter.dart';

class BannerSticker extends StatefulWidget {
  const BannerSticker({Key? key}) : super(key: key);

  @override
  State<BannerSticker> createState() => _BannerStickerState();
}

class _BannerStickerState extends State<BannerSticker> {
  bool _isShowing = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_isShowing) {
      return StickableSticker(
        delayShowing: 3000,
        maxWidth: size.width,
        horizontalRatio: 0.9,
        position: const Offset(20, 300),
        draggable: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10)
              ),
                width: 380,
                child: Image.asset(
                  "assets/images/banner.png",
                  fit: BoxFit.fitWidth,
                )),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isShowing = false;
                  });
                },

                child: Container(
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
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
