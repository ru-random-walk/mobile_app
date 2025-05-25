import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:flutter/material.dart';
import 'package:clubs/utils/qraphql_error_utils.dart';

class GetClubsUseCase {
  final String userId;
  BuildContext context;
  final ClubApiService apiService;

  GetClubsUseCase({
    required this.userId,
    required this.context,
    required this.apiService,
  });

  Future<List<Map<String, dynamic>>> getClubs() async {
    final response = await getUserClubs(userId: userId, apiService: apiService);

    if (context.mounted && handleGraphQLErrors(context, response, fallbackMessage: 'Не удалось загрузить группы')) {
      return [];
    }

    final raw = response?['data']?['getUserClubsWithRole'] ?? [];
    return List<Map<String, dynamic>>.from(raw);
  }

  Future<List<Map<String, dynamic>>> getSearchedClubs({
    required final String query,
    required final int page,
    required final int size,
  }) async {
    final response = await searchClubs(
      queryText: query, 
        page: page, 
        size: size,
        apiService: apiService,
      );

    if (context.mounted && handleGraphQLErrors(context, response, fallbackMessage: 'Не удалось выполнить поиск групп')) {
      return [];
    }

    final raw = response?['data']?['searchClubs'] ?? [];
    return List<Map<String, dynamic>>.from(raw);
  }
}
