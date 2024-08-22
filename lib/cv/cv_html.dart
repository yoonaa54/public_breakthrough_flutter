import 'package:my_flutter_app/cv/cv_html_data.dart';
import 'package:simple_html_css/simple_html_css.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CvHtmlPage extends StatefulWidget {
  const CvHtmlPage({super.key});

  @override
  CvHtmlPageState createState() => CvHtmlPageState();
}

class CvHtmlPageState extends State<CvHtmlPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your CV'),
      ),
      body: Column(
        children: [
          Builder(
            builder: (context) {
              return RichText(
                text: HTML.toTextSpan(context, htmlContent1),
              );
            },
          ),
          Builder(
            builder: (context) {
              return RichText(
                text: HTML.toTextSpan(context, htmlContent2,
                    linksCallback: (url) {
                  print('user clicked: $url');
                  _launchURL(url);
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}

Future<void> _launchURL(String url) async {
  var targetUrl = Uri.parse(url);
  if (await canLaunchUrl(targetUrl)) {
    await launchUrl(targetUrl);
  } else {
    throw 'Could not launch $url';
  }
}
