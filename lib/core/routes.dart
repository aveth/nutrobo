import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/settings/bloc/settings_bloc.dart';
import '../features/settings/ui/settings_screen.dart';
import 'di.dart';

class Routes {

  static MaterialPageRoute toSettings(BuildContext context) {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
          create: (context) => getIt.get<SettingsBloc>(),
          child: const SettingsScreen()
      );
    });
  }

}