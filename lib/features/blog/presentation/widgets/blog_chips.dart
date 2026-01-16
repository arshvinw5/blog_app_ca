import 'package:ca_blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class BlogChips extends StatelessWidget {
  final List<String>? categories;
  final List<String>? selectedChips;
  final VoidCallback? onUpdate;

  const BlogChips({
    super.key,
    this.categories,
    this.selectedChips,
    this.onUpdate,
  });

  //to get bool value if chips are selectable
  bool get _isSelectable => selectedChips != null && onUpdate != null;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories!
            .map(
              (category) => Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                  onTap: _isSelectable
                      ? () {
                          if (selectedChips!.contains(category)) {
                            selectedChips!.remove(category);
                          } else {
                            selectedChips!.add(category);
                          }
                          onUpdate!();
                        }
                      : null,
                  child: Chip(
                    label: Text(category),
                    color: _isSelectable && selectedChips!.contains(category)
                        ? const WidgetStatePropertyAll(AppPalette.gradient1)
                        : null,
                    side: _isSelectable && selectedChips!.contains(category)
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
