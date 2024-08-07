import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final String? buttonCopyContent;
  final String? buttonCopyText;

  const CustomExpansionPanelList({
    super.key,
    required this.title,
    required this.action,
    required this.checkbox,
    required this.isOpen,
    required this.onExpansionChanged,
    required this.onCheckboxChanged,
    required this.markdownData,
    this.buttonCopyContent,
    this.buttonCopyText,
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
              height: MediaQuery.of(context).size.height * 0.80,
              child: Stack(
                children: [
                  GestureDetector(
                    child: Markdown(
                      data: widget.markdownData,
                      onTapLink: (text, href, title) async {
                        if (href != null) {
                          final uri = Uri.parse(href);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          } else {
                            throw 'Could not launch $href';
                          }
                        }
                      },
                    ),
                  ),
                  widget.buttonCopyContent != null &&
                          widget.buttonCopyText != null
                      ? Positioned(
                          bottom: 1.0,
                          left: 16.0,
                          right: 16.0,
                          child: ElevatedButton(
                            onPressed: () async {
                              await Clipboard.setData(ClipboardData(
                                  text: widget.buttonCopyContent.toString()));
                              if (mounted) {
                                // TODO: investigate microtask further
                                Future.microtask(
                                  () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Copied to clipboard!'),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            child: Text(widget.buttonCopyText.toString()),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          isExpanded: widget.isOpen,
        ),
      ],
    );
  }
}
