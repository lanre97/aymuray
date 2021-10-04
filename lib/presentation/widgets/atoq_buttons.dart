import 'package:flutter/material.dart';

class AtoqButtonProWidget extends StatefulWidget {
  final String text;
  final Color? color;
  final Color? borderColor;
  final Color? foregroundColor;
  final VoidCallback onPressed;
  final VoidCallback? onInactivePressed;
  final bool isActive;
  final bool isLoading;
  const AtoqButtonProWidget({
    Key? key,
    required this.text,
    this.color = Colors.black,
    this.borderColor = Colors.black,
    this.foregroundColor = Colors.white,
    required this.onPressed,
    this.onInactivePressed,
    this.isActive = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  _AtoqButtonProWidgetState createState() => _AtoqButtonProWidgetState();
}

class _AtoqButtonProWidgetState extends State<AtoqButtonProWidget> {
  @override
  Widget build(BuildContext context) {
    VoidCallback? _onPressed = () {};

    if (!widget.isLoading) {
      if (widget.isActive) {
        _onPressed = widget.onPressed;
      } else {
        _onPressed = widget.onInactivePressed;
      }
    }

    //Size size = MediaQuery.of(context).size;
    return ElevatedButton(
        child: !widget.isLoading
            ? Text(
                widget.text,
                style: TextStyle(color: widget.foregroundColor, fontSize: 19),
              )
            : SizedBox(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(widget.foregroundColor),
                ),
                height: 25,
                width: 25,
              ),
        style: ElevatedButton.styleFrom(
          primary: widget.isActive || widget.isLoading
              ? widget.color
              : Colors.grey[400],
          shape: ContinuousRectangleBorder(
            side: BorderSide(
              color: widget.isActive || widget.isLoading
                  ? (widget.borderColor ?? Colors.green)
                  : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: _onPressed ?? () {});
  }
}
