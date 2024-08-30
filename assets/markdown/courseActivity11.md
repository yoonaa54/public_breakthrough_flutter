## Making changes

Here is a collection of hints to help you modify this code to your liking.

You might also find supporting help searching this repo for "TODO:" entries

### **Changing the default app page**

If app reloads are needed to apply the changes you're testing, that can slow you down.

In particular, navigating back to the page under test. For that reason it is useful to review the [code starting at](https://github.com/thatdogmachine/public_breakthrough_flutter/blob/3900ba982810a87d844ec953545f329fd4190226/lib/main.dart#L194) and [to](https://github.com/thatdogmachine/public_breakthrough_flutter/blob/3900ba982810a87d844ec953545f329fd4190226/lib/main.dart#L207)

We can see the following alternatives available for the `body` element:

[CourseActivitiesPage](https://github.com/thatdogmachine/public_breakthrough_flutter/blob/3900ba982810a87d844ec953545f329fd4190226/lib/main.dart#L132)

[CVPage](https://github.com/thatdogmachine/public_breakthrough_flutter/blob/3900ba982810a87d844ec953545f329fd4190226/lib/main.dart#L138)

[CvHtmlPage](https://github.com/thatdogmachine/public_breakthrough_flutter/blob/3900ba982810a87d844ec953545f329fd4190226/lib/main.dart#L158)

[CalendlyPage](https://github.com/thatdogmachine/public_breakthrough_flutter/blob/3900ba982810a87d844ec953545f329fd4190226/lib/main.dart#L164)

See [here](https://github.com/thatdogmachine/public_breakthrough_flutter/blob/3900ba982810a87d844ec953545f329fd4190226/lib/main.dart#L196) for a concrete example of configuring the `body:` to load `CalendlyPage`



### **Configuration: variables_constants.dart**

Most (all?) deliberate styling decisions are configured in this file. Of particular note:

#### **Background color**

Since by default the background is black, we should review:

```
const colorSchemeSeedColor = Colors.black;
const colorSchemePrimary = Colors.black;
const colorSchemeSecondary = Colors.black;
const colorSchemeSurface = Colors.black;
const colorSchemeOnSurface = Colors.white;
const colorFloatingActionButtonForeground = Colors.black;
```

#### **Branding color**

Breakthrough uses a yellow in their color palette, so we should be interested in:

```
const colorBrandingColor1 = Color.fromARGB(255, 253, 218, 37);
```

#### **Default white text**

To change this we should be interested in:

```
const colorSchemeOnPrimary = Colors.white;
const colorSchemeOnSecondary = Colors.white;
const colorSchemeOnError = Colors.white;
const colorSchemeOnSurface = Colors.white;
const textThemeBodyColor = Colors.white;
const textThemeDisplayColor = Colors.white;
```
