import 'package:cotufaverse/provider/movies_provider.dart';
import 'package:flutter/material.dart';
import "package:cotufaverse/utils/app_dictionary.dart";
import 'package:provider/provider.dart';

class OrderByDropdownMenu extends StatelessWidget {
  const OrderByDropdownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final MoviesProvider moviesProvider = Provider.of(context, listen: false);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color color = isDarkMode ? Colors.white : const Color(0xFF080B27);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                AppDictionary.translate(context, "sort_by"),
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 20),
            DropdownMenuOrderBy(moviesProvider: moviesProvider),
            const Spacer(),
            ButtonOrderType(moviesProvider: moviesProvider),
          ],
        ),
      ),
    );
  }
}

class ButtonOrderType extends StatefulWidget {
  const ButtonOrderType({super.key, required this.moviesProvider});

  final MoviesProvider moviesProvider;

  @override
  State<ButtonOrderType> createState() => _ButtonOrderTypeState();
}

class _ButtonOrderTypeState extends State<ButtonOrderType> {
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color color = isDarkMode ? Colors.white : const Color(0xFF080B27);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        iconColor: color,
        shape: const CircleBorder(),
        side: BorderSide(color: color, width: 2),
      ),
      onPressed: () {
        setState(() {
          widget.moviesProvider.orderDescDiscover =
              !widget.moviesProvider.orderDescDiscover;
          widget.moviesProvider.newDiscoverOrder();
        });
      },
      child: Icon(
        widget.moviesProvider.orderDescDiscover
            ? Icons.arrow_downward
            : Icons.arrow_upward,
      ),
    );
  }
}

class DropdownMenuOrderBy extends StatefulWidget {
  const DropdownMenuOrderBy({super.key, required this.moviesProvider});

  final MoviesProvider moviesProvider;

  @override
  State<DropdownMenuOrderBy> createState() => _DropdownMenuOrderByState();
}

class _DropdownMenuOrderByState extends State<DropdownMenuOrderBy> {
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color color = isDarkMode ? Colors.white : const Color(0xFF080B27);
    return DropdownMenu<OrderBy>(
      initialSelection: widget.moviesProvider.selectedOrderByDiscover,
      trailingIcon: Icon(Icons.arrow_drop_down, color: color),
      selectedTrailingIcon: Icon(Icons.arrow_drop_up, color: color),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: color, width: 2),
        ),
      ),
      textStyle: TextStyle(color: color),
      requestFocusOnTap: false,
      onSelected: (value) {
        if (value == null) return;
        widget.moviesProvider.selectedOrderByDiscover = value;
        widget.moviesProvider.newDiscoverOrder();
      },
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: OrderBy.popular,
          label: AppDictionary.translate(context, "sort_popular"),
        ),
        DropdownMenuEntry(
          value: OrderBy.score,
          label: AppDictionary.translate(context, "sort_rating"),
        ),
        DropdownMenuEntry(
          value: OrderBy.releaseDate,
          label: AppDictionary.translate(context, "sort_date"),
        ),
      ],
    );
  }
}
