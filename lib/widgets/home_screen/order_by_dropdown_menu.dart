import 'package:flutter/material.dart';
import "package:cotufaverse/utils/app_dictionary.dart";

class OrderByDropdownMenu extends StatelessWidget {
  const OrderByDropdownMenu({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                AppDictionary.translate(context, "sort_by"),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 20),
            const DropdownMenuOrderBy(),
            const Spacer(),
            const ButtonOrderType(),
          ],
        ),
      ),
    );
  }
}

class ButtonOrderType extends StatefulWidget {
  const ButtonOrderType({super.key});

  @override
  State<ButtonOrderType> createState() => _ButtonOrderTypeState();
}

class _ButtonOrderTypeState extends State<ButtonOrderType> {
  bool orderDesc = true;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        iconColor: Colors.white,
        shape: const CircleBorder(),
        side: const BorderSide(color: Colors.white, width: 2),
      ),
      onPressed: () {
        setState(() {
          orderDesc = !orderDesc;
        });
      },
      child: Icon(orderDesc ? Icons.arrow_downward : Icons.arrow_upward),
    );
  }
}

class DropdownMenuOrderBy extends StatefulWidget {
  const DropdownMenuOrderBy({super.key});

  @override
  State<DropdownMenuOrderBy> createState() => _DropdownMenuOrderByState();
}

class _DropdownMenuOrderByState extends State<DropdownMenuOrderBy> {
  @override
  Widget build(BuildContext context) {

    return DropdownMenu<OrderBy>(
      trailingIcon: const Icon(Icons.arrow_drop_down, color: Colors.white),
      selectedTrailingIcon: const Icon(
        Icons.arrow_drop_up,
        color: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
      ),
      initialSelection: OrderBy.popular,
      textStyle: const TextStyle(color: Colors.white),
      requestFocusOnTap: false,
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

enum OrderBy { popular, score, releaseDate }
