import 'dart:math';

import 'package:color_scale/color_scale.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ColorScaleTypeEnum colorScaleTypeEnum = ColorScaleTypeEnum.hsluv;

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Color Scale Demo',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Color scale'),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  DropdownButton<ColorScaleTypeEnum>(
                    value: colorScaleTypeEnum,
                    onChanged: (ColorScaleTypeEnum? newValue) {
                      setState(() {
                        colorScaleTypeEnum = newValue!;
                      });
                    },
                    items: ColorScaleTypeEnum.values
                        .map<DropdownMenuItem<ColorScaleTypeEnum>>(
                          (ColorScaleTypeEnum value) =>
                              DropdownMenuItem<ColorScaleTypeEnum>(
                            value: value,
                            child: Text(value.toString().split('.').last),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Example with stops'),
                  StopsValueAndColorsWidget(
                    key: UniqueKey(),
                    colorStops: <double, Color>{
                      -5: Colors.red,
                      0: const Color(0xff808080),
                      5: Colors.green,
                    },
                    colorScaleTypeEnum: colorScaleTypeEnum,
                  ),
                  const Text('Example with slider'),
                  const ExampleWithSlider(
                      text: 'Slide between min and max color',
                      minColor: Colors.red,
                      maxColor: Colors.green),
                  const SizedBox(
                    height: 50,
                  ),
                  TestColorScale(
                    text: 'Colors from red to green',
                    values: const [-20, -15, -10, -5, 0, 5, 10, 15],
                    minValue: -20,
                    minColor: Colors.red,
                    maxValue: 20,
                    maxColor: Colors.green,
                    colorScaleTypeEnum: colorScaleTypeEnum,
                  ),
                  TestColorScale(
                    text: 'Colors from blue to green',
                    values: const [-20, -15, -10, -5, 0, 5, 10, 15],
                    minValue: -20,
                    minColor: Colors.blue,
                    maxValue: 20,
                    maxColor: Colors.green,
                    colorScaleTypeEnum: colorScaleTypeEnum,
                  ),
                  TestColorScale(
                    text: 'Colors from red to yellow',
                    values: const [-20, -15, -10, -5, 0, 5, 10, 15],
                    minValue: -20,
                    minColor: Colors.red,
                    maxValue: 20,
                    maxColor: Colors.yellow,
                    colorScaleTypeEnum: colorScaleTypeEnum,
                  ),
                  const Text('Childless example'),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: ColorScaleWidget(
                        value: 0,
                        minValue: -20,
                        minColor: Colors.white,
                        maxValue: 20,
                        maxColor: Colors.black,
                        colorScaleTypeEnum: colorScaleTypeEnum,
                      ),
                    ),
                  ),
                  const Text('Childless example with stops'),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: ColorScaleStopsWidget(
                        value: 0,
                        colorStops: <double, Color>{
                          -20: Colors.red,
                          0: Colors.yellow,
                          20: Colors.green,
                        },
                        colorScaleTypeEnum: colorScaleTypeEnum,
                      ),
                    ),
                  ),
                  Text('Example with border radius and padding'),
                  ColorScaleStopsWidget(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    padding: const EdgeInsets.all(10),
                    value: 0,
                    colorStops: <double, Color>{
                      -20: Colors.red,
                      0: Colors.orange,
                      20: Colors.green,
                    },
                    colorScaleTypeEnum: colorScaleTypeEnum,
                    child: Text('P'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class ExampleWithSlider extends StatefulWidget {
  final String text;

  final double minValue;
  final Color minColor;

  final double maxValue;
  final Color maxColor;

  final ColorScaleTypeEnum colorScaleTypeEnum;
  const ExampleWithSlider({
    this.text = '',
    this.minValue = -20,
    this.minColor = Colors.red,
    this.maxValue = 20,
    this.maxColor = Colors.green,
    this.colorScaleTypeEnum = ColorScaleTypeEnum.hsluv,
    super.key,
  });

  @override
  State<ExampleWithSlider> createState() => _ExampleWithSliderState();
}

class _ExampleWithSliderState extends State<ExampleWithSlider> {
  Color minColor = Colors.red;
  double minValue = -20;

  Color maxColor = Colors.green;
  double maxValue = 20;

  double value = 0;

  @override
  void initState() {
    super.initState();

    minColor = widget.minColor;
    minValue = widget.minValue;

    maxColor = widget.maxColor;
    maxValue = widget.maxValue;
  }

  @override
  Widget build(BuildContext context) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Minimum Color'),
                  MyColorPicker(
                    onSelectColor: (color) => setState(() => minColor = color),
                    initialColor: minColor,
                    availableColors: [
                      Colors.red,
                      Colors.orange,
                      Colors.amberAccent,
                      Colors.purple.withOpacity(0.25),
                      Colors.pink.withOpacity(0.5)
                    ],
                  ),
                  const Text('Minimum Value'),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller:
                        TextEditingController(text: minValue.toString()),
                    onChanged: (inputValue) => setState(() {
                      minValue = double.parse(inputValue);
                      value = max(value, minValue);
                    }),
                  ),
                  const Text('Maximum Color'),
                  MyColorPicker(
                    onSelectColor: (color) => setState(() => maxColor = color),
                    initialColor: maxColor,
                    availableColors: [
                      Colors.green,
                      Colors.greenAccent,
                      Colors.blue,
                      Colors.cyan.withOpacity(0.25),
                      Colors.teal.withOpacity(0.5)
                    ],
                  ),
                  const Text('Maximum Value'),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller:
                        TextEditingController(text: maxValue.toString()),
                    onChanged: (inputValue) => setState(() {
                      maxValue = double.parse(inputValue);
                      value = min(value, maxValue);
                    }),
                  ),
                  Slider(
                      min: minValue,
                      max: maxValue,
                      value: value,
                      onChanged: onSliderMove),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: ColorScaleWidget(
                      value: value,
                      minValue: minValue,
                      minColor: minColor,
                      maxValue: maxValue,
                      maxColor: maxColor,
                      colorScaleTypeEnum: widget.colorScaleTypeEnum,
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Text(widget.text),
                            Text('value: ${value.toStringAsFixed(2)}')
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  void onSliderMove(double value) {
    setState(() {
      this.value = value;
    });
  }
}

class MyColorPicker extends StatefulWidget {
  // This function sends the selected color to outside
  final void Function(Color) onSelectColor;

  // List of pickable colors
  final List<Color> availableColors;

  // The default picked color
  final Color initialColor;

  // Determine shapes of color cells
  final bool circleItem;

  const MyColorPicker({
    required this.onSelectColor,
    required this.availableColors,
    required this.initialColor,
    this.circleItem = true,
    super.key,
  });

  @override
  _MyColorPickerState createState() => _MyColorPickerState();
}

class _MyColorPickerState extends State<MyColorPicker> {
  // This variable used to determine where the checkmark will be
  late Color _pickedColor;

  @override
  void initState() {
    _pickedColor = widget.initialColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: 80,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 50,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: widget.availableColors.length,
          itemBuilder: (context, index) {
            final Color itemColor = widget.availableColors[index];
            return InkWell(
              onTap: () {
                widget.onSelectColor(itemColor);
                setState(() {
                  _pickedColor = itemColor;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: itemColor,
                    shape: widget.circleItem == true
                        ? BoxShape.circle
                        : BoxShape.rectangle,
                    border: Border.all(width: 1, color: Colors.grey.shade300)),
                child: itemColor == _pickedColor
                    ? const Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      )
                    : Container(),
              ),
            );
          },
        ),
      );
}

