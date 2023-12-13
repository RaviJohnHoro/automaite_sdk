import 'package:flutter/material.dart';

class SuggestionContainer extends StatelessWidget {
  final List<String> possibleUserResponses;
  final Function(String)? onTap;
  final Color color;

  const SuggestionContainer({
    required this.onTap,
    required this.possibleUserResponses,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: possibleUserResponses
          .map(
            (e) => GestureDetector(
              onTap: onTap == null
                  ? null
                  : () {
                      onTap!(e);
                    },
              child: Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(
                  10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: color,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  e,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
