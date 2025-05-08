import 'package:flutter/material.dart';
import 'package:translator/domain/helpers/language.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    required this.languages,
    required this.initialSelection,
    required this.onSelected,
  });

  final List<Language> languages;
  final void Function(Language?)? onSelected;
  final Language? initialSelection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: DropdownMenu(
        onSelected: onSelected,
        menuStyle: MenuStyle(alignment: Alignment.center),
        textStyle: TextStyle(color: Colors.white, fontSize: 14),
        initialSelection: initialSelection,
        textAlign: TextAlign.end,
        trailingIcon: Icon(Icons.arrow_drop_down, color: Colors.white),
        selectedTrailingIcon: Icon(Icons.arrow_drop_up, color: Colors.white),
        inputDecorationTheme: InputDecorationTheme(border: InputBorder.none),
        dropdownMenuEntries: languages
            .map(
              (language) => DropdownMenuEntry(
                value: language,
                label: language.name.toUpperCase(),
              ),
            )
            .toList(),
      ),
    );
  }
}
