import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:cotufaverse/provider/settings_provider.dart";
import "package:cotufaverse/provider/movies_provider.dart";

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: [
          SwitchListTile(
            title: const Text("Modo oscuro"),
            subtitle: const Text("Cambia a tu tema de preferencia para la app"),
            secondary: const Icon(Icons.dark_mode_outlined),
            value: settings.isDarkMode,
            onChanged: (value) => settings.isDarkMode = value,
          ),
          const Divider(),
          SwitchListTile(
            title: const Text("Idioma de la app"),
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
            title: const Text("Ocultar contenido +18"),
            subtitle: const Text(
              "Oculta las películas con clasificación para adultos en toda la app.",
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
            title: const Text("Acerca de los desarrolladores"),
            subtitle: const Text("Conoce a los devs detrás de la app"),
            leading: const Icon(Icons.info_outline),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pushNamed(context, "/about_devs");
            },
          ),
        ],
      ),
    );
  }
}
