This project is for making a color of a widget dynamic depending on a value, this a behaviour common to see in excel or google sheets,
when you want to have a  color giving an indication of what value is being presented and make the data consumtion easier and more intuitive

![Color scale](https://raw.githubusercontent.com/ivofernandes/color_scale/master/doc/simulator_screenshot_1.png?raw=true)

## Features

Create a container with a color that depends on a value

## Getting started


Add the dependency to your `pubspec.yaml`:
```
color_scale: ^0.0.1
```

## Usage
```dart
ColorScaleWidget(
    value: 0,
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

## Like us on pub.dev
Package url:
https://pub.dev/packages/color_scale

## Contribute on github
https://github.com/ivofernandes/color_scale

## Instruction to publish the package to pub.dev
dart pub publish