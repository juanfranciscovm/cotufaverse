import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cotufaverse/provider/settings_provider.dart';

class AppDictionary {
  static final Map<String, Map<String, String>> _dict = {
    'es': {
      //navbar
      'home': 'Inicio',
      'search': 'Buscar',
      'profile': 'Perfil',
      'settings': 'Ajustes',

      //home
      'in_theaters': 'En Cines',
      'popular': 'Populares',

      //búsqueda
      'search_title': 'Buscar',
      'search_hint': 'Descubre tu aventura de hoy',
      'search_results': 'Resultados de la búsqueda',
      'no_results': 'No se encontraron resultados.',

      //detalles
      'cast': 'Actores',
      'unknown': 'Desconocido',

      //config
      'dark_mode': 'Modo oscuro',
      'dark_mode_sub': 'Cambia al tema de tu preferencia',
      'language': 'Idioma de la app',
      'adult_content': 'Ocultar contenido +18',
      'adult_content_sub': 'Filtra películas con clasificación para adultos',
      'about_devs': 'Acerca de los desarrolladores',
      'about_devs_sub': 'Conoce al equipo detrás de la app',

      //profile
      'welcome': 'Bienvenido',
      'see_favorites': 'VER MIS FAVORITOS',
      'login': 'INICIAR SESIÓN',
      'logout': 'CERRAR SESIÓN',
      'logout_success': 'Sesión cerrada correctamente',
      'login_success': 'Sesión iniciada correctamente',
      'login_error': 'Error al iniciar sesión',
      'login_text':
          '¡Guarda tus favoritos\nen un solo lugar al\niniciar sesión en tu\ncuenta!',

      //misc
      'favorites': 'Favoritos',
      'top_movies': 'Top Películas',
      'popular_movies': 'Películas Populares',
      'upcoming': 'Por ',
      'upcoming_movies': 'Estrenar',
      'movie_directory': 'Directorio de Películas',
      'no_popcorn': 'Por acá no hay cotufas...',
      'sort_by': 'Ordenar',
      'sort_popular': 'Popular',
      'sort_rating': 'Calificación',
      'sort_date': 'Fecha',
    },
    'en': {
      //navbar
      'home': 'Home',
      'search': 'Search',
      'profile': 'Profile',
      'settings': 'Settings',

      //home
      'in_theaters': 'In Theaters',
      'popular': 'Popular',

      //búsqueda
      'search_title': 'Search',
      'search_hint': 'Discover your adventure today',
      'search_results': 'Search results',
      'no_results': 'No results found.',

      //detalles
      'cast': 'Cast',
      'unknown': 'Unknown',

      //profile
      'welcome': 'Welcome',
      'see_favorites': 'SEE MY FAVORITES',
      'login': 'LOG IN',
      'logout': 'LOG OUT',
      'logout_success': 'Logged out successful',
      'login_success': 'Logged in successful',
      'login_error': 'Something went wrong when logging in',
      'login_text':
          '¡Keep your favorites\nin one place\nwhen logging into\nyour account!',

      //config
      'dark_mode': 'Dark mode',
      'dark_mode_sub': 'Change to the theme of your preference',
      'language': 'App language',
      'adult_content': 'Hide +18 content',
      'adult_content_sub': 'Filter adult rated movies',
      'about_devs': 'About the developers',
      'about_devs_sub': 'Meet the team behind the app',

      //misc
      'favorites': 'Favorites',
      'top_movies': 'Top Movies',
      'popular_movies': 'Popular Movies',
      'upcoming': 'Upcoming ',
      'upcoming_movies': 'Movies',
      'movie_directory': 'Movie Directory',
      'no_popcorn': 'No popcorn around here...',
      'sort_by': 'Sort by',
      'sort_popular': 'Popular',
      'sort_rating': 'Rating',
      'sort_date': 'Date',
    },
  };

  static String translate(BuildContext context, String key) {
    final isEnglish = Provider.of<SettingsProvider>(context).isEnglish;
    final lang = isEnglish ? 'en' : 'es';
    return _dict[lang]?[key] ?? key;
  }
}
