import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String message;
  const EmptyState(this.message, {super.key});
  @override
  Widget build(BuildContext context) => Center(
    child: Text(message, style: Theme.of(context).textTheme.titleMedium),
  );
}
