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
        theme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff8b6df6),
            brightness: Brightness.dark,
          ),
          scaffoldBackgroundColor: const Color(0xff0f0d16),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff0f0d16),
            elevation: 0,
            centerTitle: true,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xff2a2733),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            labelStyle: const TextStyle(color: Colors.white70),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
          sliderTheme: const SliderThemeData(
            activeTrackColor: Color(0xff8b6df6),
            inactiveTrackColor: Color(0x55ffffff),
            thumbColor: Color(0xffc4b1ff),
          ),
          textTheme: const TextTheme(
            headlineMedium: TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
            titleMedium: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
            bodyMedium: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Color scale'),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<ColorScaleTypeEnum>(
                    value: colorScaleTypeEnum,
                    onChanged: (ColorScaleTypeEnum? newValue) {
                      setState(() {
                        colorScaleTypeEnum = newValue!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Color space',
                    ),
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
                  const SizedBox(height: 24),
                  const SectionHeader(text: 'Example with stops'),
                  StopsValueAndColorsWidget(
                    key: UniqueKey(),
                    colorStops: <double, Color>{
                      -5: Colors.red,
                      0: Colors.white,
                      5: Colors.green,
                    },
                    colorScaleTypeEnum: colorScaleTypeEnum,
                  ),
                  const SizedBox(height: 24),
                  const SectionHeader(text: 'Example with slider'),
                  const ExampleWithSlider(
                    text: 'Slide between min and max color',
                  ),
                  const SizedBox(height: 32),
                  const SectionHeader(text: 'Color scale presets'),
                  TestColorScale(
                    text: 'Colors from red to green',
                    values: const [-20, -15, -10, -5, 0, 5, 10, 15],
                    colorScaleTypeEnum: colorScaleTypeEnum,
                  ),
                  TestColorScale(
                    text: 'Colors from blue to green',
                    values: const [-20, -15, -10, -5, 0, 5, 10, 15],
                    minColor: Colors.blue,
                    colorScaleTypeEnum: colorScaleTypeEnum,
                  ),
                  TestColorScale(
                    text: 'Colors from red to yellow',
                    values: const [-20, -15, -10, -5, 0, 5, 10, 15],
                    maxColor: Colors.yellow,
                    colorScaleTypeEnum: colorScaleTypeEnum,
                  ),
                  const SizedBox(height: 24),
                  const SectionHeader(text: 'Childless examples'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: ColorScaleWidget(
                            value: 0,
                            minColor: Colors.white,
                            maxColor: Colors.black,
                            colorScaleTypeEnum: colorScaleTypeEnum,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: SizedBox(
                          width: 60,
                          height: 60,
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
                    ],
                  ),
                  const SizedBox(height: 20),
                  const SectionHeader(
                      text: 'Example with border radius and padding'),
                  ColorScaleStopsWidget(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    padding: const EdgeInsets.all(12),
                    value: 0,
                    colorStops: <double, Color>{
                      -20: Colors.red,
                      0: Colors.orange,
                      20: Colors.green,
                    },
                    colorScaleTypeEnum: colorScaleTypeEnum,
                    child: const Text(
                      'P',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
  late final TextEditingController minController;
  late final TextEditingController maxController;

  @override
  void initState() {
    super.initState();

    minColor = widget.minColor;
    minValue = widget.minValue;

    maxColor = widget.maxColor;
    maxValue = widget.maxValue;

    minController = TextEditingController(text: minValue.toString());
    maxController = TextEditingController(text: maxValue.toString());
  }

  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    super.dispose();
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
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    controller: minController,
                    onChanged: (inputValue) => setState(() {
                      final double? parsedValue =
                          double.tryParse(inputValue);
                      if (parsedValue == null) {
                        return;
                      }
                      minValue = parsedValue;
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
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: true,
                      decimal: true,
                    ),
                    controller: maxController,
                    onChanged: (inputValue) => setState(() {
                      final double? parsedValue =
                          double.tryParse(inputValue);
                      if (parsedValue == null) {
                        return;
                      }
                      maxValue = parsedValue;
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
  void didUpdateWidget(covariant MyColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialColor != widget.initialColor) {
      _pickedColor = widget.initialColor;
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: 80,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 50,
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
                    border: Border.all(color: Colors.grey.shade300)),
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
  final List<_StopEntry> stops = [];
  double value = 0;
  late final List<Color> _baseAvailableColors;

  @override
  void initState() {
    super.initState();

    // Create stable entries once; they can reorder visually without losing state.
    stops.addAll(
      widget.colorStops.entries.map(
        (entry) => _StopEntry(
          id: UniqueKey().toString(),
          value: entry.key,
          color: entry.value,
        ),
      ),
    );
    // Keep a stable palette so previously available colors don't disappear.
    _baseAvailableColors = {
      ...widget.colorStops.values,
      Colors.purple.withOpacity(0.25),
      Colors.pink.withOpacity(0.5),
    }.toList();
  }

  @override
  void dispose() {
    for (final stop in stops) {
      stop.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<_StopEntry> sortedStops = [...stops]
      ..sort((a, b) => a.value.compareTo(b.value));

    final Map<double, Color> orderedStops = {
      for (final stop in sortedStops) stop.value: stop.color,
    };

    // Stable palette + current stop colors (deduped) so options don't disappear.
    final List<Color> availableColors = {
      ..._baseAvailableColors,
      ...orderedStops.values,
    }.toList();

    final double minStop = sortedStops.first.value;
    final double maxStop = sortedStops.last.value;
    final double clampedValue = value.clamp(minStop, maxStop);

    return Card(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: sortedStops.asMap().entries.map((entry) {
                final int index = entry.key + 1;
                final _StopEntry stop = entry.value;

                return Padding(
                  key: ValueKey(stop.id),
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyColorPicker(
                        key: ValueKey('picker_${stop.id}'),
                        onSelectColor: (color) => setState(() {
                          stop.color = color;
                        }),
                        initialColor: stop.color,
                        availableColors: availableColors,
                      ),
                      Container(
                        width: 140,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: TextField(
                          key: ValueKey('field_${stop.id}'),
                          keyboardType: const TextInputType.numberWithOptions(
                            signed: true,
                            decimal: true,
                          ),
                          controller: stop.controller,
                          onChanged: (inputValue) => setState(() {
                            final double? newValue =
                                double.tryParse(inputValue);
                            if (newValue == null) {
                              return;
                            }
                            stop.value = newValue;
                          }),
                          decoration: InputDecoration(
                            label: Text('Stop $index'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            Slider(
              min: minStop,
              max: maxStop,
              value: clampedValue,
              onChanged: onSliderMove,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: ColorScaleStopsWidget(
                value: clampedValue,
                colorStops: orderedStops,
                colorScaleTypeEnum: widget.colorScaleTypeEnum,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text('Slide between different stops',
                      style:Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black
                      ),),
                      Text('Value: ${clampedValue.toStringAsFixed(2)}',style:Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black
                      )),
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

class SectionHeader extends StatelessWidget {
  final String text;
  const SectionHeader({required this.text, super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      );
}

class _StopEntry {
  _StopEntry({required this.id, required this.value, required this.color})
      : controller = TextEditingController(
          text: value.toStringAsFixed(1),
        );

  final String id;
  double value;
  Color color;
  final TextEditingController controller;

  void dispose() => controller.dispose();
}
