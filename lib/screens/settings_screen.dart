import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:cotufaverse/provider/settings_provider.dart";
import "package:cotufaverse/provider/movies_provider.dart";
import "package:cotufaverse/utils/app_dictionary.dart";

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final settings = Provider.of<SettingsProvider>(context);
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(AppDictionary.translate(context, "settings"))),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: [
          SwitchListTile(
            title: Text(AppDictionary.translate(context, "dark_mode")),
            subtitle: Text(AppDictionary.translate(context, "dark_mode_sub")),
            secondary: const Icon(Icons.dark_mode_outlined),
            value: settings.isDarkMode,
            onChanged: (value) => settings.isDarkMode = value,
          ),
          const Divider(),
          SwitchListTile(
            title: Text(AppDictionary.translate(context, "language")),
            subtitle: Text(
              settings.isEnglish ? "English (US)" : "Español (ES)",
            ),
            secondary: const Icon(Icons.language),
            value: settings.isEnglish,
            onChanged: (value) {
              settings.isEnglish = value;
              moviesProvider.updateLanguage(value);
            },
          ),
          const Divider(),
          SwitchListTile(
            title: Text(AppDictionary.translate(context, "adult_content")),
            subtitle: Text(
              AppDictionary.translate(context, "adult_content_sub"),
            ),
            secondary: const Icon(Icons.no_adult_content),
            value: settings.hideAdultContent,
            onChanged: (value) {
              settings.hideAdultContent = value;
              moviesProvider.updateAdultContent(value);
            },
          ),
          const Divider(),
          ListTile(
            title: Text(AppDictionary.translate(context, "about_devs")),
            subtitle: Text(AppDictionary.translate(context, "about_devs_sub")),
            leading: const Icon(Icons.info_outline),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pushNamed(context, "/about_devs");
            },
          ),
          SizedBox(height: size.height* 0.2),
        ],
      ),
    );
  }
}
