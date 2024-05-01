import 'package:flutter/material.dart';

class IconAndDescription extends StatelessWidget {

  final IconData _icon;
  final Color _iconColor;
  final String _header;
  final String _detail;

  const IconAndDescription({
    required IconData icon,
    required Color iconColor,
    required String header,
    required String detail,
    super.key,
  })  : _icon = icon,
        _iconColor = iconColor,
        _header = header,
        _detail = detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              _icon,
              color: _iconColor,
            ),
            Text(
              _header,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              _detail,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
