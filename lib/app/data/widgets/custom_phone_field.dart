import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sizer/sizer.dart';

class CustomPhoneField extends StatefulWidget {
  const CustomPhoneField({
    Key? key,
    this.label,
    this.errorText,
    this.hintText,
    this.controller,
    this.onInputChanged,
  }) : super(key: key);
  final String? label;
  final String? errorText;
  final String? hintText;
  final TextEditingController? controller;
  final Function(PhoneNumber)? onInputChanged;
  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      widget.label!,
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: widget.errorText != null ? Colors.red : null,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        SizedBox(height: 1.5.h),
        InternationalPhoneNumberInput(
          cursorColor: Theme.of(context).primaryColor,
          // searchBoxDecoration: InputDecoration(sty),
          initialValue: PhoneNumber(phoneNumber: '3362462131', isoCode: 'PK'),
          inputDecoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: Theme.of(context).textTheme.headlineMedium,
            // label: widget.label == null ? null : Text(widget.label!),
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.titleSmall,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(15.0),
            ),
            errorText: widget.errorText,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          textStyle: const TextStyle(color: Colors.black),
          onInputChanged: (PhoneNumber number) {
            widget.onInputChanged!(number);
          },
          onInputValidated: (bool value) {
            print(value);
          },
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.DIALOG,
            setSelectorButtonAsPrefixIcon: true,
            leadingPadding: 20,
            trailingSpace: false,
          ),
          selectorTextStyle: const TextStyle(color: Colors.grey),
          // initialValue: number,
          textFieldController: widget.controller,
          formatInput: false,
          keyboardType: const TextInputType.numberWithOptions(
            signed: true,
            decimal: true,
          ),
          inputBorder: const OutlineInputBorder(),
          onSaved: (PhoneNumber number) {
            print('On Saved: $number');
          },
        ),
      ],
    );
  }
}
