import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  final bool visible;
  Function? setVisible;

  AuthTextField({
    Key? key,
    required this.label,
    required this.icon,
  })  : isPassword = false,
        visible = true,
        super(key: key);

  AuthTextField.password({
    Key? key,
    required this.label,
    required this.icon,
    required this.setVisible,
    required this.visible,
  })  : isPassword = true,
        super(key: key);

  @override
  StateAuthTextField createState() => StateAuthTextField();
}

class StateAuthTextField extends State<AuthTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          TextField(
            controller: _controller,
            obscureText: widget.visible ? false : true,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              prefixIcon: Icon(widget.icon),
              suffixIcon: widget.isPassword
                  ? IconButton(
                onPressed: () {
                  widget.setVisible!();
                },
                icon: Icon(widget.visible
                    ? Icons.visibility
                    : Icons.visibility_off),
              )
                  : null,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade500),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black),
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
        ],
      ),
    );
  }

  String getText() {
    return _controller.text;
  }
}
