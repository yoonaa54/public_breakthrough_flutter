// See:
// https://pub.dev/packages/simple_html_css
// For supported HTML tags and CSS styles

// TODO: to change the background color, find where
// scaffoldBackgroundColor
// is defined in variables_constants.dart and change it

String htmlContent1 = """
<body style="background-color: white;">
    <h1 style='color: white; font-size:50px; 
    background-color: rgb(0,122,255); font-weight:100;)'
    >
      Hello    !! </h1>

    <h1 style=' font-style:italic;'>Get your <span style='color:lightseagreen;'>
    CV</span> and <span style='color:dodgerblue'>Skills </span> 
    visible to the world</h1>
    <p>Perhaps here you would write a summary of your skills?</p>
    
    <p>Unlikely, but maybe you want to use <span style='color:crimson; 
    text-decoration: underline wavy;'>colour & underline</span> here.<br />Also very
 unlikely in a CV, but you should know it is possible to use <del>strike through</del></p>
    <div style='font-size:17px'>We write things that are 
    <span style='font-size:1.5em;'>Big,</span> <b>bold</b>&nbsp; or 
    <span style='color:green'>colorful</span></div>
    <p style='font-family:times;'>Some different FONT with 
    <span style='background-color:lightcyan;'>this part highlighted</span></p>
    <div style='line-height:2; font-size:17px;'><b style='color: rgb(0,122,255); 
    font-weight:500;'>Some HTML line-heights.</b> Maybe here you will share the experiences
    & skills you want potential employeers to see.</div>
</body>
""";

String htmlContent2 = """
<body>
  <p><a href="https://soundcloud.com">Visit my music site</a></p>
</body>
""";
