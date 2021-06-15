import 'package:flutter/cupertino.dart';

import 'config_data.dart';

class ConfigProvider extends InheritedWidget {
  final ConfigData data;

  ConfigProvider({
    required this.data,
    required Widget child,
  }) : super(child: child);

  static ConfigProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ConfigProvider>();
  }

  @override
  bool updateShouldNotify(ConfigProvider oldWidget) => data != oldWidget.data;
}
