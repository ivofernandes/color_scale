import 'package:color_scale/color_scale.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Color Scale Demo',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Color scale'),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text('Simple example'),
                  ColorScaleWidget(
                      value: 0,
                      minValue: -20,
                      minColor: Colors.white,
                      maxValue: 20,
                      maxColor: Colors.black,
                      child: Container(
                          margin: EdgeInsets.all(5),
                          child: Text('50% between black and white'))),
                  const SizedBox(
                    height: 50,
                  ),
                  TestColorScale(
                    text: 'Colors from red to green',
                    values: [-20, -15, -10, -5, 0, 5, 10, 15],
                    minValue: -20,
                    minColor: Colors.red,
                    maxValue: 20,
                    maxColor: Colors.green,
                  ),
                  TestColorScale(
                    text: 'Colors from blue to green',
                    values: [-20, -15, -10, -5, 0, 5, 10, 15],
                    minValue: -20,
                    minColor: Colors.blue,
                    maxValue: 20,
                    maxColor: Colors.green,
                  ),
                  TestColorScale(
                    text: 'Colors from red to yellow',
                    values: [-20, -15, -10, -5, 0, 5, 10, 15],
                    minValue: -20,
                    minColor: Colors.red,
                    maxValue: 20,
                    maxColor: Colors.yellow,
                  ),
                  const Text('Childless example'),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      width: 50,
                      height: 50,
                      child: ColorScaleWidget(
                        value: 0,
                        minValue: -20,
                        minColor: Colors.white,
                        maxValue: 20,
                        maxColor: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class TestColorScale extends StatelessWidget {
  final String text;
  final List<double> values;

  final double minValue;
  final Color minColor;

  final double maxValue;
  final Color maxColor;

  const TestColorScale(
      {this.text = '',
      this.values = const [],
      this.minValue = -20,
      this.minColor = Colors.red,
      this.maxValue = 20,
      this.maxColor = Colors.green});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text),
        Wrap(
          children: values
              .map(
                (value) => Container(
                  margin: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      width: 60,
                      child: ColorScaleWidget(
                          value: value,
                          minValue: minValue,
                          minColor: minColor,
                          maxValue: maxValue,
                          maxColor: maxColor,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.end,
                              children: [
                                Text(
                                  'Value: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontSize: 10),
                                ),
                                Center(
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        '${value.toStringAsFixed(2)}%',
                                      )),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
