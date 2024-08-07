import 'package:flutter/material.dart';

import 'package:flutter_markdown/flutter_markdown.dart';

class CustomCheckboxListTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const CustomCheckboxListTile({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: GestureDetector(
        onTap: () {
          onChanged?.call(!value);
        },
        child: Checkbox(
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class CustomExpansionPanelList extends StatefulWidget {
  final String title;
  final bool action;
  final String checkbox;
  final bool isOpen;
  final Function(bool) onExpansionChanged;
  final Function(bool?) onCheckboxChanged;
  final String markdownData;

  const CustomExpansionPanelList({
    super.key,
    required this.title,
    required this.action,
    required this.checkbox,
    required this.isOpen,
    required this.onExpansionChanged,
    required this.onCheckboxChanged,
    required this.markdownData,
  });

  @override
  CustomExpansionPanelListState createState() =>
      CustomExpansionPanelListState();
}

class CustomExpansionPanelListState extends State<CustomExpansionPanelList> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        widget.onExpansionChanged(!isExpanded);
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              onTap: () {
                widget.onExpansionChanged(!widget.isOpen);
              },
              title: CustomCheckboxListTile(
                title: widget.title,
                value: widget.action,
                onChanged: widget.onCheckboxChanged,
              ),
            );
          },
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 200,
              child: Markdown(
                data: widget.markdownData,
              ),
            ),
          ),
          isExpanded: widget.isOpen,
        ),
      ],
    );
  }
}
