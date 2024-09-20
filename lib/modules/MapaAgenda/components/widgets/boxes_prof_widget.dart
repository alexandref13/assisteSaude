import 'package:flutter/material.dart';

class BoxesProfWidget extends StatelessWidget {
  final VoidCallback onTap;
  const BoxesProfWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 160,
      right: 5,
      child: Container(
        child: FloatingActionButton(
          shape: CircleBorder(
            side: BorderSide(
              color: Colors.white,
              width: 4.0,
            ),
          ),
          backgroundColor: Colors.red,
          onPressed: onTap,
          child: Container(
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Icon(
                Icons.my_location_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
