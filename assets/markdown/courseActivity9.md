# Calandly integration

Sign up:

https://calendly.com/signup

Use on my own

click through onboarding

find your username - is likely firstname-lastname

click the gear icon and click add to website, choose the inline embed, should provide output like:

<!-- Calendly inline widget begin -->
<div class="calendly-inline-widget" data-url="https://calendly.com/ewan-nisbet" style="min-width:320px;height:700px;"></div>
<script type="text/javascript" src="https://assets.calendly.com/assets/external/widget.js" async></script>
<!-- Calendly inline widget end -->



import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class CalendlyPage extends StatefulWidget {
  const CalendlyPage({Key? key}) : super(key: key);

  @override
  State<CalendlyPage> createState() => _CalendlyPageState();
}

class _CalendlyPageState extends State<CalendlyPage> {
  late html.DivElement _element;

  @override
  void initState() {
    super.initState();

    _element = html.DivElement()
      ..className = 'calendly-inline-widget'
      ..dataset = {'url': 'https://calendly.com/username/event'}
      ..style.height = '100%'
      ..style.width = '100%'      
      ..style.border = 'none'
      ..append(
        html.ScriptElement()
          ..type = 'text/javascript'
          ..src = 'https://assets.calendly.com/assets/external/widget.js'
          ..async = true,
      );
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('Calendly', (int viewId) {
      return _element;
    });
  }

  @override
  Widget build(BuildContext context) => const SizedBox(
        height: 800,
        child: HtmlElementView(viewType: 'Calendly'),
      );
}