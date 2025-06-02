import 'dart:io';

import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double size;
  final bool enableChange;
  final File? _avatar;
  final VoidCallback? onChange;

  const Avatar({
    super.key,
    this.size = 16.0 * 6,
    this.enableChange = false,
    File? avatar,
    this.onChange,
  }) : _avatar = avatar;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage:
                _avatar != null
                    ? FileImage(_avatar!)
                    : const AssetImage("assets/images/avatar.png")
                        as ImageProvider,
          ),
        ),
        if (enableChange)
          Positioned(
            bottom: -8,
            right: -8,
            child: IconButton(
              onPressed: onChange,
              icon: const Icon(Icons.camera_alt, size: 16),
              color: Colors.white,
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.zero,
                fixedSize: const Size(28, 28),
                shape: const CircleBorder(),
              ),
            ),
          ),
      ],
    );
  }
}
