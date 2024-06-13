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
          return Column(
            children: [
              _environmentSelector(state, context),
              _authToken(state, context),
            ],
          );
        default:
          return const LoadingIndicator();
      }
    });
  }
    
  Widget _environmentSelector(SettingsSuccessState state, BuildContext context) {
    return DropdownButton(
      value: state.currentEnvironment,
      items: List.generate(state.environments.length, (index) {
        var item = state.environments[index];
        return DropdownMenuItem(value: item, child: Text(item));
      }),
      onChanged: (item) {
        if (item != null) {
          context.read<SettingsBloc>().selectEnvironment(item);
        }
      });
  }

  Widget _authToken(SettingsSuccessState state, BuildContext context) {
    return TextButton(
      child: const Text('Tap to copy AuthToken'),
      onPressed: () async {
        await Clipboard.setData(ClipboardData(text: state.authToken));
      }
    );
  }
    
}