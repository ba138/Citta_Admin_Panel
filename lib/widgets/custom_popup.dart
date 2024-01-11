import 'package:flutter/material.dart';

class CustomPopupMenuItem<T> extends PopupMenuEntry<T> {
  final VoidCallback? onTap;
  final Widget child;

  CustomPopupMenuItem({required this.onTap, required this.child});

  @override
  double get height => 40; // Set the desired height

  @override
  bool represents(T? value) {
    return false;
  }

  @override
  _CustomPopupMenuItemState<T> createState() => _CustomPopupMenuItemState<T>();
}

class _CustomPopupMenuItemState<T> extends State<CustomPopupMenuItem<T>> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: widget.child,
      ),
    );
  }
}
