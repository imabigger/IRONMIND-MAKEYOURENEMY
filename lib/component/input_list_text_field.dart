import 'package:flutter/material.dart';
import 'package:iron_mind/const/text_style.dart';

class InputListTextField extends StatelessWidget {
  final int textIndex;
  final ValueChanged<String>? onChanged;
  final String? initialValue;

  const InputListTextField({required this.initialValue,required this.onChanged,required this.textIndex, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$textIndex.',
          style: const TextStyle(
            fontFamily: 'oswald',
            fontSize: 16.0,
            fontWeight: FontWeight.w700
          ),
        ),
        SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: TextFormField(
            onChanged: onChanged,
            initialValue: initialValue,
            validator: (String? val) {
              if (val == null || val.isEmpty) return 'Empty list';
              return null;
            },
            maxLines: null,
            keyboardType: TextInputType.multiline,
            cursorColor: Colors.black12.withOpacity(0.5),
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[300]!.withOpacity(0.1),
              contentPadding:  const EdgeInsets.symmetric(vertical: 0),
            ),
            style: MAIN_TEXT.copyWith(fontWeight: FontWeight.w400, fontSize: 20.0,fontFamily: 'oswald'),
          ),
        ),
      ],
    );
  }
}
