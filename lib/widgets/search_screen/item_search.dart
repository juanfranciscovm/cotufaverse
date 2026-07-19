import 'package:flutter/material.dart';
import 'package:cotufaverse/models/models.dart';

class ItemSearch extends StatelessWidget {
  final Movie movie;

  const ItemSearch({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color titleColor = isDark
        ? const Color(0xFFF8F0CC)
        : const Color(0xFF0C123F);
    final Color subtitleColor = isDark
        ? Colors.white54
        : const Color.fromARGB(165, 12, 18, 63);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      leading: Hero(
        tag: movie.heroId,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            movie.fullPosterPath,
            width: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 50,
                color: Colors.white10,
                child: const Icon(Icons.movie, color: Colors.white54),
              );
            },
          ),
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              movie.title,
              style: TextStyle(color: titleColor, fontWeight: FontWeight.bold),
            ),
          ),
          movie.adult
              ? const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.eighteen_up_rating,
                    color: Color.fromARGB(255, 255, 197, 39),
                    size: 16,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      subtitle: Text(
        movie.originalTitle,
        style: TextStyle(color: subtitleColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Color.fromARGB(255, 255, 197, 39),
        size: 16,
      ),
      onTap: () {
        Navigator.pushNamed(context, "/details", arguments: movie);
      },
    );
  }
}
