import 'package:bartr/core/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carouselindicator extends StatelessWidget {
  const Carouselindicator({
    Key? key,
    required this.slides,
    CarouselController? controller,
    required int currentindex,
    required int millisec,
    this.height,
    this.width,
  })  : _controller = controller,
        _currentindex = currentindex,
        _millisec = millisec,
        super(key: key);

  final List slides;
  final CarouselController? _controller;
  final int _currentindex;
  final int _millisec;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: slides.asMap().entries.map(
              (entry) {
                return GestureDetector(
                  onTap: () => _controller!.animateToPage(_currentindex),
                  child: AnimatedContainer(
                    height: 10,
                    width: 10,
                    curve: Curves.fastOutSlowIn,
                    duration: Duration(milliseconds: _millisec * 2),
                    margin: const EdgeInsets.symmetric(
                      vertical: 40.0,
                      horizontal: 4.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentindex == entry.key
                          ? BartrColors.primary
                          : BartrColors.white,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        )
      ],
    );
  }
}
