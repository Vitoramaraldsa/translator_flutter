import 'package:flutter/material.dart';

class TranslateBox extends StatelessWidget {
  const TranslateBox({
    super.key,
    required this.icons,
    this.labelText,
    this.translatedText,
    this.isTextField = true,
    this.onChanged,
    this.onSubmitted,
    this.controller,
  });

  final List<Widget> icons;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final String? labelText;
  final bool isTextField;
  final String? translatedText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      height: 260,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          isTextField
              ? TextField(
                  maxLines: 6,
                  onChanged: onChanged,
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: labelText,
                    alignLabelWithHint: true,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    contentPadding: EdgeInsets.fromLTRB(20, 15, 15, 0),
                  ),
                  textInputAction: TextInputAction.done,
                  onSubmitted: onSubmitted,
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(translatedText ?? "Tradução"),
                  ),
                ),
          Spacer(),
          Divider(indent: 10, endIndent: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: icons,
          ),
        ],
      ),
    );
  }
}
