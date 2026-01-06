import 'package:ca_blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class BlogChips extends StatelessWidget {
  final List<String> selectedChips;
  final VoidCallback onUpdate;

  const BlogChips({
    super.key,
    required this.selectedChips,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ['Technology', 'Health', 'Travel', 'Education', 'Food']
            .map(
              (category) => Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                  onTap: () {
                    if (selectedChips.contains(category)) {
                      selectedChips.remove(category);
                    } else {
                      selectedChips.add(category);
                    }
                    onUpdate();
                  },
                  child: Chip(
                    label: Text(category),
                    color: selectedChips.contains(category)
                        ? const WidgetStatePropertyAll(AppPalette.gradient1)
                        : null,
                    side: selectedChips.contains(category)
                        ? null
                        : const BorderSide(color: AppPalette.borderColor),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