class TestColorScale extends StatelessWidget {
  final String text;
  final List<double> values;

  final double minValue;
  final Color minColor;

  final double maxValue;
  final Color maxColor;

  final ColorScaleTypeEnum colorScaleTypeEnum;

  const TestColorScale({
    this.text = '',
    this.values = const [],
    this.minValue = -20,
    this.minColor = Colors.red,
    this.maxValue = 20,
    this.maxColor = Colors.green,
    this.colorScaleTypeEnum = ColorScaleTypeEnum.hsluv,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(text),
          Wrap(
            children: values
                .map(
                  (value) => Container(
                    margin: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        alignment: Alignment.bottomRight,
                        width: 60,
                        child: ColorScaleWidget(
                          value: value,
                          minValue: minValue,
                          minColor: minColor,
                          maxValue: maxValue,
                          maxColor: maxColor,
                          colorScaleTypeEnum: colorScaleTypeEnum,
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.end,
                              children: [
                                Text(
                                  'Value: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 10),
                                ),
                                Center(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      '${value.toStringAsFixed(2)}%',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      );
}

class StopsValueAndColorsWidget extends StatefulWidget {
  final Map<double, Color> colorStops;

  final ColorScaleTypeEnum colorScaleTypeEnum;
  const StopsValueAndColorsWidget({
    required this.colorStops,
    required this.colorScaleTypeEnum,
    super.key,
  });

  @override
  State<StopsValueAndColorsWidget> createState() =>
      _StopsValueAndColorsWidgetState();
}

class _StopsValueAndColorsWidgetState extends State<StopsValueAndColorsWidget> {
  Map<double, Color> colorStops = {};
  double value = 0;

  @override
  void initState() {
    super.initState();

    colorStops = widget.colorStops;
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;

    return Card(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Column(
              children: colorStops.keys.map((stopValue) {
                i++;
                final Color stopColor = colorStops[stopValue]!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyColorPicker(
                      onSelectColor: (color) => setState(() {
                        colorStops[stopValue] = color;
                      }),
                      initialColor: stopColor,
                      availableColors: [
                        ...colorStops.values,
                        Colors.purple.withOpacity(0.25),
                        Colors.pink.withOpacity(0.5)
                      ],
                    ),
                    Container(
                      width: 100,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller:
                            TextEditingController(text: stopValue.toString()),
                        onChanged: (inputValue) => setState(() {
                          final double newValue = double.parse(inputValue);
                          colorStops.remove(stopValue);
                          colorStops[newValue] = stopColor;
                        }),
                        decoration: InputDecoration(
                          label: Text('Stop $i'),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            Slider(
                min: colorStops.keys.first,
                max: colorStops.keys.last,
                value: value,
                onChanged: onSliderMove),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: ColorScaleStopsWidget(
                value: value,
                colorStops: colorStops,
                colorScaleTypeEnum: widget.colorScaleTypeEnum,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      const Text('Slide between diferent stops'),
                      Text('value: ${value.toStringAsFixed(2)}')
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSliderMove(double value) {
    setState(() {
      this.value = value;
    });
  }
}
