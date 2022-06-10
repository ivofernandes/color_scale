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
    List<double> values = [-20, -15, -10, -5, 0, 5, 10, 15, 20];

    return MaterialApp(
        title: 'Color Scale Demo',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Color scale'),
          ),
          body: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: values
                  .map(
                    (value) => Container(
                      margin: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: Container(
                          alignment: Alignment.bottomRight,
                          width: 60,
                          child: ColorScaleWidget(
                              value: value,
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
                                            style: TextStyle(
                                                color: Colors.blueAccent),
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
          ),
        ));
  }
}
