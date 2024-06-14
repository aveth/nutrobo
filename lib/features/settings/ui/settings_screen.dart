import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrobo/features/settings/bloc/settings_bloc.dart';
import 'package:nutrobo/features/shared/ui/loading_indicator.dart';
import 'package:nutrobo/features/shared/ui/ui_builder.dart';

class SettingsScreen extends StatelessWidget {

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UiBuilder<SettingsBloc>((context, state) {
      switch (state.runtimeType) {
        case SettingsSuccessState:
          state as SettingsSuccessState;
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                _environmentSelector(state, context),
                _authToken(state, context),
                _signOut(context),
              ],
            ),
          );
        default:
          return const LoadingIndicator();
      }
    });
  }

  Widget _signOut(BuildContext context) {
    return TextButton(child: const Text("Sign Out"), onPressed: () {
      context.read<SettingsBloc>().signOut();
    });
  }
    
  Widget _environmentSelector(SettingsSuccessState state, BuildContext context) {
    return Row(
      children: [
        const Text("Current Environment: "),
        _settingsValue(DropdownButton(
          value: state.currentEnvironment,
          items: List.generate(state.environments.length, (index) {
            var item = state.environments[index];
            return DropdownMenuItem(value: item, child: Text(item));
          }),
          onChanged: (item) {
            if (item != null) {
              context.read<SettingsBloc>().selectEnvironment(item);
            }
          })),
      ],
    );
  }

  Widget _authToken(SettingsSuccessState state, BuildContext context) {
    return Row(
      children: [
        const Text("Authentication Token: "),
        _settingsValue(TextButton(
          child: const Text('Tap to copy'),
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: state.authToken));
          }
        )),
      ],
    );
  }

  Widget _settingsValue(Widget child) {
    return SizedBox(width: 100, child: Center(child: child));
  }
    
}