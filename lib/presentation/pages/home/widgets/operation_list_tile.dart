import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:debt_tracker/presentation/extensions/text_style_extensions.dart';
import 'package:flutter/material.dart';

class OperationListTile extends StatelessWidget {
  const OperationListTile({
    super.key,
    required this.onTap,
    required this.type,
    required this.operationContactFullName,
    required this.operationContactAvatarUrl,
    required this.operationValue,
  });

  final String operationContactFullName;
  final String operationContactAvatarUrl;
  final double operationValue;

  final VoidCallback onTap;
  final String type;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(operationContactAvatarUrl),
      ),
      subtitle: Text(type),
      trailing: Text(
        operationValue.toStringAsFixed(2),
        style: context.textTheme.bodyLarge?.withColor(
          operationValue.isNegative ? null : context.colors.primary,
        ),
      ),
      title: Text(operationContactFullName),
    );
  }
}
