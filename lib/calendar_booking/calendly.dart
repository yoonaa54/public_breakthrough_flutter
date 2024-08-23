// import 'package:js/js.dart';
import 'package:js/js.dart';
import 'package:flutter/material.dart';
import 'dart:ui_web' as ui;
import 'dart:html' as html;

class CalendlyPage extends StatelessWidget {
  const CalendlyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your CV'),
      ),
      body: const Center(
        child: CalendlyWidget(),
      ),
    );
  }
}

// class CalendlyWidget extends StatefulWidget {
//   const CalendlyWidget({super.key});

//   @override
//   CalendlyWidgetState createState() => CalendlyWidgetState();
// }

// class CalendlyWidgetState extends State<CalendlyWidget> {
//   @override
//   void initState() {
//     super.initState();
//     // Trigger the Calendly widget initialization after the element is rendered
//     Future.delayed(Duration.zero, () {
//       _initializeCalendlyWidget();
//     });
//   }

// class CalendlyWidgetState extends State<CalendlyWidget> {
//   @override
//   void initState() {
//     super.initState();
//     // Trigger the Calendly widget initialization after the element is rendered
//     Future.delayed(Duration.zero, () {
//       initCalendlyWidget(); // Call the JS function directly
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return HtmlElementView(viewType: 'calendly-html');
//   }

@JS('initCalendlyWidget')
external void initCalendlyWidget();

// void _initializeCalendlyWidget() {
//   const script = '''
//     initCalendlyWidget();
//   ''';
//   // Execute the script in the browser's context
//   // ui.window.eval(script);
//   // (context as Element).mountElement as HtmlElementView
//   //   ..webOnlyWindowManager.window.eval(script);
//   if (html.window != null) {
//     // html.window.eval(script);
//     context.callMethod('eval', [script]);
//   }
//   // context.callMethod('eval', [script]);
//   // window.eval(script);
// }

//   @override
//   Widget build(BuildContext context) {
//     return const HtmlElementView(viewType: 'calendly-html');
//   }
// }

class CalendlyWidget extends StatefulWidget {
  const CalendlyWidget({super.key});

  @override
  CalendlyWidgetState createState() => CalendlyWidgetState();
}

class CalendlyWidgetState extends State<CalendlyWidget> {
  late html.DivElement _element;
  @override
  void initState() {
    super.initState();

    ui.platformViewRegistry.registerViewFactory('calendly-html', (int viewId) {
      return html.DivElement()
        ..className = 'calendly-inline-widget'
        ..dataset = {'url': 'https://calendly.com/ewan-nisbet'}
        ..style.height = '100%'
        ..style.width = '100%'
        ..style.border = 'solid'
        ..append(
          html.ScriptElement()
            ..type = 'text/javascript'
            ..src = 'https://assets.calendly.com/assets/external/widget.js'
            ..async = true,
        );
    });
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('Calendly', (int viewId) {
      return _element;
    });
    // Trigger the Calendly widget initialization after the element is rendered
    Future.delayed(const Duration(milliseconds: 500), () {
      initCalendlyWidget(); // Call the JS function directly
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: HtmlElementView(
      viewType: 'calendly-html',
    ));
  }
}
