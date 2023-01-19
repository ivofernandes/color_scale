This project is for making a color of a widget dynamic depending on a value, this a behaviour common to see in excel or google sheets, as color scale of the conditional formatting,
when you want to have a  color giving an indication of what value is being presented and make the data consumtion easier and more intuitive

![Color scale example screenshot 1](https://raw.githubusercontent.com/ivofernandes/color_scale/master/doc/simulator_screenshot_1.png?raw=true)
![Color scale example screenshot 2](https://raw.githubusercontent.com/ivofernandes/color_scale/master/doc/simulator_screenshot_2.png?raw=true)


In this video I explained how to use color scale, in a flutter project
https://www.youtube.com/watch?v=jqckPlHoRTI

## Features

Create a container with a color that depends on a value, this can help the user to identify data inside a report without need to read everything.

## Getting started

Add the dependency to your `pubspec.yaml`:
```
color_scale: ^0.0.4
```

## Usage
```dart
ColorScaleWidget(
    value: 0, // Customize here the value that you want to influence the color
    minValue: -20,
    minColor: Colors.white,
    maxValue: 20,
    maxColor: Colors.black,
    child: Container(
        margin: EdgeInsets.all(5),
        child: Text('50% between black and white')
    )
)
```

Usage
```dart
ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    child: SizedBox(
      width: 50,
      height: 50,
      child: ColorScaleStopsWidget(
        value: 0,  // Customize here the value that you want to influence the color
        colorStops: <double, Color>{
          -20: Colors.red,
          0: Colors.yellow,
          20: Colors.green,
        },
        child: Text('Add your widget here!'),
      ),
    ),
),
```

## Like us on pub.dev
Package url:
https://pub.dev/packages/color_scale

## Contribute on github
https://github.com/ivofernandes/color_scale

## Instruction to publish the package to pub.dev
dart pub publish