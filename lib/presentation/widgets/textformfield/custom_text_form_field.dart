import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
      super.key, 
      this.label, 
      this.hintText, 
      this.error, 
      this.icon, 
      this.onChanged, 
      this.validator, 
      this.oscureText = false, 
      this.onFieldSubmitted, 
      this.onTapOutside, 
      this.focusNode,
      this.textFormType = TextInputType.emailAddress,
    });

  final String? label;
  final String? hintText;
  final String? error;
  final bool oscureText;
  final IconData? icon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final void Function(PointerDownEvent)? onTapOutside;
  final FocusNode? focusNode;
  final TextInputType? textFormType;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    );

    return TextFormField(
      keyboardType: widget.textFormType,
      focusNode: widget.focusNode,
      onTapOutside: (event) {
        widget.focusNode?.unfocus();
      },
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      obscureText: (widget.oscureText) ? hidePassword : !hidePassword,
      decoration: InputDecoration(
        labelStyle: textStyle.bodyMedium,
        border: border,
        label: (widget.label != null) ? Text("${widget.label}") : const Text(""),
        isDense: true,
        prefixIcon: (widget.icon!=null) ? Icon(widget.icon) : null,
        hintText: widget.hintText,
        errorText: (widget.error!=null) ? widget.error : null,
        suffixIcon: widget.oscureText 
        ? InkWell(
          borderRadius: BorderRadius.circular(50),
          child: (hidePassword==true)
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility)
        ,
          onTap: () {
            setState(() {
              hidePassword = !hidePassword;
            });
          },
        )
        :null
      ),
    );
  }
}

//Icon(Icons.remove_red_eye_outlined)
