import 'package:flutter/material.dart';

bool handleGraphQLErrors(
  BuildContext context, 
  Map<String, dynamic>? result, {
    String? fallbackMessage = 'Произошла ошибка'}) {
  if (hasGraphQLErrors(result)) {
    final message = extractGraphQLError(result);
    
    if (message.contains('You can not have more than one answer for approvement')) {
      showErrorSnackbar(context, 'Вы не можете повторно пройти тест');
    } else if (message.contains('maximum count of clubs')) {
      showErrorSnackbar(context, 'Вы не можете создать больше 3 групп'); 
    } else {
      showErrorSnackbar(context, fallbackMessage ?? message);
    }
    print('[GraphQL Error] $message');
    return true;
  }
  return false;
}

bool hasGraphQLErrors(Map<String, dynamic>? result) {
  return result == null || result['errors'] != null;
}

String extractGraphQLError(Map<String, dynamic>? result) {
  if (result == null) return 'Нет ответа от сервера';

  final errors = result['errors'] as List<dynamic>?;
  if (errors != null && errors.isNotEmpty) {
    final message = errors.first['message'] as String?;
    return message ?? 'Неизвестная ошибка';
  }
  return 'Неизвестная ошибка';
}

void showErrorSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
