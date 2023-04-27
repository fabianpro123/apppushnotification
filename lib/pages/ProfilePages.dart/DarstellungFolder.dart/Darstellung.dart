import 'package:flutter/material.dart';
import 'package:appp/pages/ProfilePages.dart/DarstellungFolder.dart/preferences_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appp/pages/ProfilePages.dart/DarstellungFolder.dart/preferences.dart';

class Darstellung extends StatelessWidget {
  const Darstellung({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesCubit, Preferences>(
      builder: (context, preferences) {
        return Scaffold(
            // backgroundColor: const Color.fromRGBO(246, 241, 235, 1),
            appBar: AppBar(
              //backgroundColor: const Color.fromRGBO(19, 44, 89, 1),
              title: const Text('Mitteilungen'),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: ListView(
              children: [
                _buildThemeSelect(preferences, context),
              ],
            ));
      },
    );
  }
}

Widget _buildThemeSelect(Preferences preferences, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: Column(
        children: [
          RadioListTile<ThemeMode>(
            title: const Text("Dark Mode"),
            value: ThemeMode.dark,
            groupValue: preferences.themeMode,
            onChanged: (s) {
              context.read<PreferencesCubit>().changePreferences(
                    preferences.copyWith(themeMode: ThemeMode.dark),
                  );
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text("Light Mode"),
            value: ThemeMode.light,
            groupValue: preferences.themeMode,
            onChanged: (s) {
              context.read<PreferencesCubit>().changePreferences(
                    preferences.copyWith(themeMode: ThemeMode.light),
                  );
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text("System"),
            subtitle:
                const Text("The app will look up what your device prefers"),
            value: ThemeMode.system,
            groupValue: preferences.themeMode,
            onChanged: (s) {
              context.read<PreferencesCubit>().changePreferences(
                    preferences.copyWith(themeMode: ThemeMode.system),
                  );
            },
          ),
        ],
      ),
    ),
  );
}
