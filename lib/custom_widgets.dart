import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCheckboxListTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final TextAlign titleAlign;

  const CustomCheckboxListTile({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
    this.titleAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .06),
        child: Text(
          title,
          textAlign: titleAlign,
        ),
      ),
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
  final TextAlign titleAlign;
  final bool action;
  final String checkbox;
  final bool isOpen;
  final Function(bool) onExpansionChanged;
  final Function(bool?) onCheckboxChanged;
  final String markdownData;
  final List<String>? buttonCopyContentList;
  final List<String>? buttonCopyTextList;

  const CustomExpansionPanelList({
    super.key,
    required this.title,
    required this.action,
    required this.checkbox,
    required this.isOpen,
    required this.onExpansionChanged,
    required this.onCheckboxChanged,
    required this.markdownData,
    this.buttonCopyContentList,
    this.buttonCopyTextList,
    this.titleAlign = TextAlign.center,
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
        widget.onExpansionChanged(!widget.isOpen);
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              onTap: () {
                widget.onExpansionChanged(!widget.isOpen);
              },
              title: CustomCheckboxListTile(
                titleAlign: widget.titleAlign,
                title: widget.title,
                value: widget.action,
                onChanged: widget.onCheckboxChanged,
              ),
            );
          },
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.78,
                child: Stack(
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width > 1400
                                ? MediaQuery.of(context).size.width * 0.24
                                : 4.0),
                        child: Markdown(
                          data: widget.markdownData,
                          styleSheet: MarkdownStyleSheet(
                              // this wasn't very satisfactory
                              // textAlign: WrapAlignment.spaceAround,
                              // h1Align: WrapAlignment.spaceAround,
                              // h2Align: WrapAlignment.spaceAround,
                              // // unorderedListAlign: WrapAlignment.spaceAround,
                              ),
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
                    ),
                    Positioned(
                      bottom: 0,
                      left: 16.0,
                      right: 16.0,
                      child: Column(
                        children: List.generate(
                          widget.buttonCopyContentList?.length ?? 0,
                          (index) => Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: clipboardElevatedButton(
                              context,
                              buttonCopyContent:
                                  widget.buttonCopyContentList![index],
                              buttonCopyText: widget.buttonCopyTextList![index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          isExpanded: widget.isOpen,
        ),
      ],
    );
  }

  ConstrainedBox clipboardElevatedButton(
    BuildContext context, {
    required String buttonCopyContent,
    required String buttonCopyText,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: buttonCopyContent));
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
          child: Text(textAlign: TextAlign.center, buttonCopyText),
        ),
      ),
    );
  }
}
